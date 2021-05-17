//
//  MCGradientView.h
//  MCRentCar
//
//  Created by Qu,Ke on 2020/4/24.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCGradientView : UIImageView

- (void)setGradColors:(NSArray *)colors locations:(NSArray * __nullable)locations;

- (void)setGradientStart:(CGPoint)start endPoint:(CGPoint)endPoint;

- (void)setCornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
