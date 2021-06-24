//
//  ViewController.m
//  TestCoreData
//
//  Created by kequ on 2021/1/15.
//

#import "ViewController.h"
#import "MCTimePillarView.h"

@interface ViewController ()<MCTimePillarViewDataSource,
                                MCTimePillarViewDelegate>

@property(nonatomic, strong)MCTimePillarView *pillarView;

@end


@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSLog(@"start %lf", time);
    self.pillarView =  [[MCTimePillarView alloc]
                        initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 175)];
    self.pillarView.dataSource = self;
    self.pillarView.delegate = self;
    [self.view addSubview:self.pillarView];
    [self.pillarView reloadData];
    
    NSLog(@"end %lf", [[NSDate date] timeIntervalSince1970] - time);

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 400, 100, 50);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}

- (NSUInteger)numberOfItemsInTimePillarView:(MCTimePillarView *)timePillarView {
    return 20.f;
}

-(MCPillarViewAttributes*)timePillarView:(MCTimePillarView*)pillarView attributesForItemAtIndex:(NSUInteger)index {
    
    
    MCPillarViewAttributes *attributes =  [MCPillarViewAttributes new];
    attributes.title = [NSString stringWithFormat:@"index %d",index];
    
    if (index > 3) {
        attributes.value = (random() % 10 / 10.f);
        attributes.available = YES;
        attributes.annotation = @"35分钟";
        attributes.title2 = @"$20";
    } else {
        attributes.available = NO;
        attributes.value = 0.3;
        attributes.annotation = nil;
        attributes.title2 = nil;
    }
    
    return attributes;
}

-(NSString *)timePillarView:(MCTimePillarView *)pillarView titleAtIndex:(NSUInteger)index forState:(MCPillarItemViewState)state {
    if (state == kPillarItemViewStateFocused) {
        return @"我选择的";
    }
    return nil;
}


#pragma mark - delegate
- (void)timePillarView:(MCTimePillarView *)timePillarView didFocusAtIndex:(NSUInteger)index {
    NSLog(@"timePillarView didFocusAtIndex %d",index);
}

static BOOL isClick = NO;
- (void)didClickButton {
    isClick = !isClick;
    [self.pillarView reloadDataAtIndices:@[@(4),@(5),@(3)] withAnimation:YES];
}
@end

