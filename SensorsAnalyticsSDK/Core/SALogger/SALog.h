//
// SALog.h
// Logger
//
// Created by 陈玉国 on 2019/12/26.
// Copyright © 2015-2022 Sensors Data Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define SENSORS_ANALYTICS_LOG_MACRO(isAsynchronous, lvl, fnct, ctx, frmt, ...) \
[SALog log : isAsynchronous                                     \
     level : lvl                                                \
      file : __FILE__                                           \
  function : fnct                                               \
      line : __LINE__                                           \
   context : ctx                                                \
    format : (frmt), ## __VA_ARGS__]


#define SALogError(frmt, ...)   SENSORS_ANALYTICS_LOG_MACRO(YES, SALogLevelError, __PRETTY_FUNCTION__, 0, frmt, ##__VA_ARGS__)
#define SALogWarn(frmt, ...)   SENSORS_ANALYTICS_LOG_MACRO(YES, SALogLevelWarn, __PRETTY_FUNCTION__, 0, frmt, ##__VA_ARGS__)
#define SALogInfo(frmt, ...)   SENSORS_ANALYTICS_LOG_MACRO(YES, SALogLevelInfo, __PRETTY_FUNCTION__, 0, frmt, ##__VA_ARGS__)
#define SALogDebug(frmt, ...)   SENSORS_ANALYTICS_LOG_MACRO(YES, SALogLevelDebug, __PRETTY_FUNCTION__, 0, frmt, ##__VA_ARGS__)
#define SALogVerbose(frmt, ...)   SENSORS_ANALYTICS_LOG_MACRO(YES, SALogLevelVerbose, __PRETTY_FUNCTION__, 0, frmt, ##__VA_ARGS__)


typedef NS_OPTIONS(NSUInteger, SALogLevel) {
    SALogLevelError = (1 << 0),
    SALogLevelWarn = (1 << 1),
    SALogLevelInfo = (1 << 2),
    SALogLevelDebug = (1 << 3),
    SALogLevelVerbose = (1 << 4)
};


@interface SALog : NSObject

+ (instancetype)sharedLog;

@property (atomic, assign) BOOL enableLog;

+ (void)log:(BOOL)asynchronous
      level:(SALogLevel)level
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
    context:(NSInteger)context
     format:(NSString *)format, ... NS_FORMAT_FUNCTION(7, 8);

- (void)log:(BOOL)asynchronous
   level:(SALogLevel)level
    file:(const char *)file
function:(const char *)function
    line:(NSUInteger)line
 context:(NSInteger)context
  format:(NSString *)format, ... NS_FORMAT_FUNCTION(7, 8);

@end

NS_ASSUME_NONNULL_END
