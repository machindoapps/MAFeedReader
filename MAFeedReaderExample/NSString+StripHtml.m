//
//  NSString+StripHtml.m
//  MAFeedReader
//
//  Created by David Haynes on 27/02/2013.
//  Copyright (c) 2013 Machindo Apps. All rights reserved.
//

#import "NSString+StripHtml.h"

@implementation NSString (StripHtml)

-(NSString *) stringByStrippingHTML {
	NSRange r;
	NSString *s = [self copy];
	
	//remove tags
	while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
		s = [s stringByReplacingCharactersInRange:r withString:@""];
	}
	
	//deal with &nbsp
	while  ((r = [s rangeOfString:@"&nbsp" options:NSRegularExpressionSearch]).location != NSNotFound) {
		s = [s stringByReplacingCharactersInRange:r withString:@" "];
	}
	
	return s;
}

-(NSString*)stringByTrimmingLeadingWhitespace {
    NSInteger i = 0;
	
    while ((i < [self length])
           && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[self characterAtIndex:i]]) {
        i++;
    }
    return [self substringFromIndex:i];
}

@end
