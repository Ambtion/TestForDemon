//
//  MCGradientView.m
//  MCRentCar
//
//  Created by Qu,Ke on 2020/4/24.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import "MCGradientView.h"

@interface MCGradientView ()

@property(nonatomic, strong)CAGradientLayer *gradientLayer;

@end

@implementation MCGradientView

- (void)layoutSubviews {
	[super layoutSubviews];
	[self setUserInteractionEnabled:NO];
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	self.gradientLayer.frame = self.bounds;
	[CATransaction commit];

}

- (void)setGradColors:(NSArray *)colors locations:(NSArray *)locations{
	self.gradientLayer.colors = colors;
	self.gradientLayer.locations = locations;
	[self setNeedsDisplay];
}

- (void)setGradientStart:(CGPoint)start endPoint:(CGPoint)endPoint {
	self.gradientLayer.startPoint = start;
	self.gradientLayer.endPoint = endPoint;
	[self setNeedsDisplay];
}

- (CAGradientLayer *)gradientLayer {
	if (!_gradientLayer) {
		_gradientLayer = [CAGradientLayer layer];
		_gradientLayer.startPoint = CGPointMake(0, 0);
		_gradientLayer.endPoint = CGPointMake(0, 1);
//		_gradientLayer.locations = @[@(0.f), @(0.5f)];
		[self.layer insertSublayer:_gradientLayer atIndex:0];
	}
	return _gradientLayer;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
	self.gradientLayer.cornerRadius = cornerRadius;
	[self setNeedsDisplay];
}

@end
