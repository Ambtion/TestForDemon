//
//  SendMessageHandler.m
//  SiriExtentIntent
//
//  Created by kequ on 2021/5/17.
//

#import "SendMessageHandler.h"

@interface SendMessageHandler () <INSendMessageIntentHandling>

@end

@implementation SendMessageHandler

/// Resolve阶段, 分析消息发送主体
- (void)resolveRecipientsForSendMessage:(INSendMessageIntent *)intent with:(void (^)(NSArray<INSendMessageRecipientResolutionResult *> *resolutionResults))completion {
    NSArray<INPerson *> *recipients = intent.recipients;
    // If no recipients were provided we'll need to prompt for a value.
    if (recipients.count == 0) {
        completion(@[[INSendMessageRecipientResolutionResult needsValue]]);
        return;
    }
    NSMutableArray<INSendMessageRecipientResolutionResult *> *resolutionResults = [NSMutableArray array];
    
    for (INPerson *recipient in recipients) {
        NSArray<INPerson *> *matchingContacts = @[recipient]; // Implement your contact matching logic here to create an array of matching contacts
        if (matchingContacts.count > 1) {
            // We need Siri's help to ask user to pick one from the matches.
            [resolutionResults addObject:[INSendMessageRecipientResolutionResult disambiguationWithPeopleToDisambiguate:matchingContacts]];

        } else if (matchingContacts.count == 1) {
            // We have exactly one matching contact
            [resolutionResults addObject:[INSendMessageRecipientResolutionResult successWithResolvedPerson:recipient]];
        } else {
            // We have no contacts matching the description provided
            [resolutionResults addObject:[INSendMessageRecipientResolutionResult unsupported]];
        }
    }
    completion(resolutionResults);
}

- (void)resolveContentForSendMessage:(INSendMessageIntent *)intent withCompletion:(void (^)(INStringResolutionResult *resolutionResult))completion {
    NSString *text = intent.content;
    if (text && ![text isEqualToString:@""]) {
        completion([INStringResolutionResult successWithResolvedString:text]);
    } else {
        completion([INStringResolutionResult needsValue]);
    }
}

// Once resolution is completed, perform validation on the intent and provide confirmation (optional).

- (void)confirmSendMessage:(INSendMessageIntent *)intent completion:(void (^)(INSendMessageIntentResponse *response))completion {
    // Verify user is authenticated and your app is ready to send a message.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendMessageIntent class])];
    INSendMessageIntentResponse *response = [[INSendMessageIntentResponse alloc] initWithCode:INSendMessageIntentResponseCodeReady userActivity:userActivity];
    completion(response);
}

// Handle the completed intent (required).

- (void)handleSendMessage:(INSendMessageIntent *)intent completion:(void (^)(INSendMessageIntentResponse *response))completion {
    // Implement your application logic to send a message here.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendMessageIntent class])];
    INSendMessageIntentResponse *response = [[INSendMessageIntentResponse alloc] initWithCode:INSendMessageIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}


@end
