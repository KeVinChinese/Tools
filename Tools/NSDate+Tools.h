//
//  NSDate+Toolkit.h
//  hwb
//
//  Created by Bubble on 15/10/6.
//  Copyright © 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Tools)

+ (NSString *)transformLongStrToDateStr:(NSString *)longStr format:(NSString *)format;
//时间转换
+ (NSString *)transformLongStrToDateStr:(NSString *)longStr format:(NSString *)format andTimeZone:(NSString *)timeZone;
+ (NSString *)interceptDateWith:(NSString *)str;
+ (NSString *)transformDatetoLongStr:(NSDate *)date;

+(NSInteger) getNowYear;
+(NSInteger) getNowMonth;
+(NSInteger) getNowDay;
+(NSString *) getNowFormatDay;
+(NSInteger) getNowTimeValueFor:(int) type;

//输出NSDate 确定Value的格式
+(NSDate *) formatString:(NSString *) value withFormat:(NSString *) format;

+(NSInteger) getYear:(NSDate *) date;
+(NSInteger) getMonth:(NSDate *) date;
+(NSInteger) getDay:(NSDate *) date;

//使用特定的格式输出Str
+(NSString *) getFormat:(NSString *) format withDate:(NSDate *) date;

+(NSString *) getFormatDay:(NSDate *) date;
+ (NSString *)getFormatTime:(NSDate *)date;
+(NSInteger) getTimeValueFor:(int) type withDate:(NSDate *) date;

+(NSDate *) yesterDay:(NSDate *) date;
+(NSDate *) nextDay:(NSDate *) date;

+(NSInteger)getWeekday:(NSDate *) date;
+(NSString *) getWeekdayString:(NSDate *) date;

@end
