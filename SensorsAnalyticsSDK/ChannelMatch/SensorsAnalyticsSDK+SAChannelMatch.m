//
// SensorsAnalyticsSDK+SAChannelMatch.m
// SensorsAnalyticsSDK
//
// Created by 张敏超🍎 on 2021/7/2.
// Copyright © 2015-2022 Sensors Data Co., Ltd. All rights reserved.
//

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag on this file.
#endif

#import "SensorsAnalyticsSDK+SAChannelMatch.h"
#import "SensorsAnalyticsSDK+Private.h"
#import "SATrackEventObject.h"
#import "SAModuleManager.h"
#import "SAChannelMatchManager.h"

// 激活事件
static NSString * const kSAEventNameAppInstall = @"$AppInstall";

@interface SensorsAnalyticsSDK ()

@end

@implementation SensorsAnalyticsSDK (SAChannelMatch)

- (void)trackChannelEvent:(NSString *)event {
    [self trackChannelEvent:event properties:nil];
}

- (void)trackChannelEvent:(NSString *)event properties:(nullable NSDictionary *)propertyDict {
    SACustomEventObject *object = [[SACustomEventObject alloc] initWithEventId:event];

    // 入队列前，执行动态公共属性采集 block
    [self buildDynamicSuperProperties];
    dispatch_async(self.serialQueue, ^{
        [SAChannelMatchManager.defaultManager trackChannelWithEventObject:object properties:propertyDict];
    });
}

- (void)trackAppInstall {
    [self trackAppInstallWithProperties:nil];
}

- (void)trackAppInstallWithProperties:(NSDictionary *)properties {
    [self trackAppInstallWithProperties:properties disableCallback:NO];
}

- (void)trackAppInstallWithProperties:(NSDictionary *)properties disableCallback:(BOOL)disableCallback {
    // 入队列前，执行动态公共属性采集 block
    [self buildDynamicSuperProperties];

    dispatch_async(self.serialQueue, ^{
        if (![SAChannelMatchManager.defaultManager isTrackedAppInstallWithDisableCallback:disableCallback]) {
            [SAChannelMatchManager.defaultManager setTrackedAppInstallWithDisableCallback:disableCallback];
            [SAChannelMatchManager.defaultManager trackAppInstall:kSAEventNameAppInstall properties:properties disableCallback:disableCallback];
            [self flush];
        }
    });
}

- (void)trackInstallation:(NSString *)event {
    [self trackInstallation:event withProperties:nil disableCallback:NO];
}

- (void)trackInstallation:(NSString *)event withProperties:(NSDictionary *)propertyDict {
    [self trackInstallation:event withProperties:propertyDict disableCallback:NO];
}

- (void)trackInstallation:(NSString *)event withProperties:(NSDictionary *)properties disableCallback:(BOOL)disableCallback {

    // 入队列前，执行动态公共属性采集 block
    [self buildDynamicSuperProperties];
    dispatch_async(self.serialQueue, ^{
        if (![SAChannelMatchManager.defaultManager isTrackedAppInstallWithDisableCallback:disableCallback]) {
            [SAChannelMatchManager.defaultManager setTrackedAppInstallWithDisableCallback:disableCallback];
            [SAChannelMatchManager.defaultManager trackAppInstall:event properties:properties disableCallback:disableCallback];
            [self flush];
        }
    });
}

@end
