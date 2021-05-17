//
//  CSView.m
//  test
//
//  Created by Ma,Peng on 2018/7/11.
//  Copyright © 2018年 Ma,Peng. All rights reserved.
//

#import "CSView.h"


@interface CSView ()

@property (nonatomic, strong) UIView *view;

@end


@implementation CSView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self __initUI];
		[self __initData];
    }
    return self;
}

- (UIColor *)backgroundColor {
	return self.view.backgroundColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
	[super setBackgroundColor:UIColor.clearColor];
	self.view.backgroundColor = backgroundColor;
}

#pragma mark - Public

- (void)setShadowColor:(UIColor *)shadowColor {
	_shadowColor = shadowColor;
	self.layer.shadowColor = shadowColor.CGColor;
	[self _refreshShadowPath];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
	_cornerRadius = cornerRadius;
	self.view.layer.cornerRadius = cornerRadius;
	[self _refreshShadowPath];
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
	_shadowRadius = shadowRadius;
	self.layer.shadowRadius = shadowRadius;
	[self _refreshShadowPath];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
	_shadowOpacity = shadowOpacity;
	self.layer.shadowOpacity = shadowOpacity;
	[self _refreshShadowPath];
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    _shadowOffset = shadowOffset;
    self.layer.shadowOffset = shadowOffset;
	[self _refreshShadowPath];
}

- (void)_refreshShadowPath {
	UIBezierPath *path =  [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
	self.layer.shadowPath = path.CGPath;
	
}


#pragma mark - Private
- (void)__initUI {

	[self addSubview:self.view];
//	[self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.edges.mas_equalTo(0);
//	}];
}

- (void)__initData {
//	self.backgroundColor = BMThemeColor(@"BG51");
//	self.shadowColor = BMThemeColor(@"BG22");
	self.shadowOffset = CGSizeMake(0, 1);
	self.shadowOpacity = 0.10;
	self.shadowRadius = 2;
	self.cornerRadius = 6;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.view.frame = self.bounds;
}

#pragma mark - Property

- (UIView *)view {
    if (!_view) {
        _view = [[UIView alloc] initWithFrame:self.bounds];
		_view.layer.masksToBounds = YES;
    }
    return _view;
}

@end
