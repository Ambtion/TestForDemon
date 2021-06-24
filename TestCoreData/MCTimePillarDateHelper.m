//
//  MCTimePillarDateHelper.m
//  TestCoreData
//
//  Created by kequ on 2021/6/24.
//

#import "MCTimePillarDateHelper.h"

#define kFutureTimeBlank (15) // 时间刻度 15分钟
#define kFutureTimeCount (4) // 一时间刻度

@implementation MCFutureTimeItem
-(NSString *)description {
    NSString *des = @"";
    switch (self.timeType) {
        case kMCFutureItemTimeTypeNone:
            des = @"空白";
            break;
        case kMCFutureItemTimeTypePast:
            des = @"过期";
            break;
        case kMCFutureItemTimeTypeFuture:
            des = @"将来";
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%@ %@ %@", des, self.yhmFormattedString, self.hMinFormattedString];
}

@end

@interface MCTimePillarDateHelper()

@property(nonatomic, strong)NSDateFormatter *hMFromatter;
@property(nonatomic, strong)NSDateFormatter *yhMFromatter;
@property(nonatomic, strong)NSCalendar *calendar;

@end

@implementation MCTimePillarDateHelper

// 不用类方式是为了减少 NSDateFormatter 创建，减少开销
- (NSArray<MCFutureTimeItem *> *)generaFutureTimeModelsWithBaseDate:(NSDate *)baseDate {
    
    // 当前所在天的零点
    NSDate *curDayDate = [self curDayTimeTime:baseDate];
    
    NSString *beginDateStr = [self.hMFromatter stringFromDate:baseDate];
    NSInteger dateBeginIndex = [self getIntervalWithTime:beginDateStr] + 1;
    NSInteger oneDayTimeCount = 24 * 60 / kFutureTimeBlank;
    
    if (dateBeginIndex >= oneDayTimeCount) {
        // 跨过到了第二天
        curDayDate = [self addDays:1 toDate:curDayDate];
        dateBeginIndex = 0;
    }
    
    NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:0];
    
    // 左侧预留空白
    NSInteger spaceCount = 3;
    for (NSInteger i = 0; i < spaceCount - dateBeginIndex; i++) {
        MCFutureTimeItem *item =  [MCFutureTimeItem new];
        item.timeType = kMCFutureItemTimeTypeNone;
        [itemArray addObject:item];
    }
    
    // 遍历所有的刻度
    for (NSInteger i = 0; i < 24 * 60 / kFutureTimeBlank; i++) {
        
        if (i < dateBeginIndex - spaceCount) {
            // 刻度在预留范围外边，使用空白填补
            continue;
        }
     
        MCFutureTimeItem *item =  [MCFutureTimeItem new];
        item.time =  [curDayDate dateByAddingTimeInterval:i * 60 * kFutureTimeBlank];
        item.hMinFormattedString = [self.hMFromatter stringFromDate:item.time];
        item.yhmFormattedString = [self.yhMFromatter stringFromDate:item.time];
        MCFutureItemTimeType type = [item.time earlierDate:baseDate] == item.time ? kMCFutureItemTimeTypePast : kMCFutureItemTimeTypeFuture;
        item.timeType = type;
        [itemArray addObject:item];
    }
    
    return itemArray;

}

#pragma mark -
- (NSDate *)curDayTimeTime:(NSDate *)baseDate {
    
    NSDate *beginDate = baseDate;
    NSDateComponents * compoments = [self dateComponentsFromDate:baseDate];
    compoments.hour = 0;
    compoments.minute = 0;
    compoments.second = 0;
    NSCalendar * calenDar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    beginDate = [calenDar dateFromComponents:compoments];
    return beginDate;
}


- (NSDate *)addDays:(NSInteger)days toDate:(NSDate *)date {
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = days;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
    return nextDate;
}

/// 通过时间获取当前时间在一天中的index
/// 时间转化数字：空为-1 00:00 -> 0  00:15 -> 1 时间 -> 数字
- (NSInteger)getIntervalWithTime:(NSString *)time {
    if (time.length != 5) {
        return -1;
    }
    NSInteger hour = [[time substringToIndex:2] integerValue];
    NSInteger minute = [[time substringFromIndex:3] integerValue];
    
    return hour * 4 + minute / kFutureTimeBlank;
}

- (NSDateComponents *)dateComponentsFromDate:(NSDate *)date {
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:date];
    return components;
}

#pragma mark -
- (NSDateFormatter *)hMFromatter {
    if (!_hMFromatter) {
        _hMFromatter = [[NSDateFormatter alloc] init];
        _hMFromatter.dateFormat = @"HH:mm";
    }
    return _hMFromatter;
}

- (NSDateFormatter *)yhMFromatter {
    if (!_yhMFromatter) {
        _yhMFromatter = [[NSDateFormatter alloc] init];
        _yhMFromatter.dateFormat = @"yyyy-MM-dd-HH-mm";
    }
    return _yhMFromatter;
}

- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[NSCalendar currentCalendar] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        [_calendar setTimeZone: timeZone];
    
    }
    return _calendar;
}
@end
