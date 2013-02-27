//
//  MAFeedReader.h
//  MAFeedReaderExample
//
//  Created by David Haynes on 27/02/2013.
//  Copyright (c) 2013 Machindo Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAFeedReader : NSObject

@property (nonatomic, strong) NSArray *articles;

//Singleton accessor
+(id)sharedReader;



@end
