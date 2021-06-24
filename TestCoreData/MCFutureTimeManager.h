//
//  MCFutureTimeManager.h
//  TestCoreData
//
//  Created by kequ on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class MCFutureTimeManager;
@class MCFutureTimeItem;

@protocol MCFutureTimeManagerDataSource <NSObject>

/// 显示的所有柱行图的最大值。用于计算柱行图显示规则,单位秒
- (NSTimeInterval)maxDurationinAllData:(MCFutureTimeManager *)manager;

/// 显示的所有柱行图的最小值。用于计算柱行图显示规则，单位秒
- (NSTimeInterval)minDurationinAllData:(MCFutureTimeManager *)manager;

/// 单位秒
- (NSTimeInterval)duraionInItem:(MCFutureTimeItem *)item
                        atIndex:(NSUInteger)index
                        manager:(MCFutureTimeManager *)manager;

- (NSString *)priceInItem:(MCFutureTimeItem *)item
                  atIndex:(NSUInteger)index
                  manager:(MCFutureTimeManager *)manager;

@end

@protocol MCFutureTimeManagerDelegate <NSObject>
- (void)futureTimeManagerDidSeletedItem:(MCFutureTimeItem *)item
                                atIndex:(NSUInteger)index
                                manager:(MCFutureTimeManager *)manager;

@end

@class MCTimePillarView;

/// <#Description#>
@interface MCFutureTimeManager : NSObject

@property(nonatomic, strong, readonly)MCTimePillarView *pillarView;
@property(nonatomic, weak)id<MCFutureTimeManagerDataSource> dataSource;
@property(nonatomic, weak)id<MCFutureTimeManagerDelegate> delegate;

/// 重新设置基准时间，整体刷新pillarView
/// @param date 基准时间UTC
- (void)resetBaseData:(NSDate *)date;

/// 根据MCFutureTimeItem yhmFormattedString 建立索引，刷新对应的柱行图
/// @param identifys MCFutureTimeItem yhmFormattedString
/// @param animation 是否执行动画
- (void)reloadDataWithItemIdentifys:(NSArray<NSString *> *)identifys
                          animation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
