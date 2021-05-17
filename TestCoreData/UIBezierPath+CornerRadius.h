//
//  UIBezierPath+CornerRadius.h
//  TestCoreData
//
//  Created by kequ on 2021/4/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (CornerRadius)


/// 支持四个不同角度圆角的贝塞尔曲线
/// @param rect 矩形大小
/// @param topLeftRadius 左上角角度
/// @param topRightRadius 右上角角度
/// @param bottomLeftRadius 左下角角度
/// @param bottomRightRadius 右下角角度
/*
 * Demon
 UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 300, 100)];
 view.backgroundColor = UIColor.redColor;
 [self.view addSubview:view];
 
 CAShapeLayer *shaLayer = [CAShapeLayer layer];
 shaLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds
								byRoundingCornersTopLeft:CGSizeMake(40, 10)
										  TopRightRadius:CGSizeMake(50, 0) BottomLeft:CGSizeMake(30, 50) BottomRight:CGSizeMake(50, 70)].CGPath;
 
 view.layer.mask = shaLayer;
 
 */
+ (UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect
                   byRoundingCornersTopLeft:(CGSize)topLeftRadius
                             TopRightRadius:(CGSize)topRightRadius
                                 BottomLeft:(CGSize)bottomLeftRadius
                                BottomRight:(CGSize)bottomRightRadius;


@end

NS_ASSUME_NONNULL_END
