//
//  HLLogInViewController.h
//  LoginDemo
//
//  Created by Jimmy Oliger on 13/12/2013.
//  Copyright (c) 2013 Hull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "HLUser.h"
#import "HLWelcomeViewController.h"

@interface HLLogInViewController : UIViewController

- (void)loginWithFacebook:(UIButton *)sender;
- (void)presentWelcomeView;

@end
