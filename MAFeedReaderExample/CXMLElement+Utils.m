//
//  CXMLElement+Utils.m
//  MAFeedReader
//
//  Created by Developer on 08/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CXMLElement+Utils.h"


@implementation  CXMLElement (CXMLElement_Utils)

-(CXMLElement *)firstElementWithName:(NSString *)name  {
	NSArray *elements = [self elementsForName:name];
	if (elements && [elements count] > 0) {
		return elements[0];
	}
	return nil;
}

@end
