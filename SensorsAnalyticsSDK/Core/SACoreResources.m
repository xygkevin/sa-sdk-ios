//
// SACoreResources.m
// SensorsAnalyticsSDK
//
// Created by 张敏超🍎 on 2023/1/16.
// Copyright © 2015-2023 Sensors Data Co., Ltd. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag on this file.
#endif

#import "SACoreResources.h"
#if __has_include("SACoreResources+English.h")
#import "SACoreResources+English.h"
#endif

@implementation SACoreResources

+ (NSArray *)analyticsFlows {
    return @[@{@"id":@"sensorsdata_track_flow",@"name":@"Track and flush",@"tasks":@[@"dynamic_property",@"serial_queue",@"track_task",@"flush_task",],},@{@"id":@"sensorsdata_flush_flow",@"name":@"Record flush",@"tasks":@[@"serial_queue",@"flush_task",],},@{@"id":@"sensorsdata_ads_flush_flow",@"name":@"SAT Record flush",@"tasks":@[@"serial_queue",@"ads_flush_task",],}];
}

+ (NSArray *)analyticsTasks {
    return @[@{@"id":@"dynamic_property",@"name":@"Build dynamic properties",@"nodes":@[@"dynamic_property",],},@{@"id":@"serial_queue",@"name":@"Switch serialQueue",@"nodes":@[@"serial_queue",],},@{@"id":@"track_task",@"name":@"Track",@"nodes":@[@"remote_config",@"event_validate",@"ID-Mapping",@"correct_userId",@"properties",@"event_callback",@"event_result",@"encrypt",@"insert",],},@{@"id":@"flush_task",@"name":@"Record flush",@"nodes":@[@"can_flush",@"select_records",@"encrypt_records",@"update_records_status",@"flush_json",@"flush_http_body",@"flush",@"serial_queue_sync",@"flush_end",@"repeat_flush",],},
        @{@"id":@"ads_flush_task",@"name":@"SAT Record flush",@"nodes":@[@"can_flush",@"ads_encrypt",@"flush_json",@"flush_http_body",@"flush",],}];
}

+ (NSArray *)analyticsNodes {
    return @[@{@"id":@"dynamic_property",@"name":@"Builder dynamic superProperty",@"interceptor":@"SADynamicSuperPropertyInterceptor",},@{@"id":@"serial_queue",@"name":@"Switch serialQueue",@"interceptor":@"SASerialQueueInterceptor",},@{@"id":@"remote_config",@"name":@"RemoteConfig",@"interceptor":@"SARemoteConfigInterceptor",},@{@"id":@"event_validate",@"name":@"Data verification",@"interceptor":@"SAEventValidateInterceptor",},@{@"id":@"ID-Mapping",@"name":@"ID-Mapping",@"interceptor":@"SAIDMappingInterceptor",},@{@"id":@"correct_userId",@"name":@"CorrectUserInfo",@"interceptor":@"SACorrectUserIdInterceptor",},@{@"id":@"properties",@"name":@"Properties acquisition",@"interceptor":@"SAPropertyInterceptor",},@{@"id":@"event_callback",@"name":@"Callback",@"interceptor":@"SAEventCallbackInterceptor",},@{@"id":@"event_result",@"name":@"Event Result build finish",@"interceptor":@"SAEventResultInterceptor",},@{@"id":@"encrypt",@"name":@"Encryption",@"interceptor":@"SAEncryptInterceptor",},@{@"id":@"insert",@"name":@"InsertRecord",@"interceptor":@"SAInsertRecordInterceptor",},@{@"id":@"serial_queue",@"name":@"Switch serialQueue",@"interceptor":@"SASerialQueueInterceptor",},@{@"id":@"can_flush",@"name":@"Can flush",@"interceptor":@"SACanFlushInterceptor",},@{@"id":@"select_records",@"name":@"Query record",@"interceptor":@"SAQueryRecordInterceptor",},@{@"id":@"encrypt_records",@"name":@"Encrypt record",@"interceptor":@"SAEncryptInterceptor",},@{@"id":@"update_records_status",@"name":@"Update record in database",@"interceptor":@"SAUpdateRecordInterceptor",},@{@"id":@"flush_json",@"name":@"Build flush json",@"interceptor":@"SAFlushJSONInterceptor",},@{@"id":@"flush_http_body",@"name":@"Build flush HTTPBody",@"interceptor":@"SAFlushHTTPBodyInterceptor",},@{@"id":@"flush",@"name":@"flush",@"interceptor":@"SAFlushInterceptor",},@{@"param":@{@"sync":@(1),},@"id":@"serial_queue_sync",@"name":@"Switch serialQueue",@"interceptor":@"SASerialQueueInterceptor",},@{@"id":@"flush_end",@"name":@"Flush end",@"interceptor":@"SADeleteRecordInterceptor",},@{@"id":@"repeat_flush",@"name":@"Repeat flush",@"interceptor":@"SARepeatFlushInterceptor",},
        @{@"id":@"ads_encrypt",@"name":@"Ads Events Encrypt",@"interceptor":@"SAAdsEncryptInterceptor",}];
}

+ (NSDictionary *)defaultLanguageResources {
#if __has_include("SACoreResources+English.h")
    return [self englishLanguageResources];
#else
    return @{@"SADebugMode":@"SDK 调试模式选择",@"SADebugOnly":@"开启调试模式（不导入数据）",@"SADebugAndTrack":@"开启调试模式（导入数据）",@"SADebugOff":@"调试模式已关闭",@"SADebugCurrentlyInDebugOnly":@"当前为调试模式（不导入数据）",@"SADebugCurrentlyInDebugAndTrack":@"当前为调试模式（导入数据）",@"SADebugModeTurnedOff":@"已关闭调试模式，重新扫描二维码开启",@"SADebugOnlyModeTurnedOn":@"开启调试模式，校验数据，但不进行数据导入；\n关闭 App 进程后，将自动关闭调试模式。",@"SADebugAndTrackModeTurnedOn":@"开启调试模式，校验数据，并将数据导入神策分析中；\n关闭 App 进程后，将自动关闭调试模式。",@"SADebugNowInDebugOnlyMode":@"现在您打开了'DEBUG_ONLY'模式，此模式下只校验数据但不导入数据，数据出错时会以提示框的方式提示开发者，请上线前一定关闭。",@"SADebugNowInDebugAndTrackMode":@"现在您打开了'DEBUG_AND_TRACK'模式，此模式下会校验数据并且导入数据，数据出错时会以提示框的方式提示开发者，请上线前一定关闭。",@"SADebugNotes":@"SensorsData 重要提示",@"SAVisualizedAutoTrack":@"可视化全埋点",@"SAVisualizedPageErrorTitle":@"当前页面无法进行可视化全埋点",@"SAVisualizedConfigurationDocument":@"配置文档",@"SAVisualizedConnect":@"正在连接 App 可视化全埋点",@"SAVisualizedWifi":@"，建议在 WiFi 环境下使用",@"SAVisualizedProjectError":@"App 集成的项目与电脑浏览器打开的项目不同，无法进行可视化全埋点",@"SAVisualizedEnableLogHint":@"可视化全埋点进入 Debug 模式，需要开启日志打印用于收集调试信息，退出 Debug 模式关闭日志打印，是否需要开启呢？",@"SAVisualizedEnableLogAction":@"开启日志打印",@"SAVisualizedTemporarilyDisabled":@"暂不开启",@"SAVisualizedWebPageErrorMessage":@"此页面不是 WKWebView，iOS App 内嵌 H5 可视化全埋点，只支持 WKWebView",@"SAVisualizedJSError":@"此页面未集成 Web JS SDK 或者 Web JS SDK 版本过低，请集成最新版 Web JS SDK",@"SAVisualizedSDKError":@"SDK 没有被正确集成，请联系贵方技术人员开启可视化全埋点",@"SAVisualizedParameterError":@"参数错误",@"SAVisualizedFlutterPageErrorMessage":@"此页面未集成 Flutter 全埋点 SDK 或 Flutter 全埋点 SDK 版本过低，请集成最新版 Flutter 全埋点 SDK",@"SAAppClicksAnalyticsConnect":@"正在连接 App 点击分析",@"SAAppClicksAnalyticsSDKError":@"SDK 没有被正确集成，请联系贵方技术人员开启点击分析",@"SAAppClicksAnalyticsProjectError":@"App 集成的项目与电脑浏览器打开的项目不同，无法进行点击分析",@"SAAppClicksAnalyticsPageErrorTitle":@"当前页面无法进行点击分析",@"SAAppClicksAnalyticsPageWebErrorMessage":@"此页面包含 UIWebView，iOS App 内嵌 H5 点击分析，只支持 WKWebView",@"SAAppClicksAnalytics":@"点击分析",@"SARemoteConfigStart":@"开始获取采集控制信息",@"SARemoteConfigObtainFailed":@"远程配置获取失败，请稍后重新扫描二维码",@"SARemoteConfigProjectError":@"App 集成的项目与二维码对应的项目不同，无法进行调试",@"SARemoteConfigOSError":@"App 与二维码对应的操作系统不同，无法进行调试",@"SARemoteConfigAppError":@"当前 App 与二维码对应的 App 不同，无法进行调试",@"SARemoteConfigQRError":@"二维码信息校验失败，请检查采集控制是否配置正确",@"SARemoteConfigNetworkError":@"网络连接失败，请检查设备网络，确认网络畅通后，请重新扫描二维码进行调试",@"SARemoteConfigWrongVersion":@"版本不一致",@"SARemoteConfigLoaded":@"采集控制加载完成，可以通过 Xcode 控制台日志来调试",@"SARemoteConfigCompareVersion":@"获取到采集控制信息的版本：%@，二维码信息的版本：%@，请稍后重新扫描二维码",@"SAEncryptSelectedKeyInvalid":@"密钥验证不通过，所选密钥无效",@"SAEncryptNotEnabled":@"当前 App 未开启加密，请开启加密后再试",@"SAEncryptAppKeyEmpty":@"密钥验证不通过，App 端密钥为空",@"SAEncryptKeyVerificationPassed":@"密钥验证通过，所选密钥与 App 端密钥相同",@"SAEncryptKeyTypeVerificationFailed":@"密钥验证不通过，所选密钥与 App 端密钥不相同。所选密钥对称算法类型：%@，非对称算法类型：%@，App 端对称算法类型：%@，非对称算法类型：%@",@"SAEncryptKeyVersionVerificationFailed":@"密钥验证不通过，所选密钥与 App 端密钥不相同。所选密钥版本：%@，App 端密钥版本：%@",@"SAChannelReconnectError":@"无法重连，请检查是否更换了联调手机",@"SAChannelServerURLError":@"数据接收地址错误，无法使用联调诊断工具",@"SAChannelProjectError":@"App 集成的项目与电脑浏览器打开的项目不同，无法使用联调诊断工具",@"SAChannelEnableJointDebugging":@"即将开启联调模式",@"SAChannelNetworkError":@"当前网络不可用，请检查网络！",@"SAChannelRequestWhitelistFailed":@"添加白名单请求失败，请联系神策技术支持人员排查问题！",@"SAChannelSuccessfullyEnabled":@"成功开启联调模式",@"SAChannelTriggerActivation":@"此模式下不需要卸载 App，点击“激活”按钮可反复触发激活。",@"SAChannelActivate":@"激活",@"SAChannelDeviceCodeEmpty":@"检测到“设备码为空”，可能的原因如下，请排查：",@"SAChannelTroubleshooting":@"\n1.手机系统设置中「隐私->广告-> 限制广告追踪」；\n\n2.若手机系统为 iOS 14 ，请联系研发人员确认 trackAppInstall 接口是否在 “跟踪” 授权之后调用。\n\n排查修复后，请重新扫码进行联调。\n\n",@"SAChannelNetworkException":@"网络异常，请求失败！",@"SADeepLinkCallback":@"未调用 setDeepLinkCompletion 方法设置回调函数",@"SAAlertCancel":@"取消",@"SAAlertContinue":@"继续",@"SAAlertHint":@"提示",@"SAAlertOK":@"确定",@"SAAlertNotRemind":@"不再提示",@"SADeviceWhiteListTitle":@"添加设备白名单",@"SADeviceWhiteListMessageProject":@"设备白名单配置项目与事件上报项目不一致",@"SADeviceWhiteListMessageDeviceType":@"请使用 iOS 设备类型扫码",@"SADeviceWhiteListMessageRequestSuccess":@"请求成功",@"SADeviceWhiteListMessageRequestFailure":@"请求失败，请重新扫码",@"SADynamicSlinkMessageNoNetwork":@"没有检测到网络连接",@"SADynamicSlinkMessageNoTemplateID":@"Slink 模板 ID 缺少",@"SADynamicSlinkMessageNoChannelName":@"渠道名缺少",@"SADynamicSlinkMessageNoAccessToken":@"token 缺少",@"SADynamicSlinkMessageNoProject":@"获取不到数据埋点地址的项目名称",@"SADynamicSlinkMessageNoRedirectURI":@"通用跳转链接缺少",@"SADynamicSlinkMessageNoDomain":@"自定义域名缺少或者填写格式不对",@"SADynamicSlinkMessageResponseError":@"后端返回数据异常"};
#endif
}

@end
