//
//  RideBookHandler.m
//  SiriExtentIntent
//
//  Created by kequ on 2021/5/18.
//


/*
 A successful implementation of a ride-booking Intents app extension requires supporting all of the intents in the ride-booking domain. In fact, Maps on iOS expects your extension to handle all of the intents and doesn’t load it if it doesn’t.
 
 */
#import "RideBookHandler.h"

@interface RideBookHandler () <INRequestRideIntentHandling>

@end

@implementation RideBookHandler


- (void)resolvePickupLocationForRequestRide:(INRequestRideIntent *)intent withCompletion:(void (^)(INPlacemarkResolutionResult * _Nonnull))completion {
    if (intent.pickupLocation) {
        if (completion) {
            completion([INPlacemarkResolutionResult successWithResolvedPlacemark:intent.pickupLocation]);

        }
    } else {
        if (completion) {
            completion([INPlacemarkResolutionResult confirmationRequiredWithPlacemarkToConfirm:intent.pickupLocation]);

        }
    }
}

- (void)resolveDropOffLocationForRequestRide:(INRequestRideIntent *)intent withCompletion:(void (^)(INPlacemarkResolutionResult * _Nonnull))completion {
    
    if (intent.dropOffLocation) {
        if (completion) {
            completion([INPlacemarkResolutionResult successWithResolvedPlacemark:intent.dropOffLocation]);

        }
    } else {
        if (completion) {
            completion([INPlacemarkResolutionResult confirmationRequiredWithPlacemarkToConfirm:intent.dropOffLocation]);

        }
    }
}

// 预约时间
//- (void)resolveScheduledPickupTimeForRequestRide:(INRequestRideIntent *)intent withCompletion:(void (^)(INDateComponentsRangeResolutionResult * _Nonnull))completion {
//    if (intent.scheduledPickupTime) {
//        <#statements#>
//    }
//}

- (void)confirmRequestRide:(INRequestRideIntent *)intent completion:(void (^)(INRequestRideIntentResponse * _Nonnull))completion {
    INRequestRideIntentResponse *response = [[INRequestRideIntentResponse alloc] initWithCode:INRequestRideIntentResponseCodeSuccess userActivity:nil];
    // 屏幕展示信息
    INRideStatus *status =  [[INRideStatus alloc] init];
    status.rideIdentifier = [NSUUID UUID].UUIDString;
    status.pickupLocation = intent.pickupLocation;
    status.dropOffLocation = intent.dropOffLocation;
    status.phase = INRidePhaseConfirmed;
    status.completionStatus =  [INRideCompletionStatus completed];
    
    // 司机信息
    status.driver = [[INRideDriver alloc] initWithPhoneNumber:@"13122223333"
                                               nameComponents:[NSPersonNameComponents new]
                                                  displayName:@"测试司机" image:[INImage imageWithURL:[NSURL URLWithString:@""]] rating:@"这个司机特别好"];
    // EAT信息
    status.estimatedPickupDate = [NSDate dateWithTimeIntervalSinceNow:5 * 60];
    
    
    // 车辆信息
    INRideVehicle *vehicle = [[INRideVehicle alloc] init];
    vehicle.model = @"测试的豪车";
    status.vehicle = vehicle;
    
    response.rideStatus = status;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        completion(response);
    });
    
    
}
- (void)handleRequestRide:(INRequestRideIntent *)intent completion:(void (^)(INRequestRideIntentResponse * _Nonnull))completion {
    
    INRequestRideIntentResponse *response = [[INRequestRideIntentResponse alloc] initWithCode:INRequestRideIntentResponseCodeSuccess userActivity:nil];
    // 屏幕展示信息
    INRideStatus *status =  [[INRideStatus alloc] init];
    status.rideIdentifier = [NSUUID UUID].UUIDString;
    status.pickupLocation = intent.pickupLocation;
    status.dropOffLocation = intent.dropOffLocation;
    status.phase = INRidePhaseConfirmed;
    status.completionStatus =  [INRideCompletionStatus completed];
    
    // 司机信息
    status.driver = [[INRideDriver alloc] initWithPhoneNumber:@"13122223333"
                                               nameComponents:[NSPersonNameComponents new]
                                                  displayName:@"测试司机" image:[INImage imageWithURL:[NSURL URLWithString:@""]] rating:@"这个司机特别好"];
    // EAT信息
    status.estimatedPickupDate = [NSDate dateWithTimeIntervalSinceNow:5 * 60];
    
    
    // 车辆信息
    INRideVehicle *vehicle = [[INRideVehicle alloc] init];
    vehicle.model = @"测试的豪车";
    status.vehicle = vehicle;
    
    response.rideStatus = status;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        completion(response);
    });
    
}

@end
