//
//  HLUser.h
//  LoginDemo
//
//  Created by Jimmy Oliger on 13/12/2013.
//  Copyright (c) 2013 Hull. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *accessToken;

+ (HLUser *)currentUser;
+ (HLUser *)userFromHullAccessToken:(NSString *)token;
+ (HLUser *)userFromFacebookAccessToken:(NSString *)token;

@end
