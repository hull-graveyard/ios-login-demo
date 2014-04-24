//
//  HLUser.m
//  LoginDemo
//
//  Created by Jimmy Oliger on 13/12/2013.
//  Copyright (c) 2013 Hull. All rights reserved.
//

#import "HLUser.h"

static NSString *const kHLUserAccessTokenKey = @"HLUserAccessToken";
static HLUser *__currentUser = nil;

@implementation HLUser

@synthesize name = _name;
@synthesize email = _email;
@synthesize accessToken = _accessToken;

+ (HLUser *)currentUser
{
    if (!__currentUser) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *token = [userDefaults objectForKey:kHLUserAccessTokenKey];
        if (!token) {
            return nil;
        }
        
        return [HLUser userFromHullAccessToken:token];
    }
    
    return __currentUser;
}

+ (HLUser *)userFromHullAccessToken:(NSString *)token
{
    NSURL *url = [NSURL URLWithString:@"https://hull-demos.hullapp.io/api/v1/me"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"53593c49dee7490ced00071e" forHTTPHeaderField:@"Hull-App-Id"];
    [request setValue:token forHTTPHeaderField:@"Hull-Access-Token"];
    request.HTTPMethod = @"GET";
    
    NSError *error;
    NSURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    __currentUser = [[HLUser alloc] init];
    __currentUser.name = userDictionary[@"name"];
    __currentUser.email = userDictionary[@"email"];
    __currentUser.accessToken = userDictionary[@"access_token"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userDictionary[@"access_token"] forKey:kHLUserAccessTokenKey];
    
    return __currentUser;
}

+ (HLUser *)userFromFacebookAccessToken:(NSString *)token
{
    NSMutableDictionary *tokenDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    [tokenDictionary setObject:token forKey:@"access_token"];
    NSMutableDictionary *paramsDictionary= [NSMutableDictionary dictionaryWithCapacity:1];
    [paramsDictionary setObject:tokenDictionary forKey:@"facebook"];
    
    NSError *jsonSerializationError = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:paramsDictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&jsonSerializationError];
    
    
    if(jsonSerializationError) {
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:@"https://hull-demos.hullapp.io/api/v1/users"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"53593c49dee7490ced00071e" forHTTPHeaderField:@"Hull-App-Id"];
    request.HTTPMethod = @"POST";
    request.HTTPBody = json;
    
    NSError *error;
    NSURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    __currentUser = [[HLUser alloc] init];
    __currentUser.name = userDictionary[@"name"];
    __currentUser.email = userDictionary[@"email"];
    __currentUser.accessToken = userDictionary[@"access_token"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userDictionary[@"access_token"] forKey:kHLUserAccessTokenKey];
    
    return __currentUser;
}

@end