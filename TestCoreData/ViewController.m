//
//  ViewController.m
//  TestCoreData
//
//  Created by kequ on 2021/1/15.
//

#import "ViewController.h"
#import "Masonry.h"

@interface TestCell : UITableViewCell
@property(nonatomic, strong)UILabel *mainlable;
@end

@implementation TestCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mainlable = [UILabel new];
        self.mainlable.numberOfLines = 0;
        [self.contentView addSubview:self.mainlable];
        [self.mainlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    
    return self;
}

- (void)refreshAutoLayout:(CGFloat)autoLayout {
    [self.mainlable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(autoLayout, 10, 10, 10));
    }];
}

@end

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *tableview;

@property(nonatomic, strong)TestCell *cell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableview];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 5) {
        self.cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        self.cell.contentView.backgroundColor = [UIColor redColor];
        self.cell.mainlable.text = @"我是中隔线";
        return self.cell;
    }
    
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *text = @"我的命中";
    if (random() % 10 == 5) {
        text = [text stringByAppendingString:@"我是423323423423\n\n"];
    }
    text = [text stringByAppendingFormat:@"row = %ld",(long)indexPath.row];
    cell.mainlable.text = text;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.cell refreshAutoLayout:scrollView.contentOffset.y];
}
@end
