//
//  ViewController.m
//  TestCoreData
//
//  Created by kequ on 2021/1/15.
//

#import "ViewController.h"
#import "Post+CoreDataProperties.h"

#import <malloc/malloc.h>
#import <objc/runtime.h>
#import "MCGradientView.h"
#import "CSView.h"
#import "UIBezierPath+CornerRadius.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate> {
    
    CADisplayLink *_link;
    CFTimeInterval _lastTime;
}

@property(nonatomic, strong)NSPersistentContainer *container;
@property(nonatomic, strong)NSFetchedResultsController *resultController;
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, assign)NSInteger count;

@end


@implementation ViewController

//static CFMutableSetRef registeredClass;
//+ (void)readAllClass {
//    if (!registeredClass) {
//        registeredClass = CFSetCreateMutable(NULL, 0, NULL);
//    } else {
//        CFSetRemoveAllValues(registeredClass);
//    }
//
//    unsigned int count = 0;
//    Class *classes = objc_copyClassList(&count);
//    for (unsigned int i = 0; i < count; i++) {
//
////        struct objc_class *class = classes[i];
//
//        CFSetAddValue(registeredClass, (__bridge const void *)class);
//    }
//
//}


- (void)p_setupSubViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self p_setupViewWithY:50 shadowOffset:CGSizeMake(0, 1)];
    [self p_setupViewWithY3:200];
}


- (void)p_setupViewWithY3:(CGFloat)y {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, y, [UIScreen mainScreen].bounds.size.width - 60, 50)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    view.layer.shadowOpacity = 1;
    view.layer.shadowOffset = CGSizeMake(0, 1);
    view.layer.shadowColor = [UIColor redColor].CGColor;
    
    CGRect rect = view.bounds;
    rect.size.height = 4;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10];
    
    view.layer.shadowPath = path.CGPath;
}

- (void)p_setupViewWithY:(CGFloat)y shadowOffset:(CGSize)shadowOffset {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, y, [UIScreen mainScreen].bounds.size.width - 60, 50)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    view.layer.shadowOpacity = 1;
    view.layer.shadowOffset = shadowOffset;
}

- (void)onTapSuperView:(UITapGestureRecognizer *)tap {
    NSLog(@"onTapSuperView");
}

- (void)onTapSuperView2:(UITapGestureRecognizer *)tap {
    NSLog(@"onTapSuvView2");
}


- (UIImage *)dragBgImage {
    
//    MCGradientView *gradientView = [[MCGradientView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//
//    self.view.backgroundColor = [UIColor whiteColor];
//    CGFloat per = 50.f / gradientView.bounds.size.height;
//    [gradientView setGradColors:@[(__bridge id)UIColor.clearColor.CGColor,
//                                  (__bridge id)UIColor.redColor.CGColor]
//                      locations:@[@(0), @(per)]];
//    [gradientView setGradientStart:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
//    UIGraphicsBeginImageContextWithOptions(gradientView.bounds.size, NO, [UIScreen mainScreen].scale);
//    [gradientView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
//    return image;
    return [UIImage imageNamed:@"bg"];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 300, 100)];
    view.backgroundColor = UIColor.redColor;
    [self.view addSubview:view];
    
    CAShapeLayer *shaLayer = [CAShapeLayer layer];
    shaLayer.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                   byRoundingCornersTopLeft:CGSizeMake(40, 10)
                                             TopRightRadius:CGSizeMake(50, 0) BottomLeft:CGSizeMake(30, 50) BottomRight:CGSizeMake(50, 70)].CGPath;
    
    view.layer.mask = shaLayer;
    
//    CGRect contentRect = view.bounds;
//    CGSize cornerRadi = CGSizeMake(12, 12);
//    UIRectCorner rectCorner = UIRectCornerTopLeft | UIRectCornerTopRight;
//
//    contentRect.size.height -= 5;
//    contentRect = CGRectMake(contentRect.origin.x + 20,
//                             contentRect.origin.y,
//                             contentRect.size.width - 40,
//                             contentRect.size.height - 5);
//
//    UIBezierPath *shadowPath =  [UIBezierPath bezierPathWithRoundedRect:contentRect
//                                                      byRoundingCorners:rectCorner
//                                                            cornerRadii:cornerRadi];
//
//    view.layer.shadowPath = shadowPath.CGPath;
    
//    CSView *bgView = [[CSView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    bgView.shadowOffset = CGSizeMake(0, 100);
//    bgView.shadowRadius = 5.f;
//    bgView.backgroundColor = [UIColor blackColor];
//    bgView.shadowColor = [UIColor redColor];
//    [self.view addSubview:bgView];

//    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:scrollView];
//    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 10000)];
//    scrollView.backgroundColor = [[UIColor alloc] initWithPatternImage:[self dragBgImage]];
//    scrollView.layer.contents = (__bridge id)[self dragBgImage].CGImage;
//    scrollView.backgroundColor = [UIColor greenColor];
    
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];
//    view.backgroundColor = [UIColor blueColor];
//    [scrollView addSubview:view];
//    [self.view addSubview:imageView];
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapSuperView:)];
//    [self.view addGestureRecognizer:tapGesture];
//
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width - 60, 50)];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
//    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapSuperView2:)];
//    [view addGestureRecognizer:tapGesture];

    
//    [self p_setupSubViews];
    
//    [self.class readAllClass];
//    return;
//    vm_address_t *zones = NULL;
//    unsigned int zoneCount = 0;
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
//    }
    
//    [super viewDidLoad];
//
//    SEL sel = @selector(viewDidLoad);
//
//    NSLog(@"==== %@",
//
//    const char *selName = (const char *)(const void*)sel;
//    NSString *str = [NSString stringWithCString:selName encoding:NSUTF8StringEncoding];
//          NSStringFromSelector(sel));
//
//    NSLog(@"==== %@",str);
//
//
//
//    return;
//    // Do any additional setup after loading the view.
//    self.container = [NSPersistentContainer persistentContainerWithName:@"TestCoreData"];
//
//    [self.container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull des, NSError * _Nullable error) {
//
////        Post *post = [[Post alloc] initWithContext:self.container.viewContext];
////        post.content = @"Hello";
////        NSError *errora = nil;
////        [self.container.viewContext save:&errora];
////        NSLog(@"er %@",errora);
//
//        [self.container performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
//            [context performBlockAndWait:^{
//
//                NSBatchUpdateRequest * request = [[NSBatchUpdateRequest alloc] initWithEntity:Post.entity];
//                request.propertiesToUpdate = @{
//                    @"index" : @(1)
//                };
////                request.predicate = [NSPredicate predicateWithFormat:@"SELF == aaa"];
//                [context executeRequest:request error:nil];
//
////                NSMutableArray *data = [NSMutableArray arrayWithCapacity:0];
////                for (int i =0; i < 100; i++) {
////                    [data addObject:@{@"content":[NSString stringWithFormat:@"a: index:%d",i]}];
////                }
////
////                NSBatchInsertRequest *requst = [[NSBatchInsertRequest alloc] initWithEntity:[Post entity] objects:data];
////
////                [context executeRequest:requst error:nil];
//            }];
//
//        }];
//
//
//
//
//    }];
//
//    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:tableView];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//
//    self.tableView = tableView;
//
//
//    [self startMonitoring];
    
}


- (void)startMonitoring {
    if (_link) {
        [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [_link invalidate];
        _link = nil;
    }
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(fpsDisplayLinkAction:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.count = 0;
}

- (void)fpsDisplayLinkAction:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    self.count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    CGFloat fps = _count / delta;
    NSLog(@"count = %d, delta = %f,_lastTime = %f, _fps = %.0f",_count, delta, _lastTime, fps);
    self.count = 0;
//    _fpsLbe.text = [NSString stringWithFormat:@"FPS:%.0f",_fps];
}

- (NSFetchedResultsController *)resultController {
    if (!_resultController && self.container.viewContext) {
        NSFetchRequest *featchRequest = [Post fetchRequest];
        featchRequest.fetchLimit = 20;
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
        featchRequest.predicate = [NSPredicate predicateWithFormat:@"content = 'aaa'"];
        featchRequest.sortDescriptors = @[sort];
        _resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:featchRequest managedObjectContext:self.container.viewContext sectionNameKeyPath:nil cacheName:nil];
        _resultController.delegate = self;
        
        NSError *error = nil;
        
        if (![_resultController performFetch:&error]) {
            abort();
        }
    }
    return _resultController;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id< NSFetchedResultsSectionInfo> sectionInfo = self.resultController.sections[section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.resultController.sections.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObject *object = [self.resultController objectAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    
    cell.textLabel.text = [(Post *)object content];
    return cell;
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] endUpdates];
}



@end
