//
//  HLAppDelegate.m
//  LoginDemo
//
//  Created by Jimmy Oliger on 13/12/2013.
//  Copyright (c) 2013 Hull. All rights reserved.
//

#import "HLAppDelegate.h"

@implementation HLAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *viewController = nil;
    if ([HLUser currentUser]) {
        viewController = [[HLWelcomeViewController alloc] init];
    } else {
        viewController = [[HLLogInViewController alloc] init];
    }
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationController.navigationBarHidden = YES;
    
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
