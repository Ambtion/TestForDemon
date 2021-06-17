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
//    [self startMonitoring];
    [self startObserveRunloop];
}


- (void)startObserveRunloop {
     
    // 按需唤醒
    static CFRunLoopObserverRef g_observer = NULL;

    g_observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSString *str = @"";
        switch (activity) {
            case kCFRunLoopEntry:
                str = @"kCFRunLoopEntry";
                break;
            case kCFRunLoopExit:
                str = @"kCFRunLoopExit";
                break;
            case kCFRunLoopAfterWaiting:
                str = @"kCFRunWakeup";
                break;
            case kCFRunLoopBeforeWaiting:
                str = @"kCFRunSleep";
                break;
            case kCFRunLoopBeforeTimers:
                str = @"kCFRunLoopBeforeTimers";
                
            default:
                break;
        }
        
        printf("%s\n", [str cStringUsingEncoding:NSUTF8StringEncoding]);
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), g_observer, kCFRunLoopCommonModes);
}

#pragma mark - DisPlayLink
- (void)startMonitoring {
    if (_link) {
        [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [_link invalidate];
        _link = nil;
    }
    // 根据sync信号唤醒
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



@end
