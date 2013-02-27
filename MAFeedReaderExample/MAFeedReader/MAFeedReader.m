//
//  MAFeedReader.m
//  MAFeedReaderExample
//
//  Created by David Haynes on 27/02/2013.
//  Copyright (c) 2013 Machindo Apps. All rights reserved.
//

#import "MAFeedReader.h"

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

#pragma mark - Public methods


@end
