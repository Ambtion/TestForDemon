//
//  MCFutureTimeManager.m
//  TestCoreData
//
//  Created by kequ on 2021/6/24.
//

#import "MCFutureTimeManager.h"
#import "MCTimePillarView.h"
#import "MCTimePillarDateHelper.h"

@interface MCFutureTimeManager()<MCTimePillarViewDelegate,
                                MCTimePillarViewDataSource>

@property(nonatomic, strong)MCTimePillarView *pillarView;
@property(nonatomic, strong)MCTimePillarDateHelper *dateHelper;

@property(nonatomic, strong)NSArray<MCFutureTimeItem *> *dateArrays;

@property(nonatomic, strong)NSDictionary *hashMapIndex;

@end

@implementation MCFutureTimeManager

#pragma mark - public
- (void)resetBaseData:(NSDate *)date {
    self.dateArrays = [self.dateHelper generaFutureTimeModelsWithBaseDate:date];
    
    self.hashMapIndex = [self _generaHashIndexMap];
    
    for (MCFutureTimeItem * item in self.dateArrays) {
        NSLog(@"%@", [item description]);
    }
    [self.pillarView reloadData];
}

- (void)reloadDataWithItemIdentifys:(NSArray<NSString *> *)identifys animation:(BOOL)animation {
    NSArray <NSNumber *>*indices = [self _converidentifys:identifys];
    if (indices.count) {
        [self.pillarView reloadDataAtIndices:indices
                               withAnimation:animation];

    }
}

- (NSArray<NSNumber *> *)_converidentifys:(NSArray<NSString *> *)identifys {
    
    NSMutableArray *array = [NSMutableArray new];
    for (NSString *identify in identifys) {
        
        if ([self.hashMapIndex objectForKey:identify]) {
            MCFutureTimeItem *item = [self.hashMapIndex objectForKey:identify];
            if ([self.dateArrays containsObject:item]) {
                NSUInteger index = [self.dateArrays indexOfObject:item];
                [array addObject:@(index)];
            }
        }
    }
    
    return [array copy];
}

#pragma mark -

- (NSDictionary *)_generaHashIndexMap {
    
    // 建立hash map 索引，提高查询速度
    NSMutableDictionary *hashIndex = [NSMutableDictionary new];
    for (MCFutureTimeItem *item in self.dateArrays) {
        if (item.yhmFormattedString.length) {
            hashIndex[item.yhmFormattedString] = item;
        }
    }
    return [hashIndex copy];
    
}

#pragma mark - MCTimePillarViewDataSource
- (NSUInteger)numberOfItemsInTimePillarView:(MCTimePillarView *)timePillarView {
    return self.dateArrays.count;
}

- (MCPillarViewAttributes*)timePillarView:(MCTimePillarView*)pillarView attributesForItemAtIndex:(NSUInteger)index {
    MCFutureTimeItem *item = self.dateArrays[index];
    return [self convertToAttributesFromItem:item];
}

#define INVALID_PILLAR_VALUE 0.2  //正常时显示的无数据柱子高度
-(MCPillarViewAttributes*)convertToAttributesFromItem:(MCFutureTimeItem*)item{
    
    MCPillarViewAttributes * viewAttrs = [MCPillarViewAttributes new];
    
    switch (item.timeType) {
        case kMCFutureItemTimeTypeNone:
        {
            viewAttrs.value = 0;
        }
            break;
        case kMCFutureItemTimeTypePast:
        {
            viewAttrs.value = INVALID_PILLAR_VALUE;
            viewAttrs.title = item.hMinFormattedString;
        }
            break;
        case kMCFutureItemTimeTypeFuture:
        {
            NSTimeInterval duration = [self durationAtItem:item];
            
            if (duration > 0) {
                
                viewAttrs.available = YES;
                
                if (self.maxTime > 0) {
                    if (self.maxTime == self.minTime) {
                        viewAttrs.value = (1 + INVALID_PILLAR_VALUE)/2;
                    }
                    else{
                        viewAttrs.value = (1-INVALID_PILLAR_VALUE*2)*(duration - self.minTime)/(self.maxTime - self.minTime) + INVALID_PILLAR_VALUE*2;
                    }
                }
                else {
                    viewAttrs.value = INVALID_PILLAR_VALUE;
                }
            }
            else {
                viewAttrs.value = INVALID_PILLAR_VALUE;
            }
            
            viewAttrs.title = item.hMinFormattedString;
            viewAttrs.title2 = [self priceAtItem:item];
            viewAttrs.annotation = [self timeTextOfDuration:duration];
        }
            break;
        default:
            break;
    }
    
    return viewAttrs;
}

-(NSString*)timeTextOfDuration:(NSTimeInterval)duration{
    int minutes = duration/60;
    int hour = 0;
    if (minutes >= 60) {
        hour = minutes / 60;
        minutes = minutes % 60;
    }
    NSString * text = nil;
    if (minutes != 0 && hour != 0) {
        text = [NSString stringWithFormat:@"%d小时\n%d分钟",hour,minutes];
    }
    else if (minutes != 0) {
        text = [NSString stringWithFormat:@"%d分钟",minutes];
    }
    else if (hour != 0) {
        text = [NSString stringWithFormat:@"%d小时",hour];;
    }
    return text;
}

-(NSString *)timePillarView:(MCTimePillarView *)pillarView titleAtIndex:(NSUInteger)index forState:(MCPillarItemViewState)state {
    
    MCFutureTimeItem *item = self.dateArrays[index];
    
    if (item.timeType == kMCFutureItemTimeTypeNone) {
        return nil;
    }
    
    NSString * ret = nil;

    switch (state) {
        case kPillarItemViewStateInvalid:
        case kPillarItemViewStateNormal:
        {
            ret = item.hMinFormattedString;
        }
            break;
        case kPillarItemViewStateFocused:
        {
            if (item.hMinFormattedString.length > 0) {
                ret = [NSString stringWithFormat:@"%@叫车",item.hMinFormattedString];
            } else {
                ret = @"";
            }
        }
            break;
        default:
            break;
    }
    return ret;
    
}

#pragma mark - MCTimePillarViewDelegate
-(void)timePillarView:(MCTimePillarView *)timePillarView didScrollIndexToCenter:(NSUInteger)index {
    
    if ([self.delegate respondsToSelector:@selector(futureTimeManagerDidSeletedItem:atIndex:manager:)]) {
        [self.delegate futureTimeManagerDidSeletedItem:(MCFutureTimeItem *)self.dateArrays[index] atIndex:index manager:self];
    }
}

- (void)timePillarView:(MCTimePillarView *)timePillarView didFocusAtIndex:(NSUInteger)index {
    
}

- (void)timePillarView:(MCTimePillarView *)timePillarView didSelectItemView:(MCPillarItemView *)itemView atIndex:(NSUInteger)index {
    
}
#pragma mark - Manager DataSource
- (NSTimeInterval)maxTime {
    return [self.dataSource maxDurationinAllData:self];
}

- (NSTimeInterval)minTime {
    return [self.dataSource minDurationinAllData:self];
}

- (NSTimeInterval)durationAtItem:(MCFutureTimeItem *)item {
    return [self.dataSource duraionInItem:item
                                  atIndex:[self.dateArrays indexOfObject:item]
                                  manager:self];
}

- (NSString *)priceAtItem:(MCFutureTimeItem *)item {
    return [self.dataSource priceInItem:item
                                atIndex:[self.dateArrays indexOfObject:item]
                                manager:self];
}

#pragma mark - Get
- (MCTimePillarDateHelper *)dateHelper {
    if (!_dateHelper) {
        _dateHelper = [MCTimePillarDateHelper new];
    }
    return _dateHelper;
}

- (MCTimePillarView *)pillarView {
    if (!_pillarView) {
        _pillarView =  [[MCTimePillarView alloc]
                            initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                     MCTimePillarView.viewHeight)];
        _pillarView.dataSource = self;
        _pillarView.delegate = self;
    }
    return _pillarView;
}

@end
