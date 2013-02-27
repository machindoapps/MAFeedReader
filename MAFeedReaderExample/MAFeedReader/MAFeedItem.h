//
//  MAFeedItem.h
//  MAFeedReaderExample
//
//  Created by David Haynes on 27/02/2013.
//  Copyright (c) 2013 Machindo Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAFeedItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSDate *datePublished;
@property (nonatomic, copy) NSString *bodyText;

-(MAFeedItem *)initWithTitle:(NSString *)title datePublished:(NSDate *)date bodyText:(NSString *)body;

@end
