////
////  MCColunmItemView.m
////  TestCoreData
////
////  Created by kequ on 2021/6/23.
////
//
//#import "MCColunmItemView.h"
//
//
//@interface MCColunmItemView ()<CAAnimationDelegate>
//
//@property (nonatomic) CAGradientLayer *barLayer;
//
//@property (nonatomic) CATextLayer *textLayer;
//
//@end
//
//@implementation MCColunmItemView
//
//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        [self commonInit];
//    }
//    return self;
//}
//
//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self commonInit];
//    }
//    return self;
//}
//
//-(void)setState:(kPillarItemViewState)state{
//    _state = state;
//    
//    switch (state) {
//        case kPillarItemViewStateNormal:
//            [self handleNormalState];
//            break;
//        case kPillarItemViewStateFocused:
//            [self handleFocusState];
//            break;
//        case kPillarItemViewStateInvalid:
//            [self handleInvalidState];
//            break;
//        default:
//            break;
//    }
//
//}
//
//-(void)handleNormalState{
////    _barLayer.colors = @[(id)[[UIColor colorWithRed:0xc3/255.0f green:0xd6/255.0f blue:0xfd/255.0f alpha:1.0f] CGColor],
////                         (id)[[UIColor colorWithRed:0xe6/255.0f green:0xed/255.0f blue:0xfc/255.0f alpha:1.0f] CGColor]];
//    _barLayer.colors = @[(id)BMThemeCGColor(@"BT12"), (id)BMThemeCGColor(@"BT71")];
//    _textLayer.foregroundColor = kAnnotationTextColorNormal.CGColor;
//}
//
//-(void)handleFocusState{
////    _barLayer.colors = @[(id)(BNAVI_HEXRGBCOLOR(0x3385ff).CGColor),
////                         (id)[[UIColor colorWithRed:0xe6/255.0f green:0xed/255.0f blue:0xfc/255.0f alpha:1.0f] CGColor]];
////    _barLayer.colors = @[(id)BMThemeCGColor(@"TG11"), (id)BMThemeCGColor(@"BT12")];
//    _textLayer.foregroundColor = kAnnotationTextColorFocused.CGColor;
//}
//
//-(void)handleInvalidState{
////    _barLayer.colors = @[(id)[[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f] CGColor],
////                         (id)[[UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f] CGColor]];
//    _barLayer.colors = @[(id)BMThemeCGColor(@"BG121"), (id)BMThemeCGColor(@"BG122")];
//    _textLayer.foregroundColor = kAnnotationTextColorNormal.CGColor;
//}
//
//
///**
// bar的最大值距离scrollView顶部的距离
//
// @return return value description
// */
//-(CGFloat)barTopOffset{
////    return BAR_ANNOTATION_HEIGHT;
//    return self.frame.size.height * BAR_TOP_OFFSET_MUL_FACTOR;
//}
//
//-(CGFloat)barWidth{
//    return BNAVI_ADAPTOR_VALUE_750(36);
//}
//
//-(void)setFrame:(CGRect)frame{
//    [super setFrame:frame];
//    
//    if (self.layer) {
//        [CATransaction begin];
//        [CATransaction setDisableActions:YES];
////        CGFloat barHeight = self.frame.size.height * self.value;
//        self.barLayer.frame = CGRectMake((self.frame.size.width - BAR_LAYER_WIDTH)/2, self.frame.size.height - self.barLayer.frame.size.height, BAR_LAYER_WIDTH,self.barLayer.frame.size.height );
//        CGFloat textHeight = [self textHeight];
//        self.textLayer.frame = CGRectMake(0, self.barLayer.frame.origin.y - textHeight, self.frame.size.width, textHeight);
//        [CATransaction commit];
//    }
//}
//
//-(CGFloat)textHeight{
//    CGFloat textHeight = BAR_ANNOTATION_TEXT_HEIGHT;
//    if ([_annotation containsString:@"\n"]) {
//        textHeight = BAR_ANNOTATION_TEXT_HEIGHT_2LINE;
//    }
//    return textHeight;
//}
//
//-(void)layoutSubviews{
//    [super layoutSubviews];
//}
//
//-(void)commonInit{
//    self.clipsToBounds = YES;
//}
//
//-(void)setValue:(CGFloat)value{
//    _value = value;
//    
//    [self.barLayer removeFromSuperlayer];
//    
//    CGFloat maxHeight = self.frame.size.height;
//    CAGradientLayer *barLayer = [CAGradientLayer layer];
//    barLayer.startPoint = CGPointMake(0.5, 0);
//    barLayer.endPoint = CGPointMake(0.5, 1);
//    barLayer.colors = @[(id)BMThemeCGColor(@"BT12"), (id)BMThemeCGColor(@"BT71")];
//    CGFloat barHeight = (self.frame.size.height - self.barTopOffset) * value;
//
//    barLayer.frame = CGRectMake((self.frame.size.width - BAR_LAYER_WIDTH)/2, self.frame.size.height - barHeight, BAR_LAYER_WIDTH,barHeight );
//    
//    [self.layer addSublayer:barLayer];
//    
//    UIBezierPath* aPath = [UIBezierPath bezierPath];
//    [aPath moveToPoint:CGPointMake(0, barLayer.bounds.size.width/2.0f)];
//    [aPath addArcWithCenter:CGPointMake(barLayer.bounds.size.width/2.0f, barLayer.bounds.size.width/2.0f) radius:barLayer.bounds.size.width/2.0f startAngle:M_PI endAngle:0 clockwise:YES];
//    [aPath moveToPoint:CGPointMake(barLayer.bounds.size.width, barLayer.bounds.size.width/2.0f)];
//    [aPath addLineToPoint:CGPointMake(barLayer.bounds.size.width, maxHeight)];
//    [aPath addLineToPoint:CGPointMake(0, maxHeight)];
//    [aPath addLineToPoint:CGPointMake(0, barLayer.bounds.size.width/2.0f)];
//    [aPath closePath];
//    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = barLayer.bounds;
//    maskLayer.path = aPath.CGPath;
//    
//    barLayer.mask = maskLayer;
//    
//    self.barLayer = barLayer;
//}
//
//-(void)setAnnotation:(NSString *)annotation{
//    _annotation = annotation;
//    
//    [self.textLayer removeFromSuperlayer];
//    
//    CATextLayer *textLayer = [CATextLayer layer];
//    textLayer.string  = annotation;
//    textLayer.foregroundColor = kAnnotationTextColorNormal.CGColor;
//    textLayer.fontSize = BNAVI_ADAPTOR_VALUE_750(20);
//    textLayer.alignmentMode = kCAAlignmentCenter;
//    textLayer.contentsScale = [UIScreen mainScreen].scale;
//    
//    CGFloat textHeight = [self textHeight];
//    
//    textLayer.frame = CGRectMake(0, self.barLayer.frame.origin.y -textHeight, self.frame.size.width, textHeight);
//    [self.layer addSublayer:textLayer];
//    self.textLayer = textLayer;
//}
//
//-(void)performRaiseAnimation:(CGFloat)duration{
//    
//    if (self.state == kPillarItemViewStateFocused) {
//        _textLayer.foregroundColor = kAnnotationTextColorFocused.CGColor;
//    }
//    else {
//        _textLayer.foregroundColor = kAnnotationTextColorNormal.CGColor;
//    }
//    
//    CAGradientLayer *barLayer = self.barLayer;
//    
//    CGFloat barHeight = (self.frame.size.height - self.barTopOffset) * self.value;
//    barLayer.frame = CGRectMake((self.frame.size.width - BAR_LAYER_WIDTH)/2, self.frame.size.height, BAR_LAYER_WIDTH,barHeight );
//    CGFloat textHeight = [self textHeight];
//    self.textLayer.frame = CGRectMake(0, self.frame.size.height -textHeight, self.frame.size.width, textHeight);
//        
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
//    animation.values = @[@(self.frame.size.height + barLayer.frame.size.height/2), @(self.frame.size.height- barLayer.frame.size.height/2)];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.duration = duration;
//    animation.delegate = self;
//    
//    [barLayer addAnimation:animation forKey:@"position"];
//    
//    CAKeyframeAnimation *textAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
//    textAnimation.values = @[@(self.frame.size.height - self.textLayer.frame.size.height/2), @(self.frame.size.height - barHeight - self.textLayer.frame.size.height/2)];
//    textAnimation.timingFunction = animation.timingFunction;
//    textAnimation.duration = animation.duration;
//    
//    [self.textLayer addAnimation:textAnimation forKey:@"position"];
//}
//
//- (void)animationDidStart:(CAAnimation *)anim{
//    self.frame = self.frame;
//}
//
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
////    self.frame = self.frame;
//}
//
//@end
//
