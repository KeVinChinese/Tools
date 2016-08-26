//
//  NSDate+Toolkit.m
//  hwb
//
//  Created by Bubble on 15/10/6.
//  Copyright © 2015年 Mask. All rights reserved.
//

#import "NSDate+Tools.h"

@implementation NSDate(Tools)

#define DEFAULT_TIME_ZONE @"GMT+0000"

+ (NSString *)transformLongStrToDateStr:(NSString *)longStr format:(NSString *)format {
    return [NSDate transformLongStrToDateStr:longStr format:format andTimeZone:DEFAULT_TIME_ZONE];
}
/**
 *  时间转换
 */
+ (NSString *)transformLongStrToDateStr:(NSString *)longStr format:(NSString *)format andTimeZone:(NSString *)timeZone{
    NSString *str=[NSDate interceptDateWith:longStr];
    NSDate *theDay=[NSDate dateWithTimeIntervalSince1970:[str doubleValue]/1000];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:timeZone]];
    NSString *dateStr=[formatter stringFromDate:theDay];
    return dateStr;
}

+ (NSString *)interceptDateWith:(NSString *)str{
    NSArray *array=[str componentsSeparatedByString:@"("];
    NSArray *brray=[[array objectAtIndex:1] componentsSeparatedByString:@")"];
    return [brray objectAtIndex:0];
}

+ (NSString *)transformDatetoLongStr:(NSDate *)date{
    NSTimeInterval time = [date timeIntervalSince1970];
    long long int dateLong = (long long int)time * 1000;
    NSString *dateTime = [NSString stringWithFormat:@"%lld",dateLong];
    return dateTime;
}

+(NSInteger) getNowYear{
    return [NSDate getNowTimeValueFor:NSYearCalendarUnit];
}

+(NSInteger) getNowMonth{
    return [NSDate getNowTimeValueFor:NSMonthCalendarUnit];
}

+(NSInteger) getNowDay{
    return [NSDate getNowTimeValueFor:NSDayCalendarUnit];
}

+(NSString *) getNowFormatDay{
    NSDate *date = [NSDate date];
    return [NSDate getFormatDay:date];
}

+(NSInteger) getNowTimeValueFor:(int) type{
    NSDate *now = [NSDate date];
    return [NSDate getTimeValueFor:type withDate:now];
}

+(NSInteger) getYear:(NSDate *) date{
    return [NSDate getTimeValueFor:NSYearCalendarUnit withDate:date];
}

+(NSInteger) getMonth:(NSDate *) date{
    return [NSDate getTimeValueFor:NSMonthCalendarUnit withDate:date];
}

+(NSInteger) getDay:(NSDate *) date{
    return [NSDate getTimeValueFor:NSDayCalendarUnit withDate:date];
}

+(NSDate *) formatString:(NSString *) value withFormat:(NSString *) format{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:DEFAULT_TIME_ZONE]];
    [inputFormatter setDateFormat:format];
    NSDate* inputDate = [inputFormatter dateFromString:value];
    return inputDate;
}

+(NSString *) getFormatDay:(NSDate *) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formatday = [dateFormatter stringFromDate:date];
    return formatday;
}
+ (NSString *)getFormatTime:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *formatday = [dateFormatter stringFromDate:date];
    return formatday;
}

+(NSString *) getFormat:(NSString *) format withDate:(NSDate *) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *formatday = [dateFormatter stringFromDate:date];
    return formatday;
}

+(NSInteger) getTimeValueFor:(int) type withDate:(NSDate *) date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSInteger value = 0;
    switch (type) {
        case NSYearCalendarUnit:
        {
            value = [dateComponent year];
        }
            break;
        case NSMonthCalendarUnit:
        {
            value = [dateComponent month];
        }
            break;
        case NSDayCalendarUnit:
        {
            value = [dateComponent day];
        }
            break;
        case NSHourCalendarUnit:
        {
            value = [dateComponent hour];
        }
            break;
        case NSMinuteCalendarUnit:
        {
            value = [dateComponent minute];
        }
            break;
        case NSSecondCalendarUnit:
        {
            value = [dateComponent second];
        }
        default:
            break;
    }
    return value;
}

+(NSDate *) yesterDay:(NSDate *) date{
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] - 24*3600)];
    return newDate;
}

+(NSDate *) nextDay:(NSDate *) date{
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] + 24*3600)];
    return newDate;
}

+(NSInteger)getWeekday:(NSDate *) date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:DEFAULT_TIME_ZONE];
    comps = [calendar components:unitFlags fromDate:date];
    return [comps weekday];
}

+(NSString *) getWeekdayString:(NSDate *) date{
    NSInteger weekday = [NSDate getWeekday:date];
    NSString *weekdayString = @"周";
    NSArray *weeks = [[NSArray alloc] initWithObjects:@"",@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    
    if (weekday < 8 && weekday > 0) {
        weekdayString = [weekdayString stringByAppendingString:weeks[weekday]];
    }else{
        weekdayString = @"未知";
    }

    return weekdayString;
}

@end
