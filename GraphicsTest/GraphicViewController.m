//
//  GraphicViewController.m
//  GraphicsTest
//
//  Created by yiyaowang on 15/10/20.
//  Copyright © 2015年 zengyao. All rights reserved.
//

#import "GraphicViewController.h"

@interface GraphicViewController ()
{
    int index;
    
    //柱形图相关数组
    NSMutableArray* dateArray;
    NSMutableArray* datasArray;
    
    //折线图
    NSMutableArray* zheDataArray;
    
    
    
}
@end

@implementation GraphicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.which;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    // Do any additional setup after loading the view.
    [self initUI];
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 300)];
    mainScrollView.backgroundColor = [UIColor colorWithRed:52/255.f green:171/255.f blue:216/255.f alpha:1];
    mainScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds)*3, 0);
    mainScrollView.delegate = self;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.directionalLockEnabled = YES;
    mainScrollView.bounces = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.contentInset = UIEdgeInsetsZero;
    [mainScrollView setContentOffset:CGPointMake(index*CGRectGetWidth(self.view.bounds), 0) animated:YES];
    [self.view addSubview:mainScrollView];
    
    //设置值
    dateArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    datasArray = [NSMutableArray arrayWithObjects:@"500",@"1000",@"3000",@"2000",@"2500",@"1500",@"500", nil];
    //柱形图
    zhuView = [[OBAWeekHistogramView alloc] initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width, 300)];
    zhuView.arrayStrY = [[NSArray alloc]initWithObjects:@"0",@"500",@"1000",@"1500",@"2000",@"2500", nil];
    zhuView.mHistogramView.spacingRatio = 0.5;
    zhuView.mHistogramView.maxValue = 2500;
    zhuView.backgroundColor = [UIColor whiteColor];
    zhuView.dateArray = dateArray;
    zhuView.dataOfDateArray = datasArray;
    [mainScrollView addSubview:zhuView];
    [zhuView updataToHistogram];
    
    //折线图
    zheDataArray = [NSMutableArray arrayWithObjects:@"1500",@"2000",@"3000",@"2000",@"1000",@"1500",@"1000", nil];
    zheView = [[OBDrawThreeFoldView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds), 0, mainScrollView.frame.size.width, 300)];
    zheView.backgroundColor = [UIColor whiteColor];
    zheView.moves = zheDataArray;
    zheView.dates = dateArray;
    [mainScrollView addSubview:zheView];
    
    //曲线图
    quView = [[OBCircleProgressView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)*2, 0, mainScrollView.frame.size.width, 300)];
    quView.backgroundColor = [UIColor whiteColor];
    quView.maxValuePerCircle = 10000;
    quView.isShowPercent = YES;
    quView.progessValue = 75.0;
    [mainScrollView addSubview:quView];
    [quView beginAnimationWithDuration:0.5];
    
}

//
-(void)initUI{
    if ([self.which isEqualToString:@"柱形图"]) {
        index = 0;
    }else if ([self.which isEqualToString:@"折线图"]){
        index = 1;
    }else{
        index = 2;
    }
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    index = scrollView.contentOffset.x/CGRectGetWidth(self.view.bounds);
    [self updateUI:index];
}

-(void)updateUI:(int)newIndex{
    if (index == 0) {
        self.title = @"柱形图";
        [zhuView updataToHistogram];
    }else if (index == 1){
        self.title = @"折线图";
    }else{
        self.title = @"曲线图";
        quView.progessValue = 80.0;
        [quView beginAnimationWithDuration:0.5];
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
