//
//  MAFeedReader.h
//  MAFeedReaderExample
//
//  Created by David Haynes on 27/02/2013.
//  Copyright (c) 2013 Machindo Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAFeedReader : NSObject


//Singleton accessor
+(id)sharedReader;

-(void)requestNewsArticlesFromFeed:(NSURL *)feedURL;
-(void)requestNewsArticlesFromFeed:(NSURL *)feedURL withCompletionHandler:(void (^)(NSArray *articles))block;
-(NSArray *)getArticles;
-(NSInteger)getNewArticleCount;

@end
