//
//  NSString+StripHtml.h
//  MAFeedReader
//
//  Created by David Haynes on 27/02/2013.
//  Copyright (c) 2013 Machindo Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StripHtml)

-(NSString *) stringByStrippingHTML;
-(NSString *) stringByTrimmingLeadingWhitespace;

@end
