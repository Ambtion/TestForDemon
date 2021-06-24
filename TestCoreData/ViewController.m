//
//  ViewController.m
//  TestCoreData
//
//  Created by kequ on 2021/1/15.
//

#import "ViewController.h"
#import "MCTimePillarView.h"
#import "MCFutureTimeManager.h"


@interface ViewController ()<MCFutureTimeManagerDataSource>

@property(nonatomic, strong)MCFutureTimeManager *futureTimeManager;

@end


@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.futureTimeManager = [MCFutureTimeManager new];
    self.futureTimeManager.dataSource = self;
    self.futureTimeManager.pillarView.frame = CGRectMake(0, 100, self.futureTimeManager.pillarView.frame.size.width, self.futureTimeManager.pillarView.frame.size.height);
    [self.view addSubview:self.futureTimeManager.pillarView];
    
    NSDate *date = [NSDate date];
//    date = [self curDayTimeTime:date];
//    date = [date dateByAddingTimeInterval:60 * 60 * 24 - 2];
    [self.futureTimeManager resetBaseData:date];
    NSLog(@"%d", [self.futureTimeManager.pillarView indexOfCenterItem]);
    
}

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

- (NSDateComponents *)dateComponentsFromDate:(NSDate *)date {
    
    NSCalendar *calendar =  [[NSCalendar currentCalendar] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:date];
    return components;
}

- (NSTimeInterval)maxDurationinAllData:(MCFutureTimeManager *)manager {
    return 30 * 60;
}

- (NSTimeInterval)minDurationinAllData:(MCFutureTimeManager *)manager {
    return 10 * 60;
}

- (NSTimeInterval)duraionInItem:(MCFutureTimeItem *)item atIndex:(NSUInteger)index manager:(nonnull MCFutureTimeManager *)manager {
    if (index > 10) {
        return 0;
    }
    return  10 + (random() % 20) * 60;
}

- (NSString *)priceInItem:(MCFutureTimeItem *)item atIndex:(NSUInteger)index manager:(MCFutureTimeManager *)manager{
    if (index > 10) {
        return nil;
    }
    return @"$50";
}

@end

