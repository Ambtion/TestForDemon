////
////  MCColumnSrollView.m
////  TestCoreData
////
////  Created by kequ on 2021/6/23.
////
//
//#import "MCColumnSrollView.h"
//#import "MCDashLineView.h"
//
//#define KTotalHeigh (KColunmHeight)
//
//#define KColunmHeight  150
//#define KColunmTitleHeight 25.f   //柱状图底部第一label,包含在KColunmHeight 中
////#define KColunmBottomHeight 25.f // 柱状图底部第二Label
//
////顶部虚线位置
//#define KTOP_OFFSET_MUL_FACTOR (1./3)
//#define KDashLineTop (KColunmHeight - KColunmTitleHeight) * KTOP_OFFSET_MUL_FACTOR
//
//
//
//#define kBarCountPerScreen 7 //屏幕同时显示的柱子数，需要为奇数，中间的居中
//
//
//@implementation MCColumnItemAttributes
//
//@end
//
//@interface MCColumnSrollView()<UIScrollViewDelegate>
//
//@property(nonatomic, strong)NSMutableArray *colunmViews; // 柱行图容器
//@property(nonatomic, strong)UIScrollView *colunmScrollView; // 柱行图滑动
//@property(nonatomic, strong)NSMutableArray *titleLabelViews; // 柱行图下标题
//
//@property(nonatomic, strong)NSMutableArray *forceLabelViews;
//@property(nonatomic, strong)UIScrollView *forceLabelScrollView; // 聚焦态滑动
//@property(nonatomic, strong)UIView *forceBgView;
//
////@property(nonatomic, strong)NSMutableArray *bottomLabelViews;
////@property(nonatomic, strong)UIScrollView *bottomScrollView;
//
//@property(nonatomic, assign) CGFloat animationDuration;
//
//@end
//
//@implementation MCColumnSrollView
//
//+ (CGFloat)heightForView {
//    return KTotalHeigh;
//}
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self _initUI];
//    }
//    return self;
//}
//
//- (void)dealloc {
//    
//    [self.colunmViews removeObserver:self forKeyPath:@"contentOffset"];
//}
//
//- (void)_initUI {
//    
////    self.backgroundColor = BMThemeColor(@"BG51");
//    self.backgroundColor = [UIColor whiteColor];
//    
//    self.animationDuration = 0.6;
//    {
//        //虚线 + 2 * 实线
//        CGFloat sepLeftSpace = 15.f;
//        CGRect dashFrame = CGRectMake(sepLeftSpace,
//                                      KDashLineTop,
//                                      self.frame.size.width - 2 *sepLeftSpace,
//                                      1);
//        
//        MCDashLineView * dashLineView = [[MCDashLineView alloc] initWithFrame:dashFrame];
//        [self addSubview:dashLineView];
//        
//        
//        CGRect line0Frame = CGRectMake(0,
//                                       KColunmHeight - KColunmTitleHeight,
//                                       self.frame.size.width,
//                                       0.5);
//        
//        UIView * line0 = [[UIView alloc] initWithFrame:line0Frame];
////        line0.backgroundColor = BMThemeColor(@"SL31");
//        line0.backgroundColor = [UIColor redColor];
//        
//        [self addSubview:line0];
//        
//        
//        CGRect line1Frame = CGRectMake(0,
//                                       self.frame.size.height - 0.5,
//                                       self.frame.size.width,
//                                       0.5);
//        
//        UIView * line1 = [[UIView alloc] initWithFrame:line1Frame];
//        line1.backgroundColor = [UIColor redColor];
////        line0.backgroundColor = BMThemeColor(@"SL31");
//        [self addSubview:line1];
//    }
//    
//    {
//        // 柱行图滑动控件
//        CGRect colunmFrame = CGRectMake(0,
//                                        0,
//                                        self.frame.size.width,
//                                        KColunmHeight);
//        self.colunmScrollView = [[UIScrollView alloc] initWithFrame:colunmFrame];
//        self.colunmScrollView.backgroundColor = [UIColor clearColor];
//        [self.colunmScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//        self.colunmScrollView.pagingEnabled = NO;
//        self.colunmScrollView.delegate = self;
//        self.colunmScrollView.showsHorizontalScrollIndicator = NO;
//        [self addSubview:self.colunmScrollView];
//    }
//    
//  
//    {
//        // 放大镜选择
//        self.forceBgView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 73.f, 24.f)];
//        
//        CGFloat scrollBgViewCenterY = (KColunmHeight - KColunmTitleHeight / 2.f);
//        self.forceBgView.center = CGPointMake(CGRectGetMidX(self.colunmScrollView.frame), scrollBgViewCenterY);
//        
//        self.forceBgView.backgroundColor = [UIColor redColor];
//        //        self.forceBgView.backgroundColor = BMThemeColor(@"BG61");
//        self.forceBgView.layer.cornerRadius = self.forceBgView.frame.size.height/2;
//        self.forceBgView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
//        self.forceBgView.layer.shadowOffset = CGSizeMake(1, 1);
//        self.forceBgView.layer.shadowRadius = 1.5;
//        self.forceBgView.layer.shadowOpacity = 0.3;
//        [self addSubview:self.forceBgView];
//        
//        self.forceLabelScrollView = [[UIScrollView alloc] initWithFrame:self.forceBgView.bounds];
//        self.forceLabelScrollView.showsVerticalScrollIndicator = NO;
//        self.forceLabelScrollView.showsHorizontalScrollIndicator = NO;
//        [self.forceBgView addSubview:self.forceLabelScrollView];
//
//    }
//    
////    {
////        // bottomTitle
////        CGRect bottomTileFrame = CGRectMake(0, self.frame.size.height - KColunmBottomHeight, self.frame.size.width, KColunmBottomHeight);
////        self.bottomScrollView = [[UIScrollView alloc] initWithFrame:bottomTileFrame];
////        self.bottomScrollView.showsVerticalScrollIndicator = NO;
////        self.bottomScrollView.showsHorizontalScrollIndicator = NO;
////        [self.bottomScrollView setUserInteractionEnabled:NO];
////        [self addSubview:self.bottomScrollView];
////    }
//}
//
//#pragma mark - ReloadData
//-(void)reloadData{
//    
//    [self reloadDataAnimated:YES];
//}
//
//- (void)reloadDataAnimated:(BOOL)animated{
//    
//    CGPoint scrollViewContentOffset = self.colunmScrollView.contentOffset;
//    
//    [self _refreshScrollViewContentSize];
//    
//    [self rearrangeScrollViewSubviews:YES animated:animated];
////
////    self.scrollView.contentOffset = scrollViewContentOffset;
////
////    CGPoint alignedContentOffset = [self targetOffsetWithContentOffset:scrollViewContentOffset withVelocity:CGPointZero];
////    [self.scrollView setContentOffset:alignedContentOffset animated:YES];
////
////    [self didChangePosition];
//}
//
///// 根据内容刷新
//- (void)_refreshScrollViewContentSize {
//    
//    NSUInteger barCount = [self.dataSource numberOfItemsInColumnSrollView:self];
//    
//    CGFloat totalScrollSizeWidth = self.widthForMiddleItem + self.widthForItemNotIntheMiddle * (barCount - 1);
//    totalScrollSizeWidth += self.widthForItemNotIntheMiddle * ((int)(kBarCountPerScreen/2)); // 尾部补偿
//    
//    self.colunmScrollView.contentSize = CGSizeMake(totalScrollSizeWidth, self.frame.size.height);
//    
////    self.bottomScrollView.contentSize = self.colunmScrollView.contentSize;
//
//    
//    CGFloat sizeWidth = self.forceLabelScrollView.frame.size.width * barCount;
//    self.forceLabelScrollView.contentSize = CGSizeMake(sizeWidth,
//                                                       self.forceLabelScrollView.frame.size.height);
//    
//    
//}
//
//- (void)_removeAllSubViews {
//    [self.colunmViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.colunmViews removeAllObjects];
//    
//    [self.titleLabelViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.titleLabelViews removeAllObjects];
//    
//    [self.forceLabelViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.forceLabelViews removeAllObjects];
//}
//
//-(void)rearrangeScrollViewSubviews:(BOOL)addNew animated:(BOOL)animated{
//    
//    if (addNew) {
//        [self _removeAllSubViews];
//    }
//    
//    
//    CGFloat baseHeight = self.frame.size.height;
//    
//    CGFloat contentOffsetX = self.colunmScrollView.contentOffset.x;
//    
//    CGFloat widthNotMidItem = [self widthForItemNotIntheMiddle];
//    CGFloat widthMidItem = [self widthForMiddleItem];
//    int itemCountOffScreenLeft = (int)(contentOffsetX / widthNotMidItem);
//    
//    NSUInteger itemNumInMiddleLeft = [self indexOfMiddleItem];
//    
//    CGFloat dLength = (contentOffsetX -  widthNotMidItem* itemCountOffScreenLeft);
//    if (contentOffsetX == 0) {
//        dLength = 0;
//    }
//    
//    CGFloat widthOfItemInMiddleLeft = widthMidItem + dLength * (1- widthMidItem/widthNotMidItem);
//    CGFloat widthOfItemInMiddleRight = widthNotMidItem - dLength * (1- widthMidItem/widthNotMidItem);
//    
//    NSUInteger barCount = [self.dataSource numberOfItemsInColumnSrollView:self];
//    
//    CGFloat barViewLeft = 0;
//        
//    for (int i = 0; i < barCount; i++) {
//        MCColumnItemAttributes * viewAttrs = [self.dataSource timePillarView:self attributesForItemAtIndex:i];
//        
//        if (viewAttrs.value > 1) {
//            viewAttrs.value = 1;
//        }
//        
//        CGFloat barViewWidth = 0;
//        
//        kColumItemState itemState = kColumItemStateNormal;
//        
//        if (i == itemNumInMiddleLeft) {
//            barViewWidth = widthOfItemInMiddleLeft;
//        }
//        else if (i == itemNumInMiddleLeft+1) {
//            barViewWidth = widthOfItemInMiddleRight;
//        }
//        else {
//            barViewWidth = widthNotMidItem;
//        }
//        
//        CGFloat maxWidth = widthOfItemInMiddleLeft>=widthOfItemInMiddleRight?widthOfItemInMiddleLeft:widthOfItemInMiddleRight;
//        if (barViewWidth == maxWidth) {
//            itemState = kPillarItemViewStateFocused;
//        }
//        
//        if (!viewAttrs.available) {
//            itemState = kPillarItemViewStateInvalid;
//        }
//        
//        //do height
////        CGFloat height =   baseHeight * value;
//        CGRect itemViewFrame = CGRectMake(barViewLeft, 0, barViewWidth, baseHeight-BAR_LABEL_HEIGHT);
//        CGRect labelFrame = CGRectMake(barViewLeft, CGRectGetMaxY(itemViewFrame) + kBarLabelTopSpace, barViewWidth, BAR_LABEL_HEIGHT - kBarLabelTopSpace);
//        
//        barViewLeft += barViewWidth;
//        
//        if (addNew) {
//            BNPillarItemView * itemView = [[BNPillarItemView alloc] initWithFrame:itemViewFrame];
//            
//            [_scrollView addSubview:itemView];
//            [_barViewArray addObject:itemView];
//            
//            itemView.value = viewAttrs.value;
//            itemView.state = itemState;
//            itemView.annotation = viewAttrs.annotation;
//            
//            [itemView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapItemView:)]];
//            
//            if (animated) {
//                [itemView performRaiseAnimation:self.animationDuration];
//            }
//    
//            //label
//            UILabel * label  = [[UILabel alloc] initWithFrame:labelFrame];
//            label.textAlignment = NSTextAlignmentCenter;
//            [_scrollView addSubview:label];
//            [_barLabelArray addObject:label];
//            
//            [self updateLabel:label forState:itemState];
//            
//            label.text = viewAttrs.title;
////            if ([self.dataSource respondsToSelector:@selector(timePillarView:titleAtIndex:forState:)]) {
////                label.text = [self.dataSource timePillarView:self titleAtIndex:i forState:itemState];
////            }
////            else {
////                label.text = item.title;
////            }
//            //label focused
//            CGFloat focusedWidth = _timeLabelScrollView.frame.size.width;
//            CGRect focusedFrame = CGRectMake(focusedWidth * i, 0, focusedWidth, _timeLabelScrollView.frame.size.height);
//            UILabel * focusedLabel  = [[UILabel alloc] initWithFrame:focusedFrame];
//            focusedLabel.textAlignment = NSTextAlignmentCenter;
//            focusedLabel.font = [UIFont boldSystemFontOfSize:BNAVI_ADAPTOR_VALUE_750(6 * 750./185.)];
//            focusedLabel.textColor = BNAVI_HEXRGBCOLOR(0x3385ff);
//            
//            if ([self.dataSource respondsToSelector:@selector(timePillarView:titleAtIndex:forState:)]) {
//                focusedLabel.text = [self.dataSource timePillarView:self titleAtIndex:i forState:kPillarItemViewStateFocused];
//            }
//            else {
//                focusedLabel.text = viewAttrs.title;
//            }
//            
//            [_timeLabelScrollView addSubview:focusedLabel];
//            [_barLabelFocusedArray addObject:focusedLabel];
//        }
//        else {
//            BNPillarItemView * itemView = [_barViewArray objectAtIndex:i];
//
//            itemView.frame = itemViewFrame;
//            itemView.state = itemState;
//            
//            //这里不更新value，是否合理？
//            
//            UILabel * label = [_barLabelArray objectAtIndex:i];
//            label.frame = labelFrame;
//            [self updateLabel:label forState:itemState];
//            
//            label.text = viewAttrs.title;
//            
//        }
//        
//    }
//}
//
//#pragma mark - 柱行图宽度
//- (CGFloat)widthForMiddleItem{
//    CGFloat avgWidth = self.frame.size.width/kBarCountPerScreen;
//    return avgWidth * 1.4;
//}
//
//- (CGFloat)widthForItemNotIntheMiddle{
//    CGFloat midWidth = self.widthForMiddleItem;
//    return (self.frame.size.width - midWidth)/(kBarCountPerScreen-1);
//}
//
//-(NSUInteger)indexOfMiddleItem {
//    
//    CGFloat contentOffsetX = self.colunmScrollView.contentOffset.x;
//    
//    CGFloat widthNotMidItem = [self widthForItemNotIntheMiddle];
//
//    int itemCountOffScreenLeft = (int)(contentOffsetX / widthNotMidItem);
//    int itemNumInMiddleLeft = (itemCountOffScreenLeft + kBarCountPerScreen/2);
//    
//    return itemNumInMiddleLeft;
//}
//
//#pragma mark - KVO
//
//#pragma mark - 事件传递
//- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    
//    UIView * target = [super hitTest:point withEvent:event];
//    if (target == self.forceLabelScrollView) {
//        return self.colunmScrollView;
//    }
//    return target;
//}
//
//
//#pragma mark - LazyLoad
//- (NSMutableArray *)colunmViews {
//    if (!_colunmViews) {
//        _colunmViews = [NSMutableArray new];
//    }
//    return _colunmViews;
//}
//
//- (NSMutableArray *)titleLabelViews {
//    if (!_titleLabelViews) {
//        _titleLabelViews = [NSMutableArray new];
//    }
//    return _titleLabelViews;
//}
//
//- (NSMutableArray *)forceLabelViews {
//    if (!_forceLabelViews) {
//        _forceLabelViews = [NSMutableArray new];
//    }
//    return _forceLabelViews;
//}
//
////- (NSMutableArray *)bottomLabelViews {
////    if (!_bottomLabelViews) {
////        _bottomLabelViews = [NSMutableArray new];
////    }
////    return _bottomLabelViews;
////}
//
//@end
