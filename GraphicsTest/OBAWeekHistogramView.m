//
//  OBAWeekHistogramView.m
//  Oband
//
//  Created by oband on 14-8-1.
//  Copyright (c) 2014年 Oband Tech. All rights reserved.
//

#import "OBAWeekHistogramView.h"
#define MARGIN_WITH 5
#define Y_Label_with 40


@interface OBAWeekHistogramView(){
    
    UIView *rootView;
    float yLabelWith;
}
@end

@implementation OBAWeekHistogramView
@synthesize title,note,mHistogramView,arrayStrX,arrayStrY;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        rootView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:rootView];
        title = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_WITH, MARGIN_WITH, self.frame.size.width-15, 20)];
        title.textAlignment =NSTextAlignmentLeft;
        title.font = [UIFont boldSystemFontOfSize:9];
        title.textColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:0.6];
        title.tintColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:0.5];
        [self addSubview:title];
        yLabelWith = self.frame.size.width*0.2;
        if (yLabelWith > Y_Label_with) {
            yLabelWith = Y_Label_with;
        }
        mHistogramView = [[OBHistogramView alloc] initWithFrame:CGRectMake(MARGIN_WITH+yLabelWith, title.frame.size.height+title.frame.origin.y+5, self.frame.size.width-2*MARGIN_WITH-yLabelWith, self.frame.size.height-title.frame.size.height+title.frame.origin.y-10-20 - self.frame.size.height*0.06)];
        [rootView addSubview:mHistogramView];
    }
    return self;
}


-(void)layoutSubviews{
    //    //x坐标的值
    float  daywith = (mHistogramView.frame.size.width-mHistogramView.marginLeft)/mHistogramView.numberDay;
    for (int i = 0; i<[arrayStrX count]; i++) {
        
        float xx = mHistogramView.frame.origin.x+daywith*i +mHistogramView.marginLeft-(daywith*0.8)/4;
        UILabel *lale = [[UILabel alloc] initWithFrame:CGRectMake(xx, mHistogramView.frame.origin.y+mHistogramView.frame.size.height+1, daywith, self.frame.size.height*0.1)];
        lale.textColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1];
        //        lale.backgroundColor = [UIColor greenColor];
        lale.textAlignment = NSTextAlignmentCenter;
        lale.font = [UIFont fontWithName:@"STHeitiTC-Light" size:9];
//        NSLog(@"%@",[UIFont fontNamesForFamilyName:@"HeitiTC"]);
        lale.text = [arrayStrX objectAtIndex:i];
//        NSLog(@"OBAWeekHistogramView->layoutSubviews->lale.text :%@", lale.text);
        [rootView addSubview:lale];
    }
    UILabel *dayUnit = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-daywith, mHistogramView.frame.origin.y+mHistogramView.frame.size.height-self.frame.size.height*0.025, self.frame.size.height*0.15, self.frame.size.height*0.15)];
    dayUnit.textColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1];
    dayUnit.textAlignment = NSTextAlignmentRight;
    dayUnit.font = [UIFont fontWithName:@"STHeitiTC-Light" size:9];
    dayUnit.text = @"";
    [rootView addSubview:dayUnit];
    
    UIImageView *xImageView = [[UIImageView alloc] initWithFrame:CGRectMake(mHistogramView.frame.origin.x, mHistogramView.frame.origin.y+mHistogramView.frame.size.height-1, mHistogramView.frame.size.width, 2)];
    xImageView.image = [UIImage imageNamed:@"week_x"];
    [self addSubview:xImageView];
    float yyheight = mHistogramView.frame.size.height/[arrayStrY count];
    for (int i = 0; i<[arrayStrY count]; i++) {
        
        float yy = mHistogramView.frame.origin.y+mHistogramView.frame.size.height -yyheight*i-16;
        UILabel *lale = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_WITH, yy, yLabelWith-yLabelWith/6, 20)];
        lale.textColor = [UIColor grayColor];
        lale.textAlignment = NSTextAlignmentRight;
        lale.font = [UIFont systemFontOfSize:yLabelWith/4.0];
        lale.text = [arrayStrY objectAtIndex:i];
        [rootView addSubview:lale];
        if (i != 0) {
            UIImageView *calibrationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(lale.frame.origin.x+lale.frame.size.width, yy+lale.frame.size.height/2-1, mHistogramView.frame.origin.x- lale.frame.size.width -lale.frame.origin.x,2)];
            calibrationImageView.image = [UIImage imageNamed:@"week_calibaration_y"];
            [rootView addSubview:calibrationImageView];
        }
        
    }
    UIImageView *yImageView = [[UIImageView alloc] initWithFrame:CGRectMake(mHistogramView.frame.origin.x-1, mHistogramView.frame.origin.y,2, mHistogramView.frame.size.height)];
    yImageView.image = [UIImage imageNamed:@"week_y"];
    [rootView addSubview:yImageView];
}


-(void)updataToHistogram{
    
//    NSDictionary *diction = self.dataDiction;
//    if (diction == nil) {
//        return;
//    }

    if (self.dateArray == nil) {
        return;
    }

    
    [rootView removeFromSuperview];
    rootView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:rootView];
    OBHistogramView *mhistor = mHistogramView;
    
    mHistogramView = [[OBHistogramView alloc] initWithFrame:CGRectMake(MARGIN_WITH+yLabelWith, title.frame.size.height+title.frame.origin.y+5, self.frame.size.width-2*MARGIN_WITH-yLabelWith, self.frame.size.height-title.frame.size.height+title.frame.origin.y-10-20 - self.frame.size.height*0.06)];
    
    mHistogramView.numberDay = mhistor.numberDay;
    mHistogramView.highColor = mhistor.highColor;
    mHistogramView.lowColor = mhistor.lowColor;
    mHistogramView.maxValue = mhistor.maxValue;
    mHistogramView.minValue = mhistor.minValue;
    mHistogramView.spacingRatio = mhistor.spacingRatio;
    mHistogramView.marginLeft = mhistor.marginLeft;
    
    [rootView addSubview:mHistogramView];
//    NSMutableArray *array = [NSMutableArray array];
//    NSMutableArray *dataArray = [NSMutableArray array];
//    NSArray *arraykey = [diction allKeys];
//    //比较日期字符串的大小，这里会出问题{01,02,03,28,29,20,31}
//    arraykey = [arraykey sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
//    NSLog(@"OBAWeekHistogramView->updataToHistogram->arraykey:%@", arraykey);
//    for (NSString *keyStr in arraykey) {
//        
//        [array addObject:keyStr];
//        [dataArray addObject:[diction objectForKey:keyStr]];
//    }


//    arrayStrX = array;
//    [self layoutSubviews];
//    [mHistogramView showHistogramByData:dataArray];

    NSArray* reversedDateArray = [[self.dateArray reverseObjectEnumerator] allObjects];
//    NSArray* reversedDataOfDateArray = [[self.dataOfDateArray reverseObjectEnumerator] allObjects];
    arrayStrX = reversedDateArray;
    arrayStrX = self.dateArray;
    [self layoutSubviews];
    [mHistogramView showHistogramByData:self.dataOfDateArray];
    
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
