//
//  AppDelegate.m
//  MAFeedReaderExample
//
//  Created by David Haynes on 27/02/2013.
//  Copyright (c) 2013 Machindo Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "MAFeedReader.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSURL *feedURL = [NSURL URLWithString:@"http://www.nexus.org.uk/news.xml"];
	[[MAFeedReader sharedReader] requestNewsArticlesFromFeed:feedURL];
	
	return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
