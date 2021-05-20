//
//  IntentHandler.m
//  SiriExtentIntent
//
//  Created by kequ on 2021/5/17.
//

#import "IntentHandler.h"
#import "SendMessageHandler.h"

#import "RideBookListHandler.h"
#import "RideBookHandler.h"
#import "RideBookGetStatusHandler.h"

@interface IntentHandler ()

@end

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    
    if ([intent isKindOfClass:[INSendMessageIntent class]]) {
        SendMessageHandler *SendMsgHandler = [[SendMessageHandler alloc] init];
        return SendMsgHandler;
    }
    
    if ([intent isKindOfClass:INRequestRideIntent.class]) {
        RideBookHandler *rideHandler =  [[RideBookHandler alloc] init];
        return rideHandler;
    }
    
    if ([intent isKindOfClass:INGetRideStatusIntent.class]) {
        RideBookGetStatusHandler *handler =  [[RideBookGetStatusHandler alloc] init];
        
        return handler;

    }
    
    if ([intent isKindOfClass:INListRideOptionsIntent.class]) {
        RideBookListHandler *handler =  [[RideBookListHandler alloc] init];
        return handler;
    }
    
    return self;
}

@end
