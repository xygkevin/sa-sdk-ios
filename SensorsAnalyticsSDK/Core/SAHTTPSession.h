//
// SAHTTPSession.h
// SensorsAnalyticsSDK
//
// Created by 张敏超🍎 on 2020/6/19.
// Copyright © 2015-2022 Sensors Data Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SASecurityPolicy.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SAURLSessionTaskCompletionHandler)(NSData * _Nullable data, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error);

@interface SAHTTPSession : NSObject

@property (nonatomic, class, readonly) SAHTTPSession *sharedInstance;

@property (nonatomic, strong) SASecurityPolicy *securityPolicy;

@property (nonatomic, strong, readonly) NSOperationQueue *delegateQueue;

/**
 通过 URLRequest 创建一个 task，并设置完成的回调

 @param request 请求对象
 @param completionHandler 完成回调
 @return 数据 task
 */
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(SAURLSessionTaskCompletionHandler)completionHandler;

/**
 Sets a block to be executed when a connection level authentication challenge has occurred, as handled by the `NSURLSessionDelegate` method `URLSession:didReceiveChallenge:completionHandler:`.

 @param block A block object to be executed when a connection level authentication challenge has occurred. The block returns the disposition of the authentication challenge, and takes three arguments: the session, the authentication challenge, and a pointer to the credential that should be used to resolve the challenge.
 */
- (void)setSessionDidReceiveAuthenticationChallengeBlock:(nullable NSURLSessionAuthChallengeDisposition (^)(NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential * _Nullable __autoreleasing * _Nullable credential))block;

/**
 Sets a block to be executed when a session task has received a request specific authentication challenge, as handled by the `NSURLSessionTaskDelegate` method `URLSession:task:didReceiveChallenge:completionHandler:`.

 @param block A block object to be executed when a session task has received a request specific authentication challenge. The block returns the disposition of the authentication challenge, and takes four arguments: the session, the task, the authentication challenge, and a pointer to the credential that should be used to resolve the challenge.
 */
- (void)setTaskDidReceiveAuthenticationChallengeBlock:(nullable NSURLSessionAuthChallengeDisposition (^)(NSURLSession *session, NSURLSessionTask *task, NSURLAuthenticationChallenge *challenge, NSURLCredential * _Nullable __autoreleasing * _Nullable credential))block;

@end

NS_ASSUME_NONNULL_END
