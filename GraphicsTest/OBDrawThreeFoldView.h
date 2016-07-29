//
//  DrawThreeFoldView.h
//  绘图测试
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 apple. All rights reserved.


//--------画三条折线的View-----------------






//NSArray *arr = @[@"8000",@"8000",@"7000",@"2500",@"6000",@"3500",@"8000",@"8000",@"7000",@"2500",@"6000",@"3500",@"8000",@"8000",@"7000",@"2500",@"6000",@"3500",@"8000",@"8000",@"7000",@"2500",@"6000",@"3500",@"8000",@"8000",@"7000",@"2500",@"6000",@"3500",@"8000",@"6000"];
//
//NSArray *arr1 = @[@"4",@"5",@"7",@"2",@"4",@"6",@"8",@"2",@"4",@"5",@"3",@"7",@"2",@"1",@"6",@"8",@"5",@"7",@"2",@"4",@"6",@"8",@"2",@"4",@"5",@"3",@"7",@"7",@"2",@"4",@"6",@"4"];
//
//NSArray *arr2 = @[@"3000",@"2500",@"6000",@"2500",@"3500",@"2500",@"6000",@"3500",@"2500",@"1000",@"2500",@"6000",@"3500",@"2500",@"6000",@"3500",@"2500",@"1000",@"2500",@"6000",@"3500",@"2500",@"6000",@"3500",@"2500",@"1000",@"6000",@"3500",@"2500",@"6000",@"3500",@"2500"];
//NSArray *arr3 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"1"];
//
//
//
//
////周的数据
//self.weekData = [NSMutableDictionary dictionary];
//
//NSRange range = NSMakeRange(arr.count - 8, 8);
//
//[self.weekData setObject:[arr subarrayWithRange:range] forKey:@"move"];
//[self.weekData setObject:[arr1 subarrayWithRange:range] forKey:@"sleep"];
//[self.weekData setObject:[arr2 subarrayWithRange:range] forKey:@"diet"];
//[self.weekData setObject:[arr3 subarrayWithRange:range] forKey:@"date"];
//
//
////月的的数据
//self.mouthData = [NSMutableDictionary dictionary];
//
//[self.mouthData setObject:arr forKey:@"move"];
//[self.mouthData setObject:arr1 forKey:@"sleep"];
//[self.mouthData setObject:arr2 forKey:@"diet"];
//[self.mouthData setObject:arr3 forKey:@"date"];
//
//
//
////默认现在月的
//DrawThreeFoldView *draw = [[DrawThreeFoldView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
//draw.moves = self.mouthData[@"move"];
//draw.sleeps = self.mouthData[@"sleep"];
//draw.diets = self.mouthData[@"diet"];
//draw.dates = self.mouthData[@"date"];
//
//draw.delegate = self;
//
//[self.view addSubview:draw];
//
//}
//
//#pragma mark - 点击切换月  和 周的 图
//
//-(void)drawThreeFoldViewTouchBeganDrawThreeFoldView:(DrawThreeFoldView *)drawThreeFoldView event:(UIEvent *)event
//{
//    if (drawThreeFoldView.tag == 0) {   //显示周
//        drawThreeFoldView.tag = 1;
//        
//        drawThreeFoldView.moves = self.weekData[@"move"];
//        drawThreeFoldView.sleeps = self.weekData[@"sleep"];
//        drawThreeFoldView.diets = self.weekData[@"diet"];
//        drawThreeFoldView.dates = self.weekData[@"date"];
//        
//    }else{                             //显示月
//        drawThreeFoldView.tag = 0;
//        
//        drawThreeFoldView.moves = self.mouthData[@"move"];
//        drawThreeFoldView.sleeps = self.mouthData[@"sleep"];
//        drawThreeFoldView.diets = self.mouthData[@"diet"];
//        drawThreeFoldView.dates = self.mouthData[@"date"];
//        
//    }
//    
//    NSLog(@"ThreeFoldView 被点了 %d",drawThreeFoldView.tag);
//}



#import <UIKit/UIKit.h>
@class OBDrawThreeFoldView;

@protocol DrawThreeFoldViewDelegate <NSObject>

//页面被点击了切换每周走势和每月走势

-(void)drawThreeFoldViewTouchBeganDrawThreeFoldView:(OBDrawThreeFoldView *)drawThreeFoldView event:(UIEvent *)event;

@end

@interface OBDrawThreeFoldView : UIView

@property (nonatomic,assign) id<DrawThreeFoldViewDelegate>delegate;

/**
 设置数据的时候要多传一天的  如要显示每周的走势个个数组要传 ----- 8天的  **** 第一条数据是用来确定起点坐标的
 
                         如要显示每月的的走势个个数组要传-----31的
 */

//运动数据
@property (nonatomic, retain) NSArray *moves;

//睡眠数据
@property (nonatomic, retain) NSArray *sleeps;

//饮食数据
@property (nonatomic, retain) NSArray *diets;


//日期
@property (nonatomic, retain) NSArray *dates;

@end
