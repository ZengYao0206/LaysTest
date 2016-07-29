//
//  OBDataFormator.m
//  Oband
//
//  Created by Oband on 14-7-30.
//  Copyright (c) 2014年 Oband Tech. All rights reserved.
//

#import "OBDataFormator.h"

@implementation OBDataFormator

#pragma mark - 传入日期，按需要的格式来格式话日期，返回字符串
+(NSString*) stringDate:(NSDate *) date format:(NSString *) format{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *dateString = [dateFormatter stringFromDate:date];

    return dateString ;
}
#pragma mark - 传入字符串，按需要的格式来格式话日期，返回日期
+(NSDate*) dateFromString:(NSString *) dateText format:(NSString *) format{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSDate * date = [dateFormatter dateFromString:dateText];
    
    return date ;
}

#pragma mark - 只获取日期，去除时间，返回日期
+(NSDate *)datepartWithoutTime:(NSDate *)date
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents*  parts = [[NSCalendar currentCalendar] components:flags fromDate:date];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    return  [[NSCalendar currentCalendar] dateFromComponents:parts];
    
}

#pragma mark - 获取传入的日期是星期几，返回NSInteger
+(NSInteger)WhatWeekWithDate:(NSDate*)date {
    
    NSUInteger unitFlags = NSWeekdayCalendarUnit|NSWeekdayOrdinalCalendarUnit|NSWeekCalendarUnit;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setFirstWeekday:1] ;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    NSInteger day = [components weekday]-1;
    if (day == 0) {
        day =7;
    }
    return day;
}

#pragma mark - 获取传入的日期的年份，针对业余的Oband手环协议，返回NSInteger
+(NSInteger)WhatYearWithDate:(NSDate*)date {
    
    NSUInteger unitFlags = NSYearCalendarUnit | NSYearForWeekOfYearCalendarUnit;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setFirstWeekday:1] ;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    NSUInteger year =[components year];
    
    return year;
}

#pragma mark - 获取传入的日期,返回NSInteger
+(NSDate*)whatMonthDateWithDate:(NSDate*)date{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    
    [components setDay:1];
    
    
    NSDate *dated = [gregorian dateFromComponents:components];
    
    return  dated;
    
    
}

#pragma mark - 获取当前天所在的月份的所有日期, format:@"dd"

+(NSMutableArray*)getAMonthSAllDayWithDate:(NSDate*)date{
    NSLog(@"getAMonthSAllDayWithDate->date:  %@",date);
    NSDate* zeroDate = [self whatMonthDateWithDate:date];
    NSLog(@"zeroDate:    %@",zeroDate);
    zeroDate = [self DateFromString:@"yyyy-MM-dd" StrDate:[self stringDate:zeroDate format:@"yyyy-MM-dd"]];
    zeroDate = [zeroDate dateByAddingTimeInterval:-16*3600];
    NSMutableArray* dateArray = [NSMutableArray array];
    NSDate* startDate = [zeroDate dateByAddingTimeInterval:-24*3600];
    NSString* day = [self stringDate:startDate format:@"dd"];
    [dateArray addObject:day];
    
    NSDate* end = [zeroDate dateByAddingTimeInterval:24*3600];
    for (int i = 0; [[self stringDate:end format:@"yyMM"] isEqualToString:[self stringDate:zeroDate format:@"yyMM"]]; i++) {
        
        NSDate* startDate = [zeroDate dateByAddingTimeInterval:24*3600*i];
        NSString* day = [self stringDate:startDate format:@"dd"];
        [dateArray addObject:day];
        end = [zeroDate dateByAddingTimeInterval:(i+1)*24*3600];
    }
    
    
    return dateArray;
}

+(NSMutableArray*)getAmonthDates:(NSDate*)date{
    
    NSLog(@"getAMonthSAllDayWithDate->date:  %@",date);
    NSDate* zeroDate = [self whatMonthDateWithDate:date];
    NSLog(@"zeroDate:    %@",zeroDate);
    zeroDate = [self DateFromString:@"yyyy-MM-dd" StrDate:[self stringDate:zeroDate format:@"yyyy-MM-dd"]];
    zeroDate = [zeroDate dateByAddingTimeInterval:-16*3600];
    NSMutableArray* dateArray = [NSMutableArray array];
    NSDate* startDate = [zeroDate dateByAddingTimeInterval:-24*3600];
//    NSString* day = [self stringDate:startDate format:@"dd"];
//    [dateArray addObject:startDate];
    
    NSDate* end = [zeroDate dateByAddingTimeInterval:24*3600];
    for (int i = 0; [[self stringDate:end format:@"yyMM"] isEqualToString:[self stringDate:zeroDate format:@"yyMM"]]; i++) {
        
        NSDate* startDate = [zeroDate dateByAddingTimeInterval:24*3600*i];
//        NSString* day = [self stringDate:startDate format:@"dd"];
        [dateArray addObject:startDate];
        end = [zeroDate dateByAddingTimeInterval:(i+1)*24*3600];
    }
    
    
    return dateArray;
}


#pragma mark - 获取当前天所在的月份的所有日期, format:@"yyyy-MM-dd"
+(NSMutableArray*)getAMonthSAllDayDate:(NSDate *)date{
    
    NSDate* zeroDate = [self whatMonthDateWithDate:date];
    NSLog(@"zeroDate:    %@",zeroDate);
    zeroDate = [self DateFromString:@"yyyy-MM-dd" StrDate:[self stringDate:zeroDate format:@"yyyy-MM-dd"]];
    zeroDate = [zeroDate dateByAddingTimeInterval:-16*3600];
    NSMutableArray* dateArray = [NSMutableArray array];
    NSDate* startDate = [zeroDate dateByAddingTimeInterval:-24*3600];
    NSString* day = [self stringDate:startDate format:@"yyyy-MM-dd"];
    NSLog(@"ddday:   %@",day);
//    [dateArray addObject:day];
    
    NSDate* end = [zeroDate dateByAddingTimeInterval:24*3600];
    for (int i = 0; [[self stringDate:end format:@"yyMM"] isEqualToString:[self stringDate:zeroDate format:@"yyMM"]]; i++) {
        
        NSDate* startDate = [zeroDate dateByAddingTimeInterval:24*3600*i];
        NSString* day = [self stringDate:startDate format:@"yyyy-MM-dd"];
        [dateArray addObject:day];
        end = [zeroDate dateByAddingTimeInterval:(i+1)*24*3600];
    }
    
    return dateArray;
}


+(NSDate*)DateFromString:(NSString*) format StrDate:(NSString*)strDate{
    
    NSDate *currentTime;
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:format];
    
    currentTime = [formatter dateFromString:strDate];
    NSInteger interval = (24-8)*60*60;//[zone secondsFromGMTForDate: date];
    NSDate *localeDate = [currentTime  dateByAddingTimeInterval: interval];
    return localeDate;
}


#pragma mark - 获取当前天所在周的第一天

//获取一周的第一天
+(NSDate*)getAWeekIsOneDay:(NSDate*)date{
    
    int weekday =  [self WhatWeekWithDate:date];
    if (weekday != 0) {
        date = [date dateByAddingTimeInterval:-(weekday-1)*24*60*60];
    }
    return date;
}

#pragma mark - 获取当前天所在周的日期，format:@"yyyy-MM-dd"
+(NSMutableArray*)getAweekDayDateWithDate:(NSDate*)date howDay:(int)howDay{
    
    NSDate *zeroDate  = [self getAWeekIsOneDay:date];
    zeroDate = [self DateFromString:@"yyyy-MM-dd" StrDate:[self stringDate:zeroDate format:@"yyyy-MM-dd"]];
    zeroDate = [zeroDate dateByAddingTimeInterval:-16*60*60];
    NSMutableArray *weekDateArray = [NSMutableArray array];
    if (howDay == 8) {
        zeroDate = [zeroDate dateByAddingTimeInterval:-24*60*60];
    }
    for (int i=0; i<howDay; i++) {
        
        NSDate *startDate = [zeroDate dateByAddingTimeInterval:i*24*60*60];
        
        NSString *day = [self stringDate:startDate format:@"yyyy-MM-dd"];
        [weekDateArray addObject:day];
        
    }
    return weekDateArray;
}

#pragma mark - 获取当前天所在周的日期，format:@"dd"
+(NSMutableArray*)getAweekDayWithDate:(NSDate*)date howDay:(int)howDay{
    
    NSDate *zeroDate  = [self getAWeekIsOneDay:date];
    zeroDate = [self DateFromString:@"yyyy-MM-dd" StrDate:[self stringDate:zeroDate format:@"yyyy-MM-dd"]];
    zeroDate = [zeroDate dateByAddingTimeInterval:-16*60*60];
    NSMutableArray *weekDateArray = [NSMutableArray array];
    if (howDay == 8) {
        zeroDate = [zeroDate dateByAddingTimeInterval:-24*60*60];
    }
    for (int i=0; i<howDay; i++) {
        
        NSDate *startDate = [zeroDate dateByAddingTimeInterval:i*24*60*60];
        
        NSString *day = [self stringDate:startDate format:@"dd"];
        [weekDateArray addObject:day];
        
    }
    return weekDateArray;
}






#pragma mark - 转换到string
+(NSString *)convertToJSONString:(id)object{
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    
    if ([jsonData length] > 0 && error == nil){
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        
        return jsonString;
        
    }else{
        
        return nil;
    }


}

+(NSTimeInterval)getIntervaltimeChange{
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:[NSDate date]];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:[NSDate date]];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    return interval;
}

@end
