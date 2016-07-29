//
//  CircleViewController.m
//  GraphicsTest
//
//  Created by ZengYao on 16/7/27.
//  Copyright © 2016年 zengyao. All rights reserved.
//

#import "CircleViewController.h"
#import "InvestCircleView.h"
@interface CircleViewController ()
{
    InvestCircleView * _circleView;
}
@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _circleView = [[InvestCircleView alloc]initWithFrame:CGRectZero];
    _circleView.frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    _circleView.backgroundColor = [UIColor lightGrayColor];
    _circleView.progessValue = 75;
    _circleView.bgArcColor = [UIColor colorWithRed:253.0/255.0 green:219.0/255.0 blue:218.0/255.0 alpha:0.8];
    _circleView.progressColor = [UIColor colorWithRed:252.0/255.0 green:54.0/255.0 blue:66.0/255.0 alpha:0.8];
    _circleView.MaxColor = [UIColor greenColor];
    [self.view addSubview:_circleView];
    
    //噶事，骚年
    [_circleView beginAnimationWithDuration:0.5];
    
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
