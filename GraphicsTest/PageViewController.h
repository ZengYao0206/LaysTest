//
//  PageViewController.h
//  GraphicsTest
//
//  Created by yiyaowang on 15/10/20.
//  Copyright © 2015年 zengyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface PageViewController : UIViewController<UIScrollViewDelegate>
{
    
    UIScrollView* pageScrollview;
    UIPageControl* pageControl;
    UIButton* button;
}
@end
