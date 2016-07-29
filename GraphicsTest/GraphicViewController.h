//
//  GraphicViewController.h
//  GraphicsTest
//
//  Created by yiyaowang on 15/10/20.
//  Copyright © 2015年 zengyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBAWeekHistogramView.h"
#import "OBHistogramView.h"
#import "OBDrawThreeFoldView.h"
#import "OBCircleProgressView.h"
@interface GraphicViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView* mainScrollView;
    
    OBAWeekHistogramView* zhuView; //柱形图
    OBDrawThreeFoldView* zheView;  //折线图
    OBCircleProgressView* quView;  //曲线图
    
}
@property (nonatomic,copy)NSString* which;

@end
