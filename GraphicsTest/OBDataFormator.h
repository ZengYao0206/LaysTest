//
//  OBDataFormator.h
//  Oband
//
//  Created by Oband on 14-7-30.
//  Copyright (c) 2014年 Oband Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBDataFormator : NSObject
+(NSString*) stringDate:(NSDate *) date format:(NSString *) format;
+(NSDate *) datepartWithoutTime:(NSDate *)date;
+(NSDate*) dateFromString:(NSString *) dateText format:(NSString *) format;
+(NSInteger)WhatWeekWithDate:(NSDate*)date;
+(NSInteger)WhatYearWithDate:(NSDate*)date;
+(NSDate*)whatMonthDateWithDate:(NSDate*)date;

+(NSMutableArray*)getAMonthSAllDayWithDate:(NSDate*)date;

+(NSMutableArray*)getAmonthDates:(NSDate*)date;

+(NSMutableArray*)getAMonthSAllDayDate:(NSDate*)date;

//获取当天所在的星期的所有日期,format:@"yyyy-MM-dd"
+(NSMutableArray*)getAweekDayDateWithDate:(NSDate*)date howDay:(int)howDay;
//获取当天所在的星期的所有日期,format:@"dd"
+(NSMutableArray*)getAweekDayWithDate:(NSDate*)date howDay:(int)howDay;


+(NSDate*)DateFromString:(NSString*) format StrDate:(NSString*)strDate;


+(NSString *)convertToJSONString:(id)object;


+(NSTimeInterval)getIntervaltimeChange;

@end
