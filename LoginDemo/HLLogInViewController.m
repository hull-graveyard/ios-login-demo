//
//  HLLogInViewController.m
//  LoginDemo
//
//  Created by Jimmy Oliger on 13/12/2013.
//  Copyright (c) 2013 Hull. All rights reserved.
//

#import "HLLogInViewController.h"

@interface HLLogInViewController ()

@end

@implementation HLLogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [facebookButton setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    [facebookButton setTitle: @"Loading..." forState: UIControlStateDisabled];
    [facebookButton sizeToFit];
    [facebookButton setCenter: self.view.center];
    [facebookButton setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [facebookButton addTarget:self action:@selector(loginWithFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookButton];

}

- (void)loginWithFacebook:(UIButton *)sender
{
    [sender setEnabled:NO];
    
    NSArray *permissions = [NSArray arrayWithObjects:@"email", nil];
    
    if (FBSession.activeSession.isOpen && [FBSession.activeSession.permissions indexOfObject:@"email"] != NSNotFound) {
        [HLUser userFromFacebookAccessToken:FBSession.activeSession.accessTokenData.accessToken];
        [self presentWelcomeView];
    } else {
        [FBSession openActiveSessionWithReadPermissions:permissions
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                          if (error) {
                                              [sender setEnabled:YES];

                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                              message:error.localizedDescription
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil];
                                              [alert show];
                                          } else {
                                              [HLUser userFromFacebookAccessToken:session.accessTokenData.accessToken];
                                              [self presentWelcomeView];
                                          }
                                      }];
    }
}

- (void)presentWelcomeView
{
    HLWelcomeViewController *viewController = [[HLWelcomeViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:true];
}

@end
