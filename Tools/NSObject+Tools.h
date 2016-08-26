//
//  NSObject+Tools.h
//  工具封装
//
//  Created by Bubble on 16/8/23.
//  Copyright © 2016年 Bubble. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Tools)

//------------------------- MARK:验证类
/**
 *  手机号码
 */
- (BOOL)isVerifyTel;
/**
 *  邮箱
 */
- (BOOL)isVerifyEmail;
/**
 *  昵称
 */
- (BOOL)isVerifyNike;
/**
 *  年龄
 */
- (BOOL)isVerifyAge;


//----------------------MARK:转化类
/**
 *  字符串格式时间戳转化成NSDate
 */
-(NSDate *)getDateWithTimestamp;
/**
 *  根据类型将字符类型时间戳转化成时间格式
 */
-(NSString *)getDateWithTimeStye:(NSString *)stye;
/**
 *  字典转模型
 */
- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource;





@end
