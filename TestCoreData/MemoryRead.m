//
//  MemoryRead.m
//  TestCoreData
//
//  Created by kequ on 2021/3/5.
//

#import "MemoryRead.h"


void readAllZone (void) {
    
//    kern_return_t result = malloc_get_all_zones(TASK_NULL, NULL, &zones, &zoneCount);
//    if (result == KERN_SUCCESS) {
//        for (unsigned int i = 0; i < zoneCount; i++) {
//            
//            malloc_zone_t *zone = (malloc_zone_t *)zones[i];
//            printf("Found zone name:%s\n", zone->zone_name);
//            
//            malloc_introspection_t *introspection = zone->introspect;
//
//            if (!introspection) {
//                continue;
//            }
//
//            introspection->enumerator
//            void (*lock_zone)(malloc_zone_t *zone)   = introspection->force_lock;
//            void (*unlock_zone)(malloc_zone_t *zone) = introspection->force_unlock;
//
//            // Callback has to unlock the zone so we freely allocate memory inside the given block
//            malloc_object_enumeration_block_t callback = ^(__unsafe_unretained id object, __unsafe_unretained Class actualClass) {
//                unlock_zone(zone);
//                block(object, actualClass);
//                lock_zone(zone);
//            };
//
//            BOOL lockZoneValid = mallocPointerIsReadable((void *)lock_zone);
//            BOOL unlockZoneValid = mallocPointerIsReadable((void *)unlock_zone);
//
//            // There is little documentation on when and why
//            // any of these function pointers might be NULL
//            // or garbage, so we resort to checking for NULL
//            // and whether the pointer is readable
//            if (introspection->enumerator && lockZoneValid && unlockZoneValid) {
//                lock_zone(zone);
//                introspection->enumerator(TASK_NULL, (void *)&callback, MALLOC_PTR_IN_USE_RANGE_TYPE, (vm_address_t)zone, memory_reader_callback, &vm_range_recorder_callback);
//                unlock_zone(zone);
//            }
//        }
    
}

@implementation MemoryRead




@end
