//
//  SendMessageIntentView.h
//  SiriIntentUI
//
//  Created by kequ on 2021/5/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class INSendMessageIntent;

@interface SendMessageIntentView : UIView

@property (nonatomic, strong) INSendMessageIntent *intent;    //发消息意图

@end

NS_ASSUME_NONNULL_END
