//
//  SendMessageIntentView.m
//  SiriIntentUI
//
//  Created by kequ on 2021/5/17.
//

#import "SendMessageIntentView.h"

@implementation SendMessageIntentView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (void)setIntent:(INSendMessageIntent *)intent {
    self.backgroundColor = [UIColor redColor];
}

@end
