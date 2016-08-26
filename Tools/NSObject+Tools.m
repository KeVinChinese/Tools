//
//  NSObject+Tools.m
//  工具封装
//
//  Created by Bubble on 16/8/23.
//  Copyright © 2016年 Bubble. All rights reserved.
//

#import "NSObject+Tools.h"
#import <objc/runtime.h>

@implementation NSObject(Tools)

//MARK:手机号
- (BOOL)isVerifyTel{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     * 170,171
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9]])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSString * phone=@"^(0(10|2[1-3]|[3-9]\\d{2}))?[1-9]\\d{6,7}$";
    
    NSString * Phone = @"^1(7[01])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphone=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",phone];
    NSPredicate * regextestPhone =[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Phone];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)
        ||([regextestphone evaluateWithObject:self]==YES)
        ||([regextestPhone evaluateWithObject:self]==YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//MARK:邮箱
-(BOOL)isVerifyEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//MARK:昵称
-(BOOL)isVerifyNike{
    NSString *nameRegex=@"^\\s*";
    NSPredicate *nameTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",nameRegex];
    return [nameTest evaluateWithObject:self];
}

//MARK:年龄
-(BOOL)isVerifyAge{
    NSString *ageRegex=@"^\\d{1,2}";
    NSPredicate *ageTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",ageRegex];
    return [ageTest evaluateWithObject:self];
}


//MARK:字符串格式时间戳转化成NSDate
-(NSDate *)getDateWithTimestamp{
    NSString * format = @"YYYY-MM-dd HH:mm:ss";
    NSDateFormatter * formatter =[self getFormatter:format];
    NSDate * date = [formatter dateFromString:self];
    return date;
}

//MARK:将字符串格式时间戳转化成日期格式
-(NSString *)getDateWithTimeStye:(NSString *)stye{
    NSDateFormatter * formatter = [self getFormatter:stye];
    NSString * str = [formatter stringFromDate:[self getDateWithTimestamp]];
    return str;
}







//字典转模型
- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource
{
    
    BOOL ret = NO;
    
    for (NSString *key in [self propertyKeys]) {
        
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
            
        }
        else
        {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        
        if (ret) {
            
            id propertyValue = [dataSource valueForKey:key];
            
            //该值不为NSNULL，并且也不为nil
            
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                
                [self setValue:propertyValue forKey:key];
            }
        }
    }
    
    return ret;
    
}




















//得到Formatter
-(NSDateFormatter *)getFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:timeZone];
    return formatter;
}

- (NSArray*)propertyKeys

{
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [keys addObject:propertyName];
        
    }
    
    free(properties);
    
    return keys;
    
}

@end
