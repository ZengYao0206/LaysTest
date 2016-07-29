//
//  RootViewController.m
//  GraphicsTest
//
//  Created by yiyaowang on 15/10/20.
//  Copyright © 2015年 zengyao. All rights reserved.
//

#import "RootViewController.h"
#import "GraphicViewController.h"
#import "CircleViewController.h"
@interface RootViewController ()
{
    
    UITableView* _mainTableView;
    NSMutableArray* _listArray;
    
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:52/255.f green:171/255.f blue:216/255.f alpha:1];
    self.title = @"动画列表";
    
    _listArray = [NSMutableArray arrayWithObjects:@"动画",@"柱形图",@"折线图",@"曲线图",@"综合运用", nil];
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStyleGrouped];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
}

#pragma mark UITableViewDelegate && UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*cellIdentifer = @"cellID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.textLabel.text = [_listArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* str = [_listArray objectAtIndex:indexPath.row];
    if ([str isEqualToString:@"柱形图"] || [str isEqualToString:@"折线图"] || [str isEqualToString:@"曲线图"]) {
        GraphicViewController* graphVC = [[GraphicViewController alloc]init];
        graphVC.which = str;
        [self.navigationController  pushViewController:graphVC animated:YES];
    }else if ([str isEqualToString:@"综合运用"]){
        CircleViewController * circleVC = [[CircleViewController alloc]init];
        [self.navigationController  pushViewController:circleVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
