//
//  RideBookListHandler.m
//  SiriExtentIntent
//
//  Created by kequ on 2021/5/18.
//


#import "RideBookListHandler.h"

@interface RideBookListHandler() <INListRideOptionsIntentHandling>

@end

@implementation RideBookListHandler

- (void)handleListRideOptions:(INListRideOptionsIntent *)intent completion:(void (^)(INListRideOptionsIntentResponse * _Nonnull))completion {
        
    NSMutableArray<INRideOption *> *rideOptions = [NSMutableArray arrayWithCapacity:0];
    INRideOption *option = [[INRideOption alloc] initWithName:@"测试车辆1" estimatedPickupDate:[NSDate dateWithTimeIntervalSinceNow:60]];
    
    option.userActivityForBookingInApplication = [[NSUserActivity alloc] initWithActivityType:@"activity"];

    [rideOptions addObject:option];
    
    INListRideOptionsIntentResponse *response =  [[INListRideOptionsIntentResponse alloc] initWithCode:INListRideOptionsIntentResponseCodeSuccess userActivity:nil];
    
    response.rideOptions = rideOptions;
    completion(response);
    
}

@end
