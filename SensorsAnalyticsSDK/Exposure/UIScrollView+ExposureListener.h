//
// UIScrollView+ExposureListener.h
// SensorsAnalyticsSDK
//
// Created by 陈玉国 on 2022/8/15.
// Copyright © 2015-2022 Sensors Data Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SAExposureListener)

- (void)sensorsdata_exposure_setDelegate:(id <UITableViewDelegate>)delegate;

@end

@interface UICollectionView (SAExposureListener)

- (void)sensorsdata_exposure_setDelegate:(id <UICollectionViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
