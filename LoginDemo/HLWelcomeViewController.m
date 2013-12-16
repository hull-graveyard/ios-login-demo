//
//  HLWelcomeViewController.m
//  LoginDemo
//
//  Created by Jimmy Oliger on 13/12/2013.
//  Copyright (c) 2013 Hull. All rights reserved.
//

#import "HLWelcomeViewController.h"

@interface HLWelcomeViewController ()

@end

@implementation HLWelcomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HLUser *user = [HLUser currentUser];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.frame];
    textView.text = [NSString stringWithFormat:@"Name: %@ \nEmail: %@ \nAccess token: %@", user.name, user.email, user.accessToken];
    textView.userInteractionEnabled = NO;
    
    [self.view addSubview:textView];
}

@end
