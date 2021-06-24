//
//  MCTimePillarDateHelper.h
//  TestCoreData
//
//  Created by kequ on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MCFutureItemTimeType) {
    kMCFutureItemTimeTypeNone = 0,  //空白数据
    kMCFutureItemTimeTypePast,      //今天过去时间
    kMCFutureItemTimeTypeFuture,    //今天未来时间
};

@interface MCFutureTimeItem : NSObject

@property (nonatomic, assign) MCFutureItemTimeType timeType;

@property (nonatomic, strong) NSDate *time;

@property (nonatomic, strong) NSString *hMinFormattedString;

/// 年-月-日-时-分格式，用于数据id标识
@property (nonatomic, strong) NSString *yhmFormattedString;

@end

@interface MCTimePillarDateHelper : NSObject

- (NSArray<MCFutureTimeItem *> *)generaFutureTimeModelsWithBaseDate:(NSDate *)baseDate;

@end

NS_ASSUME_NONNULL_END
