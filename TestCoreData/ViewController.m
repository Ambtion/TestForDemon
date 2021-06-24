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
    [self.futureTimeManager resetBaseData:[NSDate date]];
    
    
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

