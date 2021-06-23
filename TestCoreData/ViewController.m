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
    self.pillarView =  [[MCTimePillarView alloc]
                        initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 175)];
    self.pillarView.dataSource = self;
    self.pillarView.delegate = self;
    [self.view addSubview:self.pillarView];
    [self.pillarView reloadData];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 200, 100, 50);
    [self.view addSubview:button];
    NSLog(@"self.pillarView %d", self.pillarView.indexOfCenterItem);
}

- (NSUInteger)numberOfItemsInTimePillarView:(MCTimePillarView *)timePillarView {
    return 20.f;
}

-(MCPillarViewAttributes*)timePillarView:(MCTimePillarView*)pillarView attributesForItemAtIndex:(NSUInteger)index {
    
    
    MCPillarViewAttributes *attributes =  [MCPillarViewAttributes new];
    attributes.title = [NSString stringWithFormat:@"index %d",index];
    
    if (index > 3) {
        attributes.value = 1;
        attributes.available = YES;
        attributes.annotation = @"35分钟";
        attributes.title2 = @"$20";
    } else {
        attributes.available = NO;
        attributes.value = 0.2;
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
//    [self.pillarView reloadDataAtIndices:<#(nonnull NSArray<NSNumber *> *)#>]
}
@end

