//
//  DrawThreeFoldView.m
//  绘图测试
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//


#define KLineColor [UIColor colorWithRed:239.0 / 255.0 green:221.0 / 255.0 blue:221.0 / 255.0 alpha:1]
//#define KLineColor [UIColor blackColor]
#define KTimeLableH 30

#import "OBDrawThreeFoldView.h"
#import "OBDrawLineChartView.h"
#import "OBDataFormator.h"

@interface OBDrawThreeFoldView()

@property (nonatomic, retain) OBDrawLineChartView *move;

@property (nonatomic, retain) OBDrawLineChartView *sleep;

@property (nonatomic, retain) OBDrawLineChartView *diet;





@property (nonatomic, retain) UIView *timeView;

@end

@implementation OBDrawThreeFoldView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat oneRowHeight = (self.frame.size.height - KTimeLableH) / 3.0f;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        
        //运动
        OBDrawLineChartView *move = [[OBDrawLineChartView alloc] init];
        move.index = 0;
        
        [self addSubview:move];
        self.move = move;
        
        UILabel *line5 = [[UILabel alloc] init];
        line5.backgroundColor = KLineColor;
        line5.frame = CGRectMake(0, frame.size.height - 5, width, 5);
        [self addSubview:line5];
        
    }
    return self;
}


//设置数据去绘图
//运动
-(void)setMoves:(NSArray *)moves
{
   
    _moves = moves;
    
    CGFloat xBiLi = [UIScreen mainScreen].bounds.size.width / (moves.count - 1);
    CGFloat oneRowHeight = (self.frame.size.height - KTimeLableH) / 3.0f;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    self.move.frame = CGRectMake(- xBiLi, 0, width + xBiLi , oneRowHeight);
    self.move.frame = CGRectMake(0, 0, width, 270);//修改
    self.move.dataArr = moves;
 
}

//睡眠
-(void)setSleeps:(NSArray *)sleeps
{
    _sleeps = sleeps;
    
    CGFloat xBiLi = [UIScreen mainScreen].bounds.size.width / (sleeps.count - 1);
    CGFloat oneRowHeight = (self.frame.size.height - KTimeLableH) / 3.0f;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.sleep.frame = CGRectMake(- xBiLi, oneRowHeight, width + xBiLi , oneRowHeight);
    
    self.sleep.dataArr = sleeps;
    
}

//饮食
-(void)setDiets:(NSArray *)diets
{
    _diets = diets;
    
    CGFloat xBiLi = [UIScreen mainScreen].bounds.size.width / (diets.count - 1);
    CGFloat oneRowHeight = (self.frame.size.height - KTimeLableH) / 3.0f;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.diet.frame = CGRectMake(- xBiLi, 2 * oneRowHeight, width + xBiLi , oneRowHeight);
    
    self.diet.dataArr = diets;
    
}

//日期
-(void)setDates:(NSArray *)dates{
    
    _dates = dates;
    
    CGFloat xBiLi = [UIScreen mainScreen].bounds.size.width / (dates.count - 1);
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat lableY = self.frame.size.height - KTimeLableH;
    
    //在这里添加时间轴
    
    [self.timeView removeFromSuperview];
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, lableY, width, KTimeLableH)];
    timeView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:timeView];
    
    self.timeView = timeView;
    
    
    CGFloat fontSize = dates.count > 8 ? 7 : 12;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    for (NSInteger i = 1; i < dates.count; i++) {
        
        UILabel *lable = [[UILabel alloc] init];
        lable.backgroundColor = [UIColor clearColor];
        lable.textColor = [UIColor darkGrayColor];
        lable.textAlignment = NSTextAlignmentRight;
        lable.font = font;
//        lable.text = [OBDataFormator stringDate:dates[i] format:@"dd"];
        lable.text = dates[i];
        if ([dates[i] intValue] == 6 || [dates[i] intValue] == 7) {
            lable.textColor = [UIColor redColor];
        }
        lable.frame = CGRectMake((i - 1) * xBiLi, 0, xBiLi - 2, KTimeLableH - 10);
        [self.timeView addSubview:lable];
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = KLineColor;
        line.frame = CGRectMake(i * xBiLi - 1.5, 0, 1, 5);
        [self.timeView addSubview:line];
        
    }
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([_delegate respondsToSelector:@selector(drawThreeFoldViewTouchBeganDrawThreeFoldView:event:)]) {
        [_delegate drawThreeFoldViewTouchBeganDrawThreeFoldView:self event:event];
    }


}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
