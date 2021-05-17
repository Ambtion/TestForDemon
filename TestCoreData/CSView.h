//
//  CSView.h
//  test
//
//  Created by Ma,Peng on 2018/7/11.
//  Copyright © 2018年 Ma,Peng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CSView : UIView

@property (nonatomic, readonly) UIView *view;

@property (nonatomic, strong) UIColor *shadowColor; // default is "BG22"
@property (nonatomic, assign) CGFloat cornerRadius; // default is 6
@property (nonatomic, assign) CGFloat shadowRadius; // default is 2
@property (nonatomic, assign) CGFloat shadowOpacity; // default is 0.1
@property (nonatomic, assign) CGSize shadowOffset; // default is {0，1}

@end
