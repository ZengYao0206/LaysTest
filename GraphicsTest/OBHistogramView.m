//
//  OBHistogramView.m
//  Oband
//
//  Created by oband on 14-8-1.
//  Copyright (c) 2014年 Oband Tech. All rights reserved.
//

#import "OBHistogramView.h"
#import "OBPNBar.h"
#define  MARGIN_TOP 10


@interface OBHistogramView(){
    
    float PerBarWith;
    
}
@end

@implementation OBHistogramView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.numberDay = 7;
        self.highColor = [UIColor colorWithRed:252.0/255.0 green:54.0/255.0 blue:66.0/255.0 alpha:1];
        self.lowColor = [UIColor colorWithRed:253.0/255.0 green:168.0/255.0 blue:173.0/255.0 alpha:1];
        self.maxValue = 3000;
        self.minValue = 0;
        self.spacingRatio = 0.5;
        self.marginLeft = 15;
    }
    return self;
}


-(void)showHistogramByData:(NSArray*)array{
    PerBarWith = (self.frame.size.width-self.marginLeft)/[array count];
    
    for (int i= 0; i<[array count]; i++) {
        float value = [[array objectAtIndex:i] floatValue];
        NSLog(@"value: %f",value);
        NSLog(@"maxValue %d",self.maxValue);
        if (value>self.maxValue) {
            value = self.maxValue;
        }
        NSLog(@"value1: %f",value);
        float xx = self.marginLeft + i*PerBarWith;
        float yy,Height;
        if (value == 0) {
            
            Height = ((5.0/138.0)*self.frame.size.height);
            yy = self.frame.size.height-Height;
        }else{
            
            yy = [self getYByValue:value];
            
            Height = [self getHeighByValue:value];
        }
        OBPNBar *mPNBar = [[OBPNBar alloc] initWithFrame:CGRectMake(xx, yy,self.spacingRatio*PerBarWith, Height)];
        //            NSLog(@"%f,    %f",xb,columnWith);
        mPNBar.barColor = [self getColorByValue:value];
        
        [self performSelectorOnMainThread:@selector(UpdateView:) withObject:mPNBar waitUntilDone:YES];
    }
    
}

-(float)getYByValue:(float)value{
    
    float yy =self.frame.size.height- ((self.frame.size.height-MARGIN_TOP)*(value/self.maxValue));
    
    return yy;
}

-(float)getHeighByValue:(float)value{
    
    float Heigh =(self.frame.size.height-MARGIN_TOP)*(value/self.maxValue);
    
    return Heigh;
}


-(UIColor*)getColorByValue:(float)Value{
    
    if (Value == 0) {
        
        return [UIColor grayColor];
    }
    else if ((Value/self.maxValue) > 0.5) {
        
        return self.highColor;
    }else{
        
        return self.lowColor;
    }
    
}

-(void)UpdateView:(OBPNBar*)mPNBar{
    
    [self addSubview:mPNBar];
    [mPNBar setGrade:1];
    
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
