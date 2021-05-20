//
//  IntentViewController.m
//  SiriIntentUI
//
//  Created by kequ on 2021/5/17.
//

#import "IntentViewController.h"
#import "SendMessageIntentView.h"
#import <Intents/Intents.h>


// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

@interface IntentViewController () <INUIHostedViewSiriProviding>

@property (nonatomic, strong) SendMessageIntentView *sendMsgView;


@end

@implementation IntentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.sendMsgView];
}


- (SendMessageIntentView *)sendMsgView {
    if (!_sendMsgView) {
        _sendMsgView = [[SendMessageIntentView alloc] initWithFrame:self.view.frame];
        _sendMsgView.hidden = YES;
    }
    return _sendMsgView;
}
    

#pragma mark - INUIHostedViewControlling
//- (void)configureViewForParameters:(NSSet <INParameter *> *)parameters ofInteraction:(INInteraction *)interaction interactiveBehavior:(INUIInteractiveBehavior)interactiveBehavior context:(INUIHostedViewContext)context completion:(void (^)(BOOL success, NSSet <INParameter *> *configuredParameters, CGSize desiredSize))completion {
//    // Do configuration here, including preparing views and calculating a desired size for presentation.
//
//    if (completion) {
//        completion(YES, parameters, CGSizeMake([self desiredSize].width, 280));
//    }
//}

- (void)configureWithInteraction:(INInteraction *)interaction context:(INUIHostedViewContext)context completion:(void (^)(CGSize))completion {
    if ([interaction.intent isKindOfClass:[INSendMessageIntent class]]) {
        // 获取发送消息的意图
        INSendMessageIntent *intent = (INSendMessageIntent *)(interaction.intent);
        self.sendMsgView.intent = intent;
        
    } else {
        return;
    }
    
    if (completion) {
        completion(CGSizeMake([self desiredSize].width, 280));
    }

}

- (CGSize)desiredSize {
    return [self extensionContext].hostedViewMaximumAllowedSize;
}

#pragma mark - INUIHostedViewSiriProviding
// 用代理方法返YES禁止默认的发消息界面
- (BOOL)displaysMessage {
    return YES;
}
  
//// 用代理方法返YES禁止默认的转账的界面
//- (BOOL)displaysPaymentTransaction {
//    return YES;
//}





@end
