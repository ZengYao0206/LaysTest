//
//  PageViewController.m
//  GraphicsTest
//
//  Created by yiyaowang on 15/10/20.
//  Copyright © 2015年 zengyao. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    pageScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    pageScrollview.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds)*3, 0);
    pageScrollview.delegate = self;
    pageScrollview.pagingEnabled = YES;
    pageScrollview.bounces = NO;
    pageScrollview.directionalLockEnabled = YES;
    for (int i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)*i, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]];
        [pageScrollview addSubview:imageView];
        
        if (i == 2) {
            //开始体验
            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(100, CGRectGetHeight(self.view.bounds)-50, CGRectGetWidth(self.view.bounds)-200, 40);
            button.backgroundColor = [UIColor colorWithRed:52/255.f green:171/255.f blue:216/255.f alpha:1];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitle:@"开始体验" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(gotoRoot:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        
    }
    [self.view addSubview:pageScrollview];
    
}

//开始体验
-(void)gotoRoot:(UIButton*)button{
    
    RootViewController* root = [[RootViewController alloc]init];
    [self.navigationController pushViewController:root animated:YES];
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
