//
// SAVisualizedManager.h
// SensorsAnalyticsSDK
//
// Created by 储强盛 on 2020/12/25.
// Copyright © 2015-2022 Sensors Data Co., Ltd. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SAVisualPropertiesTracker.h"
#import "SAVisualizedEventCheck.h"
#import "SAVisualizedConnection.h"

typedef NS_ENUM(NSInteger, SensorsAnalyticsVisualizedType) {
    SensorsAnalyticsVisualizedTypeUnknown,  // 未知或不允许
    SensorsAnalyticsVisualizedTypeHeatMap, // 点击图
    SensorsAnalyticsVisualizedTypeAutoTrack  //可视化全埋点
};

NS_ASSUME_NONNULL_BEGIN

@interface SAVisualizedManager : NSObject<SAModuleProtocol, SAOpenURLProtocol, SAVisualizedModuleProtocol, SAJavaScriptBridgeModuleProtocol>

+ (instancetype)defaultManager;

@property (nonatomic, assign, getter=isEnable) BOOL enable;
@property (nonatomic, strong) SAConfigOptions *configOptions;

/// 自定义属性采集
@property (nonatomic, strong, readonly) SAVisualPropertiesTracker *visualPropertiesTracker;

/// 当前连接类型
@property (nonatomic, assign, readonly) SensorsAnalyticsVisualizedType visualizedType;

/// 可视化全埋点配置资源
@property (nonatomic, strong, readonly) SAVisualPropertiesConfigSources *configSources;

/// 埋点校验
@property (nonatomic, strong, readonly) SAVisualizedEventCheck *eventCheck;

@property (nonatomic, strong, readonly) SAVisualizedConnection *visualizedConnection;


/// 是否开启埋点校验
- (void)enableEventCheck:(BOOL)enable;

/// 指定页面开启可视化
/// @param controllers  需要开启可视化 ViewController 的类名
- (void)addVisualizeWithViewControllers:(NSArray<NSString *> *)controllers;

/// 判断某个页面是否开启可视化
/// @param viewController 当前页面 viewController
- (BOOL)isVisualizeWithViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
