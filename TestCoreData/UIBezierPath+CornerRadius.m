//
//  UIBezierPath+CornerRadius.m
//  TestCoreData
//
//  Created by kequ on 2021/4/26.
//

#import "UIBezierPath+CornerRadius.h"

@implementation UIBezierPath (CornerRadius)

+ (UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect
                   byRoundingCornersTopLeft:(CGSize)topLeftRadius
                             TopRightRadius:(CGSize)topRightRadius
                                 BottomLeft:(CGSize)bottomLeftRadius
                                BottomRight:(CGSize)bottomRightRadius {
    
    

    
    UIBezierPath *path = [UIBezierPath bezierPath];

    CGPoint topLeft = rect.origin;
    CGPoint topRight = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPoint bottomLeft = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint bottomRight = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    // topLeftRadius
    if (!CGSizeEqualToSize(topLeftRadius, CGSizeZero)) {
        [path moveToPoint:CGPointMake(topLeft.x + topLeftRadius.width, topLeft.y)];
    } else {
        [path moveToPoint:topLeft];
    }

    // topRightRadius
    if (!CGSizeEqualToSize(topRightRadius, CGSizeZero)) {

        [path addLineToPoint:CGPointMake(topRight.x - topRightRadius.width, topRight.y)];
        [path addCurveToPoint:CGPointMake(topRight.x, topRight.y + topRightRadius.height)
                controlPoint1:topRight
                controlPoint2:CGPointMake(topRight.x, topRight.y + topRightRadius.height)];
    } else {

        [path addLineToPoint:topRight];
    }

    // bottomRightRadius
    if (!CGSizeEqualToSize(bottomRightRadius, CGSizeZero)) {

        [path addLineToPoint:CGPointMake(bottomRight.x, bottomRight.y - bottomRightRadius.height)];

        [path addCurveToPoint:CGPointMake(bottomRight.x - bottomRightRadius.width, bottomRight.y)
                controlPoint1:bottomRight
                controlPoint2:CGPointMake(bottomRight.x - bottomRightRadius.width, bottomRight.y)];

    } else {

        [path addLineToPoint:bottomRight];
    }

    if (!CGSizeEqualToSize(bottomLeftRadius, CGSizeZero)) {

        [path addLineToPoint:CGPointMake(bottomLeft.x + bottomLeftRadius.width, bottomLeft.y)];

        [path addCurveToPoint:CGPointMake(bottomLeft.x, bottomLeft.y - bottomLeftRadius.height)
                controlPoint1:bottomLeft
                controlPoint2:CGPointMake(bottomLeft.x, bottomLeft.y - bottomLeftRadius.height)];

    } else {

        [path addLineToPoint:bottomLeft];
    }

    if (!CGSizeEqualToSize(topLeftRadius, CGSizeZero)) {

        [path addLineToPoint:CGPointMake(topLeft.x, topLeft.y + topLeftRadius.height)];

        [path addCurveToPoint:CGPointMake(topLeft.x + topLeftRadius.width, topLeft.y)
                controlPoint1:topLeft
                controlPoint2:CGPointMake(topLeft.x + topLeftRadius.width, topLeft.y)];

    } else {

        [path addLineToPoint:topLeft];
    }
    
    [path fill];
    
    return path;
}

@end
