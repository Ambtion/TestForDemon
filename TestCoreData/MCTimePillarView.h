//
//  BNTimePillarView.h
//  FutureTripDemo
//
//  Created by Liang,Zhiyuan(GIS)2 on 2019/1/25.
//  Copyright © 2019 Liang,Zhiyuan(GIS). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MCPillarItemViewState){
    kPillarItemViewStateNormal = 0,
    kPillarItemViewStateFocused,
    kPillarItemViewStateInvalid,
};

@interface MCPillarViewAttributes : NSObject

@property (nonatomic) BOOL available;

@property (nonatomic, copy, nullable) NSString *title;

@property (nonatomic) CGFloat value; //range is [0,1]

@property (nonatomic, copy, nullable) NSString *annotation;

@property (nonatomic, copy, nullable) NSString *title2;
@end

@class MCTimePillarView;
@class MCPillarItemView;

@protocol MCTimePillarViewDelegate<NSObject>

@optional
-(void)timePillarView:(MCTimePillarView*)timePillarView didSelectItemView:(MCPillarItemView*)itemView atIndex:(NSUInteger)index;

-(void)timePillarView:(MCTimePillarView*)timePillarView didScrollIndexToCenter:(NSUInteger)index;

- (void)timePillarViewWillBeginDragging:(MCTimePillarView *)pillarView;

- (void)timePillarViewDidScroll:(MCTimePillarView *)pillarView;

-(void)timePillarView:(MCTimePillarView*)timePillarView didFocusAtIndex:(NSUInteger)index;

@end

@protocol MCTimePillarViewDataSource<NSObject>

@required

-(NSUInteger)numberOfItemsInTimePillarView:(MCTimePillarView*)timePillarView;


/**
 <#Description#>

 @param pillarView <#pillarView description#>
 @param index <#index description#>
 @return <#return value description#>
 */
-(MCPillarViewAttributes*)timePillarView:(MCTimePillarView*)pillarView attributesForItemAtIndex:(NSUInteger)index;

-(NSString*)timePillarView:(MCTimePillarView*)pillarView titleAtIndex:(NSUInteger)index forState:(MCPillarItemViewState)state;

//- (NSInteger)indexOfFocusItem;

@end

#pragma mark pillar item view
@interface MCPillarItemView : UIView

@property (nonatomic) MCPillarItemViewState state;

@property (nonatomic) CGFloat value; //柱状图高度值，取值范围0-1

@property (nonatomic) NSString * annotation; //柱状图上方的文字

-(void)performRaiseAnimation:(CGFloat)duration;

//子类返回
-(CGFloat)barTopOffset;

-(CGFloat)barWidth;

@end

#pragma mark dash line
@interface MCTimePillarDashLineView : UIView
@end

#pragma mark main view
@interface MCTimePillarView : UIView

@property (nonatomic, weak) id<MCTimePillarViewDataSource> dataSource;

@property (nonatomic, weak) id<MCTimePillarViewDelegate> delegate;

@property (nonatomic) CGFloat animationDuration;

#pragma mark 手势检测
@property (nonatomic) BOOL isDragged;

@property (nonatomic) BOOL isScrolling;

+ (CGFloat)viewHeight;

#pragma mark reload

-(void)reloadData;

-(void)reloadDataAnimated:(BOOL)animated;

-(void)reloadDataAtIndices:(NSArray<NSNumber*>*)indices
             withAnimation:(BOOL)animation;

-(void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

-(MCPillarItemView*)itemViewAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) NSUInteger indexOfCenterItem;

//guiding animation
//-(void)performGuidingAimation;

//- (void)updateFocusTimeLabel:(NSString*)str;

- (void)setTimeLabelHidden:(BOOL)bHidden;

@end

NS_ASSUME_NONNULL_END
