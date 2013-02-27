//
//  MAFeedReader.m
//  MAFeedReaderExample
//
//  Created by David Haynes on 27/02/2013.
//  Copyright (c) 2013 Machindo Apps. All rights reserved.
//

#import "MAFeedReader.h"
#import "AFNetworking.h"
#import "CXMLElement+Utils.h"
#import "MAFeedItem.h"

static NSString *kMAFeedReaderLastUpdated = @"kMAFeedReaderLastUpdated";

@interface MAFeedReader ()

@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, strong) NSDate *lastUpdated;
@property (nonatomic, assign) NSInteger newArticlesSinceLastUpdate;
@property (nonatomic, copy) void(^completionBlock)(NSArray *array);

@end

@implementation MAFeedReader

#pragma mark - Singleton Methods

+ (id)sharedReader {
    static MAFeedReader *sharedReader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedReader = [[self alloc] init];
    });
    return sharedReader;
}

#pragma mark - public methods

-(NSArray *)getArticles {
	return self.articles;
}

-(NSInteger)getNewArticleCount {
	return self.newArticlesSinceLastUpdate;
}

// Get articles from a given URL, count how many are new and update the time we last checked.
// Fetched articles are stored in the self.articles array.
// Once the network request completes, we call the completion handler if it exists.
-(void)requestNewsArticlesFromFeed:(NSURL *)feedURL {
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:feedURL];
	AFURLConnectionOperation *operation = [[AFURLConnectionOperation alloc] initWithRequest:urlRequest];
	__weak AFURLConnectionOperation *_operation = operation;
	[operation setCompletionBlock:^{
		self.articles = [self translateXMLString:[_operation responseString]];
		
		NSInteger newArticleCount = 0;
		for(MAFeedItem *article in self.articles) {
			if([[[article datePublished] laterDate:self.lastUpdated] isEqualToDate:[article datePublished]]) {
				newArticleCount++;
			}
		}
		self.newArticlesSinceLastUpdate = newArticleCount;
		
		[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:kMAFeedReaderLastUpdated];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		
		if(self.completionBlock) {
			self.completionBlock(self.articles);
		}
	}];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[operation start];
}

-(void)requestNewsArticlesFromFeed:(NSURL *)feedURL withCompletionHandler:(void (^)(NSArray *articles))block {
	if(block) {
		self.completionBlock = block;
	}
	[self requestNewsArticlesFromFeed:feedURL];
}

#pragma mark - internal methods

-(id)init {
	self = [super init];
	if(self) {
		NSDate *lastUpdated = [[NSUserDefaults standardUserDefaults] objectForKey:kMAFeedReaderLastUpdated];
		if(lastUpdated) {
			_lastUpdated = lastUpdated;
		}
	}
	return self;
}

// Return an array of articles for a given RSS xml string
// NB - limited to only return 10 articles
// This is also reliant on the date format matching "EEE, dd MMM yyyy HH:mm:ss ZZZ"
-(NSArray *)translateXMLString:(NSString *)xml {
	NSError *error = nil;
	CXMLDocument *xmlContent = [[CXMLDocument alloc] initWithXMLString:xml options:0 error:&error];
	CXMLElement *root = [xmlContent rootElement];
	CXMLElement *channel = [root firstElementWithName:@"channel"];
	NSArray *results = [channel elementsForName:@"item"];
	NSMutableArray *newsItems = [NSMutableArray array];
	for(CXMLElement *item in results) {
		NSString *title = [[item firstElementWithName:@"title"] stringValue];
		NSString *pubDateString = [[item firstElementWithName:@"pubDate"] stringValue];
		NSString *bodyText = [[item firstElementWithName:@"description"] stringValue];

		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
		NSDate *pubDate = [df dateFromString:pubDateString];
		
		[newsItems addObject:[[MAFeedItem alloc] initWithTitle:title datePublished:pubDate bodyText:bodyText]];
		if([newsItems count] == 10) return newsItems;
	}
	return [[NSArray alloc] initWithArray: newsItems];
}

@end
