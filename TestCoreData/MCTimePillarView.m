//
//  BNTimePillarView.m
//  FutureTripDemo
//
//  Created by Liang,Zhiyuan(GIS)2 on 2019/1/25.
//  Copyright © 2019 Liang,Zhiyuan(GIS). All rights reserved.
//

#import "MCTimePillarView.h"

#define BMThemeColor(v) [UIColor redColor]
#define BMThemeCGColor(v) [UIColor greenColor].CGColor

#ifndef BNAVI_ADAPTOR_VALUE_750
#define BNAVI_ADAPTOR_VALUE_750(v) v/2.
#endif


#define BAR_SCROLLView_HEIGHT (float)(BNAVI_ADAPTOR_VALUE_750(300)) //滑动内容高度
#define BAR_LABEL_HEIGHT  (float)(BNAVI_ADAPTOR_VALUE_750(50))  //柱状图底部的label
#define BAR_LABEL2_HEIGHT (float)(BNAVI_ADAPTOR_VALUE_750(50))
//柱状图底部价格的label
#define kBarLabelTopSpace BNAVI_ADAPTOR_VALUE_750(3.5 * 750./185.)

//#define BAR_ANNOTATION_HEIGHT BNAVI_ADAPTOR_VALUE_750(30)

#define BAR_TOP_OFFSET_MUL_FACTOR (1./3)

//bar头部的空间高度，用来容纳标签（x分钟）
#define BAR_ANNOTATION_HEIGHT (BAR_SCROLLView_HEIGHT - BAR_LABEL_HEIGHT) * BAR_TOP_OFFSET_MUL_FACTOR

#define BAR_ANNOTATION_TEXT_HEIGHT BNAVI_ADAPTOR_VALUE_750(36)
#define BAR_ANNOTATION_TEXT_HEIGHT_2LINE BNAVI_ADAPTOR_VALUE_750(56)

#define BAR_LAYER_WIDTH [self barWidth]

#define kBarCountPerScreen 7 //屏幕同时显示的柱子数，需要为奇数，中间的居中

#define kAnnotationTextColorNormal BMThemeColor(@"L31")
#define kAnnotationTextColorFocused BMThemeColor(@"L11")

@implementation MCPillarViewAttributes

@end

@interface MCPillarItemView ()<CAAnimationDelegate>

@property (nonatomic) CAGradientLayer *barLayer;

@property (nonatomic) CATextLayer *textLayer;

@end

@implementation MCPillarItemView



- (instancetype)init{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)setState:(MCPillarItemViewState)state{
    _state = state;
    
    switch (state) {
        case kPillarItemViewStateNormal:
            [self handleNormalState];
            break;
        case kPillarItemViewStateFocused:
            [self handleFocusState];
            break;
        case kPillarItemViewStateInvalid:
            [self handleInvalidState];
            break;
        default:
            break;
    }

}

-(void)handleNormalState{
//    _barLayer.colors = @[(id)[[UIColor colorWithRed:0xc3/255.0f green:0xd6/255.0f blue:0xfd/255.0f alpha:1.0f] CGColor],
//                         (id)[[UIColor colorWithRed:0xe6/255.0f green:0xed/255.0f blue:0xfc/255.0f alpha:1.0f] CGColor]];
    _barLayer.colors = @[(id)BMThemeCGColor(@"BT12"), (id)BMThemeCGColor(@"BT71")];
    _textLayer.foregroundColor = kAnnotationTextColorNormal.CGColor;
}

-(void)handleFocusState{
//    _barLayer.colors = @[(id)(BNAVI_HEXRGBCOLOR(0x3385ff).CGColor),
//                         (id)[[UIColor colorWithRed:0xe6/255.0f green:0xed/255.0f blue:0xfc/255.0f alpha:1.0f] CGColor]];
    _barLayer.colors = @[(id)BMThemeCGColor(@"TG11"), (id)BMThemeCGColor(@"BT12")];
    _textLayer.foregroundColor = kAnnotationTextColorFocused.CGColor;
}

-(void)handleInvalidState{
//    _barLayer.colors = @[(id)[[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f] CGColor],
//                         (id)[[UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f] CGColor]];
//    _barLayer.colors = @[(id)BMThemeCGColor(@"BG121"), (id)BMThemeCGColor(@"BG122")];
    _barLayer.colors = @[(id)[UIColor grayColor].CGColor, (id)[UIColor grayColor].CGColor];

    _textLayer.foregroundColor = kAnnotationTextColorNormal.CGColor;
}


/**
 bar的最大值距离scrollView顶部的距离

 @return <#return value description#>
 */
-(CGFloat)barTopOffset{
//    return BAR_ANNOTATION_HEIGHT;
    return BAR_SCROLLView_HEIGHT * BAR_TOP_OFFSET_MUL_FACTOR;
}

-(CGFloat)barWidth{
    return BNAVI_ADAPTOR_VALUE_750(36);
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    if (self.layer) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
//        CGFloat barHeight = self.frame.size.height * self.value;
        self.barLayer.frame = CGRectMake((self.frame.size.width - BAR_LAYER_WIDTH)/2, BAR_SCROLLView_HEIGHT - self.barLayer.frame.size.height, BAR_LAYER_WIDTH,self.barLayer.frame.size.height );
        CGFloat textHeight = [self textHeight];
        self.textLayer.frame = CGRectMake(0, self.barLayer.frame.origin.y - textHeight, self.frame.size.width, textHeight);
        [CATransaction commit];
    }
}

-(CGFloat)textHeight{
    CGFloat textHeight = BAR_ANNOTATION_TEXT_HEIGHT;
    if ([_annotation containsString:@"\n"]) {
        textHeight = BAR_ANNOTATION_TEXT_HEIGHT_2LINE;
    }
    return textHeight;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)commonInit{
    self.clipsToBounds = YES;
}

-(void)setValue:(CGFloat)value{
    _value = value;
    
    [self.barLayer removeFromSuperlayer];
    
    CGFloat maxHeight = BAR_SCROLLView_HEIGHT;
    CAGradientLayer *barLayer = [CAGradientLayer layer];
    barLayer.startPoint = CGPointMake(0.5, 0);
    barLayer.endPoint = CGPointMake(0.5, 1);
    barLayer.colors = @[(id)BMThemeCGColor(@"BT12"), (id)BMThemeCGColor(@"BT71")];
    CGFloat barHeight = (BAR_SCROLLView_HEIGHT - self.barTopOffset) * value;

    barLayer.frame = CGRectMake((self.frame.size.width - BAR_LAYER_WIDTH)/2, BAR_SCROLLView_HEIGHT - barHeight, BAR_LAYER_WIDTH,barHeight );
    
    [self.layer addSublayer:barLayer];
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(0, barLayer.bounds.size.width/2.0f)];
    [aPath addArcWithCenter:CGPointMake(barLayer.bounds.size.width/2.0f, barLayer.bounds.size.width/2.0f) radius:barLayer.bounds.size.width/2.0f startAngle:M_PI endAngle:0 clockwise:YES];
    [aPath moveToPoint:CGPointMake(barLayer.bounds.size.width, barLayer.bounds.size.width/2.0f)];
    [aPath addLineToPoint:CGPointMake(barLayer.bounds.size.width, maxHeight)];
    [aPath addLineToPoint:CGPointMake(0, maxHeight)];
    [aPath addLineToPoint:CGPointMake(0, barLayer.bounds.size.width/2.0f)];
    [aPath closePath];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = barLayer.bounds;
    maskLayer.path = aPath.CGPath;
    
    barLayer.mask = maskLayer;
    
    self.barLayer = barLayer;
}

-(void)setAnnotation:(NSString *)annotation{
    _annotation = annotation;
    
    [self.textLayer removeFromSuperlayer];
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string  = annotation;
    textLayer.foregroundColor = kAnnotationTextColorNormal.CGColor;
    textLayer.fontSize = BNAVI_ADAPTOR_VALUE_750(20);
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    CGFloat textHeight = [self textHeight];
    
    textLayer.frame = CGRectMake(0, self.barLayer.frame.origin.y -textHeight, self.frame.size.width, textHeight);
    [self.layer addSublayer:textLayer];
    self.textLayer = textLayer;
}

-(void)performRaiseAnimation:(CGFloat)duration{
    
    if (self.state == kPillarItemViewStateFocused) {
        _textLayer.foregroundColor = kAnnotationTextColorFocused.CGColor;
    }
    else {
        _textLayer.foregroundColor = kAnnotationTextColorNormal.CGColor;
    }
    
    CAGradientLayer *barLayer = self.barLayer;
    
    CGFloat barHeight = (BAR_SCROLLView_HEIGHT - self.barTopOffset) * self.value;
    barLayer.frame = CGRectMake((self.frame.size.width - BAR_LAYER_WIDTH)/2, BAR_SCROLLView_HEIGHT, BAR_LAYER_WIDTH,barHeight );
    CGFloat textHeight = [self textHeight];
    self.textLayer.frame = CGRectMake(0, BAR_SCROLLView_HEIGHT -textHeight, self.frame.size.width, textHeight);
        
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    animation.values = @[@(BAR_SCROLLView_HEIGHT + barLayer.frame.size.height/2), @(BAR_SCROLLView_HEIGHT- barLayer.frame.size.height/2)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = duration;
    animation.delegate = self;
    
    [barLayer addAnimation:animation forKey:@"position"];
    
    CAKeyframeAnimation *textAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    textAnimation.values = @[@(BAR_SCROLLView_HEIGHT - self.textLayer.frame.size.height/2), @(BAR_SCROLLView_HEIGHT - barHeight - self.textLayer.frame.size.height/2)];
    textAnimation.timingFunction = animation.timingFunction;
    textAnimation.duration = animation.duration;
    
    [self.textLayer addAnimation:textAnimation forKey:@"position"];
}

- (void)animationDidStart:(CAAnimation *)anim{
    self.frame = self.frame;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    self.frame = self.frame;
}

@end

#pragma mark BNTimePillarView

@class MCTimePillarDashLineView;

@interface MCTimePillarView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray<MCPillarItemView*> *barViewArray;

@property (nonatomic, strong) NSMutableArray<UILabel*> * barLabelArray;

@property (nonatomic, strong) NSMutableArray<UILabel*> * barLabelFocusedArray;

@property (nonatomic, strong) NSMutableArray<UILabel*> *bottomLabelArray;
/**
 scrollview for bars
 */
@property (nonatomic, strong) UIScrollView * scrollView;

/**
 scrollview for title label when focused
 */
@property (nonatomic, strong) UIScrollView * forceLabelScrollView;

@property (nonatomic, strong)UIScrollView *bottomLabelScrollView;

@property (nonatomic) NSInteger lastIndexOfCenterItem;

@property (nonatomic) BOOL isPerfomingGuidingAnimation;

@property (nonatomic) CGPoint contentOffset_beforeGuidingAnimation;

@property (nonatomic, strong) UIView * scrollViewBackgroundShadowView;

@end

@implementation MCTimePillarView

+ (CGFloat)viewHeight {
    return BAR_SCROLLView_HEIGHT + BAR_LABEL2_HEIGHT;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

-(NSMutableArray*)barViewArray{
    if (!_barViewArray) {
        _barViewArray = [NSMutableArray array];
    }
    return _barViewArray;
}

-(NSMutableArray*)barLabelArray{
    if (!_barLabelArray) {
        _barLabelArray = [NSMutableArray array];
    }
    return _barLabelArray;
}

-(NSMutableArray*)barLabelFocusedArray{
    if (!_barLabelFocusedArray) {
        _barLabelFocusedArray = [NSMutableArray array];
    }
    return _barLabelFocusedArray;
}

- (NSMutableArray<UILabel *> *)bottomLabelArray {
    if (!_bottomLabelArray) {
        _bottomLabelArray = [NSMutableArray array];
    }
    return _bottomLabelArray;
}

-(void)commonInit{
    
//    self.backgroundColor = BMThemeColor(@"BG51");
    self.backgroundColor = [UIColor whiteColor];
    self.animationDuration = 0.6;

    //2虚线+1实线
    CGFloat sepLeftSpace = BNAVI_ADAPTOR_VALUE_750(30);
    MCTimePillarDashLineView * dashLineView0 = [[MCTimePillarDashLineView alloc] initWithFrame:CGRectMake(sepLeftSpace, BAR_ANNOTATION_HEIGHT, self.frame.size.width - 2 *sepLeftSpace, 1)];
    CGFloat nextHeight = (BAR_SCROLLView_HEIGHT - BAR_ANNOTATION_HEIGHT - BAR_LABEL_HEIGHT)/2;
    
    MCTimePillarDashLineView * dashLineView1 = [[MCTimePillarDashLineView alloc] initWithFrame:CGRectMake(sepLeftSpace, CGRectGetMaxY(dashLineView0.frame) + nextHeight, self.frame.size.width - 2 * sepLeftSpace, 1)];
    [self addSubview:dashLineView0];
    [self addSubview:dashLineView1];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, BAR_SCROLLView_HEIGHT - BAR_LABEL_HEIGHT, self.frame.size.width, 0.5)];
//    line.backgroundColor = [UIColor colorWithRed:247./255.0f green:247./255.0f blue:247./255.0f alpha:1.0f];
    line.backgroundColor = BMThemeColor(@"SL31");
    
    [self addSubview:line];
    
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - BAR_LABEL_HEIGHT, self.frame.size.width, 0.5)];
//    line.backgroundColor = [UIColor colorWithRed:247./255.0f green:247./255.0f blue:247./255.0f alpha:1.0f];
    line2.backgroundColor = BMThemeColor(@"SL31");
    
    [self addSubview:line2];
    

}

-(void)reloadData{
    [self reloadDataAnimated:YES];
}

-(void)reloadDataAnimated:(BOOL)animated{
    CGPoint scrollViewContentOffset = self.scrollView.contentOffset;
    
    [self initScrollView];
    
    [self initTimeLabelScrollView];
    
    [self initPriceScrollView];
    
    [self rearrangeScrollViewSubviews:YES animated:animated];
    
    self.scrollView.contentOffset = scrollViewContentOffset;
    
    CGPoint alignedContentOffset = [self targetOffsetWithContentOffset:scrollViewContentOffset withVelocity:CGPointZero];
    [self.scrollView setContentOffset:alignedContentOffset animated:YES];
    
    [self didChangePosition];
}

-(void)initScrollView{
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
        [_scrollView removeFromSuperview];
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BAR_SCROLLView_HEIGHT)];
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:_scrollView];
    _scrollView.pagingEnabled = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    NSUInteger barCount = [self.dataSource numberOfItemsInTimePillarView:self];
    
    CGFloat totalScrollSizeWidth = self.widthForMiddleItem + self.widthForItemNotIntheMiddle * (barCount - 1)
    + self.widthForItemNotIntheMiddle * ((int)(kBarCountPerScreen/2));
    _scrollView.contentSize = CGSizeMake(totalScrollSizeWidth, _scrollView.frame.size.height);
}

-(void)initTimeLabelScrollView{
    [_forceLabelScrollView.superview removeFromSuperview];
    [_forceLabelScrollView removeFromSuperview];
    
    _scrollViewBackgroundShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BNAVI_ADAPTOR_VALUE_750(146), BNAVI_ADAPTOR_VALUE_750(48))];
    
//    CGRect itemViewFrame = CGRectMake(barViewLeft, 0, barViewWidth, baseHeight-BAR_LABEL_HEIGHT);
//    CGRect labelFrame = CGRectMake(barViewLeft, CGRectGetMaxY(itemViewFrame) + kBarLabelTopSpace, barViewWidth, BAR_LABEL_HEIGHT - kBarLabelTopSpace);
//
    CGFloat scrollBgViewCenterY =  BAR_SCROLLView_HEIGHT -  BAR_LABEL_HEIGHT + kBarLabelTopSpace + (BAR_LABEL_HEIGHT - kBarLabelTopSpace)/2;
    
//    scrollViewBackgroundShadowView.center = CGPointMake(_scrollView.center.x, CGRectGetMaxY(_scrollView.frame) + scrollViewBackgroundShadowView.frame.size.height/2);
    _scrollViewBackgroundShadowView.center = CGPointMake(_scrollView.center.x, scrollBgViewCenterY);
    
    _scrollViewBackgroundShadowView.backgroundColor = BMThemeColor(@"BG61");
    _scrollViewBackgroundShadowView.layer.cornerRadius = _scrollViewBackgroundShadowView.frame.size.height/2;
    //BNAVI_ADAPTOR_VALUE_750(24);
//    _scrollViewBackgroundShadowView.layer.shadowColor = BNAVI_HEXRGBCOLOR(0x999999).CGColor;
    _scrollViewBackgroundShadowView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
    _scrollViewBackgroundShadowView.layer.shadowOffset = CGSizeMake(1, 1);
    _scrollViewBackgroundShadowView.layer.shadowRadius = 1.5;
    _scrollViewBackgroundShadowView.layer.shadowOpacity = 0.3;
    [self addSubview:_scrollViewBackgroundShadowView];
    
    _forceLabelScrollView = [[UIScrollView alloc] initWithFrame:_scrollViewBackgroundShadowView.bounds];
    _forceLabelScrollView.showsVerticalScrollIndicator = NO;
    _forceLabelScrollView.showsHorizontalScrollIndicator = NO;
    [_scrollViewBackgroundShadowView addSubview:_forceLabelScrollView];
    
    NSUInteger barCount = [self.dataSource numberOfItemsInTimePillarView:self];
    
    CGFloat sizeWidth = _forceLabelScrollView.frame.size.width * barCount;
    _forceLabelScrollView.contentSize = CGSizeMake(sizeWidth, self.frame.size.height);
//    _timeLabelScrollView.backgroundColor = [UIColor whiteColor];
    
//    _timeLabelScrollView.userInteractionEnabled = NO;
}

-(void)initPriceScrollView {
    
    if (self.bottomLabelScrollView) {
        [self.bottomLabelScrollView removeFromSuperview];
    }
    
    CGRect priceFrame = CGRectMake(0,
                                   BAR_SCROLLView_HEIGHT,
                                   self.frame.size.width,
                                   BAR_LABEL2_HEIGHT);
    
    self.bottomLabelScrollView = [[UIScrollView alloc] initWithFrame:priceFrame];
    [self addSubview:self.bottomLabelScrollView];
    
    self.bottomLabelScrollView.pagingEnabled = NO;
    self.bottomLabelScrollView.showsHorizontalScrollIndicator = NO;
    
    NSUInteger barCount = [self.dataSource numberOfItemsInTimePillarView:self];
    
    CGFloat totalScrollSizeWidth = self.widthForMiddleItem + self.widthForItemNotIntheMiddle * (barCount - 1)
    + self.widthForItemNotIntheMiddle * ((int)(kBarCountPerScreen/2));
    self.bottomLabelScrollView.contentSize = CGSizeMake(totalScrollSizeWidth, self.frame.size.height);
    
}

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * target = [super hitTest:point withEvent:event];
    
    if (target == _forceLabelScrollView) {
        return _scrollView;
    }
    
    if (target == _bottomLabelScrollView) {
        return _scrollView;
    }
    
    return target;
}

#pragma  mark KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == _scrollView) {
        if ([keyPath isEqualToString:@"contentOffset"]) {
            CGFloat newContentOffsetX = _scrollView.contentOffset.x * _forceLabelScrollView.frame.size.width / [self widthForItemNotIntheMiddle] + (kBarCountPerScreen/2) * _forceLabelScrollView.frame.size.width;
            [_forceLabelScrollView setContentOffset:CGPointMake(newContentOffsetX , _forceLabelScrollView.contentOffset.y)];
            
            self.bottomLabelScrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0);
        }
    }
}

#pragma mark reload
-(void)reloadDataAtIndices:(NSArray<NSNumber*>*)indices{
    [indices enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger targetIndex = obj.unsignedIntegerValue;
        if (self.barViewArray.count <= targetIndex) {
            *stop = YES;
        }
        else {
            
            MCPillarViewAttributes * viewAttributes = [self.dataSource timePillarView:self attributesForItemAtIndex:targetIndex];
            MCPillarItemView * itemView = self.barViewArray[targetIndex];
            if (itemView.state == kPillarItemViewStateInvalid &&
                viewAttributes.available) {
                //从灰色（无数据）到有数据
                itemView.value = viewAttributes.value;
                if (itemView.value > 1) {
                    itemView.value = 1;
                }
                itemView.annotation = viewAttributes.annotation;
                if (targetIndex == self.indexOfCenterItem) {
                    itemView.state = kPillarItemViewStateFocused;
                }
                else {
                    itemView.state = kPillarItemViewStateNormal;
                }
                
                [itemView 
                 performRaiseAnimation:self.animationDuration];
            }
            else if (itemView.state != kPillarItemViewStateInvalid &&
                     viewAttributes.available) {
                //已经有数据，只要更新高度 精度有点不同，不能用完全等于来判断
                //if(itemView.value != viewAttributes.value){
                if (fabs(itemView.value - viewAttributes.value) > 0.0001){
                    itemView.value = viewAttributes.value;
                    if (itemView.value > 1) {
                        itemView.value = 1;
                    }
                    itemView.annotation = viewAttributes.annotation;
                    if (targetIndex == self.indexOfCenterItem) {
                        itemView.state = kPillarItemViewStateFocused;
                    }
                    else {
                        itemView.state = kPillarItemViewStateNormal;
                    }
                }
            }
        }
    }];
}

-(void)rearrangeScrollViewSubviews:(BOOL)addNew animated:(BOOL)animated {
    
    if (addNew) {
        [self.barViewArray removeAllObjects];
        [self.barLabelArray removeAllObjects];
        [self.barLabelFocusedArray removeAllObjects];
        [self.bottomLabelArray removeAllObjects];
    }
    
    CGFloat baseHeight = BAR_SCROLLView_HEIGHT;
    ////do the magic
    CGFloat contentOffsetX = _scrollView.contentOffset.x;
    
    CGFloat widthNotMidItem = [self widthForItemNotIntheMiddle];
    CGFloat widthMidItem = [self widthForMiddleItem];
    int itemCountOffScreenLeft = (int)(contentOffsetX / widthNotMidItem);
//    int itemNumInMiddleLeft = (itemCountOffScreenLeft + kBarCountPerScreen/2);
    
    NSUInteger itemNumInMiddleLeft = [self indexOfMiddleItem];
    
    CGFloat dLength = (contentOffsetX -  widthNotMidItem* itemCountOffScreenLeft);
    if (contentOffsetX == 0) {
        dLength = 0;
    }
    
    CGFloat widthOfItemInMiddleLeft = widthMidItem + dLength * (1- widthMidItem/widthNotMidItem);
    CGFloat widthOfItemInMiddleRight = widthNotMidItem - dLength * (1- widthMidItem/widthNotMidItem);
    
    /////////
    
    NSUInteger barCount = [self.dataSource numberOfItemsInTimePillarView:self];
    
    CGFloat barViewLeft = 0;
    
//    NSInteger indexOfCenter = self.lastIndexOfCenterItem;
    
    for (int i = 0; i < barCount; i++) {
        MCPillarViewAttributes * viewAttrs = [self.dataSource timePillarView:self attributesForItemAtIndex:i];
        
        if (viewAttrs.value > 1) {
            viewAttrs.value = 1;
        }
        
        CGFloat barViewWidth = 0;
        
        MCPillarItemViewState itemState = kPillarItemViewStateNormal;
        
        if (i == itemNumInMiddleLeft) {
            barViewWidth = widthOfItemInMiddleLeft;
        }
        else if (i == itemNumInMiddleLeft+1) {
            barViewWidth = widthOfItemInMiddleRight;
        }
        else {
            barViewWidth = widthNotMidItem;
        }
        
        CGFloat maxWidth = widthOfItemInMiddleLeft>=widthOfItemInMiddleRight?widthOfItemInMiddleLeft:widthOfItemInMiddleRight;
        if (barViewWidth == maxWidth) {
            itemState = kPillarItemViewStateFocused;
        }
        
        if (!viewAttrs.available) {
            itemState = kPillarItemViewStateInvalid;
        }
        
        //do height
//        CGFloat height =   baseHeight * value;
        CGRect itemViewFrame = CGRectMake(barViewLeft, 0, barViewWidth, baseHeight-BAR_LABEL_HEIGHT);
        CGRect labelFrame = CGRectMake(barViewLeft, CGRectGetMaxY(itemViewFrame) + kBarLabelTopSpace, barViewWidth, BAR_LABEL_HEIGHT - kBarLabelTopSpace);
        
        barViewLeft += barViewWidth;
        
        if (addNew) {
            MCPillarItemView * itemView = [[MCPillarItemView alloc] initWithFrame:itemViewFrame];
            
            [_scrollView addSubview:itemView];
            [_barViewArray addObject:itemView];
            
            itemView.value = viewAttrs.value;
            itemView.state = itemState;
            itemView.annotation = viewAttrs.annotation;
            
            [itemView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapItemView:)]];
            
            if (animated) {
                [itemView performRaiseAnimation:self.animationDuration];
            }
    
            //label
            UILabel * label  = [[UILabel alloc] initWithFrame:labelFrame];
            label.textAlignment = NSTextAlignmentCenter;
            [_scrollView addSubview:label];
            [_barLabelArray addObject:label];
            
            [self updateLabel:label forState:itemState];
            
            label.text = viewAttrs.title;
            
            // BottomLabel
            labelFrame.origin.y = 0;
            labelFrame.size.height = BAR_LABEL2_HEIGHT;
            UILabel * bottomLabel  = [[UILabel alloc] initWithFrame:labelFrame];
            bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self updateLabel:bottomLabel forState:itemState];
            bottomLabel.text = viewAttrs.title2;
            [self.bottomLabelArray addObject:bottomLabel];
            [self.bottomLabelScrollView addSubview:bottomLabel];
            
//            if ([self.dataSource respondsToSelector:@selector(timePillarView:titleAtIndex:forState:)]) {
//                label.text = [self.dataSource timePillarView:self titleAtIndex:i forState:itemState];
//            }
//            else {
//                label.text = item.title;
//            }
            //label focused
            CGFloat focusedWidth = _forceLabelScrollView.frame.size.width;
            CGRect focusedFrame = CGRectMake(focusedWidth * i, 0, focusedWidth, _forceLabelScrollView.frame.size.height);
            UILabel * focusedLabel  = [[UILabel alloc] initWithFrame:focusedFrame];
            focusedLabel.textAlignment = NSTextAlignmentCenter;
            focusedLabel.font = [UIFont boldSystemFontOfSize:BNAVI_ADAPTOR_VALUE_750(6 * 750./185.)];
//            focusedLabel.textColor = BNAVI_HEXRGBCOLOR(0x3385ff);
            focusedLabel.textColor = [UIColor blueColor];
            if ([self.dataSource respondsToSelector:@selector(timePillarView:titleAtIndex:forState:)]) {
                focusedLabel.text = [self.dataSource timePillarView:self titleAtIndex:i forState:kPillarItemViewStateFocused];
            }
            else {
                focusedLabel.text = viewAttrs.title;
            }
            
            [_forceLabelScrollView addSubview:focusedLabel];
            [_barLabelFocusedArray addObject:focusedLabel];
            
            
            
        }
        else {
            
            MCPillarItemView * itemView = [_barViewArray objectAtIndex:i];

            itemView.frame = itemViewFrame;
            itemView.state = itemState;
            
            //这里不更新value，是否合理？
            
            UILabel * label = [_barLabelArray objectAtIndex:i];
            label.frame = labelFrame;
            [self updateLabel:label forState:itemState];
            
            label.text = viewAttrs.title;
            
            UILabel * label2 = [self.bottomLabelArray objectAtIndex:i];
            labelFrame.origin.y = 0;
            label2.frame = labelFrame;
            [self updateLabel:label2 forState:itemState];            
            label2.text = viewAttrs.title2;

        }
        
    }
}

- (void)setTimeLabelHidden:(BOOL)bHidden
{

    for(int i = 0; i < [_barLabelArray count]; i++)
    {
        UILabel *item = _barLabelArray[i];
        item.hidden = bHidden;
    }
    for(int i = 0; i < [_barLabelFocusedArray count]; i++)
    {
        UILabel *item = _barLabelFocusedArray[i];
        item.hidden = bHidden;
    }
    
    _scrollViewBackgroundShadowView.hidden = bHidden;
    if (bHidden)
    {
        _scrollView.scrollEnabled = NO;
        _forceLabelScrollView.scrollEnabled = NO;
    } else
    {
        _scrollView.scrollEnabled = YES;
        _forceLabelScrollView.scrollEnabled = YES;
    }
    
}

-(void)updateLabel:(UILabel*)label forState:(MCPillarItemViewState)state{
    switch (state) {
        case kPillarItemViewStateNormal:
        case kPillarItemViewStateInvalid:
        case kPillarItemViewStateFocused:
        {
            label.font = [UIFont systemFontOfSize:BNAVI_ADAPTOR_VALUE_750(6 * 750./185.)];
            label.textColor = BMThemeColor(@"L31");
        }
            break;
        default:
            break;
    }
    
}
#pragma mark warning

/**
 这个函数貌似有bug，虽然结果是对的

 @return <#return value description#>
 */
-(NSUInteger)indexOfMiddleItem{
    CGFloat contentOffsetX = _scrollView.contentOffset.x;
    
    CGFloat widthNotMidItem = [self widthForItemNotIntheMiddle];
    
    //这个值可能不对，例如46/48 == 0
    int itemCountOffScreenLeft = (int)(contentOffsetX / widthNotMidItem);
    int itemNumInMiddleLeft = (itemCountOffScreenLeft + kBarCountPerScreen/2);
    
    return itemNumInMiddleLeft;
}

-(CGFloat)widthForMiddleItem{
    CGFloat avgWidth = self.frame.size.width/kBarCountPerScreen;
    return avgWidth * 1.4;
}

-(CGFloat)widthForItemNotIntheMiddle{
    CGFloat midWidth = self.widthForMiddleItem;
    return (self.frame.size.width - midWidth)/(kBarCountPerScreen-1);
}

-(void)scrollToIndex:(NSInteger)index animated:(BOOL)animated{
    CGFloat kCellWidth = [self widthForItemNotIntheMiddle];
    CGFloat kCellSpacing = 0;
    
    CGFloat kMaxIndex = [self.dataSource numberOfItemsInTimePillarView:self];
    
    if (index < 0)
        index = 0;
    if (index > kMaxIndex)
        index = kMaxIndex;
    
    CGFloat targetX = (index - kBarCountPerScreen/2) * (kCellWidth + kCellSpacing);
    
    [self.scrollView setContentOffset:CGPointMake(targetX, self.scrollView.contentOffset.y) animated:animated];
    
    if (!animated) {
        self.isScrolling = NO;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"future:scrollViewWillBeginDragging");
    if ([self.delegate respondsToSelector:@selector(timePillarViewWillBeginDragging:)]) {
        [self.delegate timePillarViewWillBeginDragging:self];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"future:scrollViewWillEndDragging");
    CGFloat targetX = scrollView.contentOffset.x + velocity.x * 360.0;
    
    CGFloat kCellWidth = [self widthForItemNotIntheMiddle];
    CGFloat kCellSpacing = 0;

    CGFloat kMaxIndex = [self.dataSource numberOfItemsInTimePillarView:self];
    CGFloat targetIndex = round(targetX / (kCellWidth + kCellSpacing));
    if (targetIndex < 0)
        targetIndex = 0;
    if (targetIndex > kMaxIndex)
        targetIndex = kMaxIndex;
    targetContentOffset->x = targetIndex * (kCellWidth + kCellSpacing);
}

-(CGPoint)targetOffsetWithContentOffset:(CGPoint)contentOffset withVelocity:(CGPoint)velocity{
    CGFloat targetX = contentOffset.x + velocity.x * 360.0;
    
    CGFloat kCellWidth = [self widthForItemNotIntheMiddle];
    CGFloat kCellSpacing = 0;
    
    CGFloat kMaxIndex = [self.dataSource numberOfItemsInTimePillarView:self];
    CGFloat targetIndex = round(targetX / (kCellWidth + kCellSpacing));
    if (targetIndex < 0)
        targetIndex = 0;
    if (targetIndex > kMaxIndex-1)
        targetIndex = kMaxIndex-1;
    CGFloat x = targetIndex * (kCellWidth + kCellSpacing);
    
    CGFloat maxContentOffsetX = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    if(x> maxContentOffsetX){
        x = maxContentOffsetX;
    }
    
    return CGPointMake(x, contentOffset.y);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"future:scrollViewDidScroll");
    self.isScrolling = YES;
    
    [self rearrangeScrollViewSubviews:NO animated:NO];
    
    [self didChangePosition];
    
    if ([self.delegate respondsToSelector:@selector(timePillarViewDidScroll:)]) {
        [self.delegate timePillarViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"future:scrollViewDidEndDecelerating");
    self.isDragged = YES;
    [self scrollViewDidStop];
    self.isDragged = NO;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"future:scrollViewDidEndScrollingAnimation");
    if (!self.isPerfomingGuidingAnimation) {
        [self scrollViewDidStop];
    }
    
    if (self.isPerfomingGuidingAnimation) {
        self.isPerfomingGuidingAnimation = NO;
        if (!self.scrollView.isTracking) {
            NSLog(@"future:!self.scrollView.isTracking");
            [self.scrollView setContentOffset:self.contentOffset_beforeGuidingAnimation animated:YES] ;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"future:scrollViewDidEndDragging");
    if (!decelerate) {
        self.isDragged = YES;
        [self scrollViewDidStop];
        self.isDragged = NO;
    }
}

- (void)scrollViewDidStop{
    self.isScrolling = NO;
    if ([self.delegate respondsToSelector:@selector(timePillarView:didScrollIndexToCenter:)]) {
        [self.delegate timePillarView:self didScrollIndexToCenter:self.indexOfCenterItem];
    }
}

#pragma mark helper function

-(NSUInteger)indexOfCenterItem{

    NSInteger index = (self.scrollView.frame.size.width/2  + self.scrollView.contentOffset.x)/ [self widthForItemNotIntheMiddle];
    
    if (index >= self.barViewArray.count) {
        index = self.barViewArray.count - 1;
    }
    
    if (index < 0 ) {
        index = 0;
    }
    
    return index;
}

-(MCPillarItemView*)itemViewAtIndex:(NSUInteger)index{
    if (self.barViewArray.count == 0) {
        return nil;
    }
    
    if (index >= self.barViewArray.count) {
        return nil;
    }
    
    return self.barViewArray[index];
}
#pragma mark action

-(void)didTapItemView:(UIGestureRecognizer*)gesture{
    
    if (_isDragged)
    {
        return;
    }
    
    MCPillarItemView * targetView = (MCPillarItemView *)gesture.view;
    
    NSInteger index = [self.barViewArray indexOfObject:targetView];
    if (index != NSNotFound) {
        
        if (targetView.state == kPillarItemViewStateFocused
            || index < 3) {
            return;
        } else {
            [self scrollToIndex:index animated:YES];
        }
        
        if ([self.delegate respondsToSelector:@selector(timePillarView:didSelectItemView:atIndex:)]) {
            [self.delegate timePillarView:self didSelectItemView:targetView atIndex:index];
        }
    }
}

/**
 reload后或者didScroll后都会调用这个
 */
-(void)didChangePosition{
    NSInteger indexCenter = self.indexOfCenterItem;
    if (indexCenter != self.lastIndexOfCenterItem) {
        if ([self.delegate respondsToSelector:@selector(timePillarView:didFocusAtIndex:)]) {
            [self.delegate timePillarView:self didFocusAtIndex:indexCenter];
        }
        self.lastIndexOfCenterItem = indexCenter;
    }
}

//#pragma mark guiding animation
//-(void)performGuidingAimation{
//    if (self.scrollView.isTracking) {
////        BN_FUTURE_TRIP_LOG(@"self.scrollView.isTracking, return")
//        return;
//    }
//    CGPoint currentOffset = self.scrollView.contentOffset;
//    self.contentOffset_beforeGuidingAnimation = currentOffset;
//
//    CGPoint targetOffset = CGPointMake(currentOffset.x + [self widthForItemNotIntheMiddle] - 2, currentOffset.y);
//    [self.scrollView setContentOffset:targetOffset animated:YES] ;
//    self.isPerfomingGuidingAnimation = YES;
//}

@end

@implementation MCTimePillarDashLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setBounds:self.bounds];
        [shapeLayer setPosition:CGPointMake(frame.size.width/2, frame.size.height/2)];
        [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
//        [shapeLayer setStrokeColor:[BNAVI_HEXRGBCOLOR(0xdddddd) CGColor]];
        
//        [shapeLayer setStrokeColor:[UIColor colorWithRed:233./255.0f green:233./255.0f blue:233./255.0f alpha:1.0f].CGColor];
        [shapeLayer setStrokeColor:BMThemeCGColor(@"SL11")];
        [shapeLayer setLineWidth:1.0f];
        [shapeLayer setLineJoin:kCALineJoinRound];
        [shapeLayer setLineDashPattern:
         [NSArray arrayWithObjects:[NSNumber numberWithInt:4],
          [NSNumber numberWithInt:3],nil]];
        
        // Setup the path
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0,frame.size.height/2);
        CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height/2);
        
        [shapeLayer setPath:path];
        CGPathRelease(path);
        
        [self.layer addSublayer:shapeLayer];
    }
    
    return self;
}

@end
