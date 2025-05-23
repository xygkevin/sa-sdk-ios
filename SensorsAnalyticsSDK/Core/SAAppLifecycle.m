//
// SAAppLifecycle.m
// SensorsAnalyticsSDK
//
// Created by wenquan on 2021/4/1.
// Copyright © 2015-2022 Sensors Data Co., Ltd. All rights reserved.
//

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag on this file.
#endif

#import "SAAppLifecycle.h"
#import "SALog.h"
#import "SAApplication.h"

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#elif TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#endif

NSNotificationName const kSAAppLifecycleStateWillChangeNotification = @"com.sensorsdata.SAAppLifecycleStateWillChange";
NSNotificationName const kSAAppLifecycleStateDidChangeNotification = @"com.sensorsdata.SAAppLifecycleStateDidChange";
NSString * const kSAAppLifecycleNewStateKey = @"new";
NSString * const kSAAppLifecycleOldStateKey = @"old";

@interface SAAppLifecycle ()

@property (nonatomic, assign) SAAppLifecycleState state;

@end

@implementation SAAppLifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _state = SAAppLifecycleStateInit;

        [self setupListeners];
        [self setupLaunchedState];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupLaunchedState {
    if ([SAApplication isAppExtension]) {
        return;
    }
    dispatch_block_t mainThreadBlock = ^(){
#if TARGET_OS_IOS || TARGET_OS_TV
        UIApplication *application = [SAApplication sharedApplication];
        BOOL isAppStateBackground = application.applicationState == UIApplicationStateBackground;
#elif TARGET_OS_WATCH
        BOOL isAppStateBackground = [WKApplication sharedApplication].applicationState == WKApplicationStateBackground;
#else
        BOOL isAppStateBackground = NO;
#endif
        self.state = isAppStateBackground ? SAAppLifecycleStateStartPassively : SAAppLifecycleStateStart;
    };

    if (@available(iOS 13.0, *)) {
        // iOS 13 及以上在异步主队列的 block 修改状态的原因:
        // 1. 保证在执行启动（被动启动）事件时（动态）公共属性设置完毕（通过监听 UIApplicationDidFinishLaunchingNotification 可以实现）
        // 2. 含有 SceneDelegate 的工程中延迟获取 applicationState 才是准确的（通过监听 UIApplicationDidFinishLaunchingNotification 获取不准确）
        dispatch_async(dispatch_get_main_queue(), mainThreadBlock);
    } else {
        // iOS 13 以下通过监听 UIApplicationDidFinishLaunchingNotification 的通知来处理被动启动和冷启动（非延迟初始化）的情况:
        // 1. iOS 13 以下被动启动时异步主队列的 block 不会执行
        // 2. iOS 13 以下不会含有 SceneDelegate
#if TARGET_OS_IOS
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
#elif TARGET_OS_WATCH
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:WKApplicationDidFinishLaunchingNotification
                                                   object:nil];
#endif
        // 处理 iOS 13 以下（冷启动）延迟初始化的情况
        dispatch_async(dispatch_get_main_queue(), mainThreadBlock);
    }
}

#pragma mark - Setter

- (void)setState:(SAAppLifecycleState)state {
    if (_state == state) {
        return;
    }

    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    userInfo[kSAAppLifecycleNewStateKey] = @(state);
    userInfo[kSAAppLifecycleOldStateKey] = @(_state);

    [[NSNotificationCenter defaultCenter] postNotificationName:kSAAppLifecycleStateWillChangeNotification object:self userInfo:userInfo];

    _state = state;

    [[NSNotificationCenter defaultCenter] postNotificationName:kSAAppLifecycleStateDidChangeNotification object:self userInfo:userInfo];
}

#pragma mark - Listener

- (void)setupListeners {
    // app extension does not need state observer
    if ([SAApplication isAppExtension]) {
        return;
    }

    // 监听 App 启动或结束事件
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
#if TARGET_OS_IOS || TARGET_OS_TV
    [notificationCenter addObserver:self
                           selector:@selector(applicationDidBecomeActive:)
                               name:UIApplicationDidBecomeActiveNotification
                             object:nil];

    [notificationCenter addObserver:self
                           selector:@selector(applicationDidEnterBackground:)
                               name:UIApplicationDidEnterBackgroundNotification
                             object:nil];

    [notificationCenter addObserver:self
                           selector:@selector(applicationWillTerminate:)
                               name:UIApplicationWillTerminateNotification
                        object:nil];
#elif TARGET_OS_WATCH
    [notificationCenter addObserver:self
                           selector:@selector(applicationDidBecomeActive:)
                               name:WKApplicationDidBecomeActiveNotification
                             object:nil];

    [notificationCenter addObserver:self
                           selector:@selector(applicationDidEnterBackground:)
                               name:WKApplicationDidEnterBackgroundNotification
                             object:nil];
#elif TARGET_OS_OSX
    [notificationCenter addObserver:self
                           selector:@selector(applicationDidFinishLaunching:)
                               name:NSApplicationDidFinishLaunchingNotification
                             object:nil];

    // 聚焦活动状态，和其他 App 之前切换聚焦，和 DidResignActive 通知会频繁调用
    [notificationCenter addObserver:self
                           selector:@selector(applicationDidBecomeActive:)
                               name:NSApplicationDidBecomeActiveNotification
                             object:nil];
    // 失焦状态
    [notificationCenter addObserver:self
                           selector:@selector(applicationDidResignActive:)
                               name:NSApplicationDidResignActiveNotification
                             object:nil];

    [notificationCenter addObserver:self
                           selector:@selector(applicationWillTerminate:)
                               name:NSApplicationWillTerminateNotification
                             object:nil];
#endif
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    SALogDebug(@"application did finish launching");

#if TARGET_OS_IOS || TARGET_OS_TV
    UIApplication *application = [SAApplication sharedApplication];
    BOOL isAppStateBackground = application.applicationState == UIApplicationStateBackground;
    self.state = isAppStateBackground ? SAAppLifecycleStateStartPassively : SAAppLifecycleStateStart;
#elif TARGET_OS_WATCH
    BOOL isAppStateBackground = [WKApplication sharedApplication].applicationState == WKApplicationStateBackground;
    self.state = isAppStateBackground ? SAAppLifecycleStateStartPassively : SAAppLifecycleStateStart;
#else
    self.state = SAAppLifecycleStateStart;
#endif
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    SALogDebug(@"application did become active");

#if TARGET_OS_IOS  || TARGET_OS_TV
    // 防止主动触发 UIApplicationDidBecomeActiveNotification
    if (![notification.object isKindOfClass:[UIApplication class]]) {
        return;
    }

    UIApplication *application = (UIApplication *)notification.object;
    if (application.applicationState != UIApplicationStateActive) {
        return;
    }
#elif TARGET_OS_OSX
    if (![notification.object isKindOfClass:[NSApplication class]]) {
        return;
    }

    NSApplication *application = (NSApplication *)notification.object;
    if (!application.isActive) {
        return;
    }
#endif

    self.state = SAAppLifecycleStateStart;
}

#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH
- (void)applicationDidEnterBackground:(NSNotification *)notification {
    SALogDebug(@"application did enter background");

#if TARGET_OS_IOS || TARGET_OS_TV
    // 防止主动触发 UIApplicationDidEnterBackgroundNotification
    if (![notification.object isKindOfClass:[UIApplication class]]) {
        return;
    }

    UIApplication *application = (UIApplication *)notification.object;
    if (application.applicationState != UIApplicationStateBackground) {
        return;
    }
#elif TARGET_OS_WATCH
    if (WKApplication.sharedApplication.applicationState != WKApplicationStateBackground) {
        return;
    }
#endif

    self.state = SAAppLifecycleStateEnd;
}

#elif TARGET_OS_OSX
- (void)applicationDidResignActive:(NSNotification *)notification {
    SALogDebug(@"application did resignActive");

    if (![notification.object isKindOfClass:[NSApplication class]]) {
        return;
    }

    NSApplication *application = (NSApplication *)notification.object;
    if (application.isActive) {
        return;
    }
    self.state = SAAppLifecycleStateEnd;
}
#endif

- (void)applicationWillTerminate:(NSNotification *)notification {
    SALogDebug(@"applicationWillTerminateNotification");

    self.state = SAAppLifecycleStateTerminate;
}

@end

