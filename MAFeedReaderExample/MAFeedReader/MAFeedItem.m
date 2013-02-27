//
//  MAFeedItem.m
//  MAFeedReaderExample
//
//  Created by David Haynes on 27/02/2013.
//  Copyright (c) 2013 Machindo Apps. All rights reserved.
//

#import "MAFeedItem.h"
#import "NSString+StripHtml.h"

@implementation MAFeedItem

-(MAFeedItem *)initWithTitle:(NSString *)title datePublished:(NSDate *)date bodyText:(NSString *)body {
	self = [super init];
	if(self) {
		_title = title;
		_datePublished = date;
		_bodyText = [body stringByStrippingHTML];
	}
	return self;
}

-(NSString *)description {
	NSString *description = [super description];
	return [description stringByAppendingFormat:@" Title: %@, Date: %@", self.title, [self.datePublished description]];
}

@end
