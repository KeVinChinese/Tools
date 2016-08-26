//
//  Tools.h
//  工具封装
//
//  Created by Bubble on 16/8/23.
//  Copyright © 2016年 Bubble. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject


+ (void)Timer:(NSInteger)surplusSecond Process:(void(^)(NSInteger num))process Finish:(void(^)())finish;
+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block;


+(CLLocationCoordinate2D)getcoordinateWithName:(NSString *)oreillyAddress;
+ (NSArray<CLPlacemark *> *)getcitywithLatitude:(NSString *)latitude Longitude:(NSString *)longitude;

+(UIImage *) imageWithColor:(UIColor *) color;

+ (void)showAlertWithTittle:(NSString *)tittle Message:(NSString *)message CancelTittle:(NSString *)cancelTittle ConfirmTittle:(NSString *)confirmTittle ViewController:(UIViewController *)VC Cancel:(void(^)())Cancel Confirm:(void(^)())Confirm;

+ (void) showSheetWithTittle:(NSString *)tittle Message:(NSString *)message CancelTittle:(NSString *)cancelTittle SubTittles:(NSArray *)SubTittles ViewController:(UIViewController *)VC Cancel:(void (^)())Cancel Confirm:(void (^)(int i))Confirm;

//带有时间的sheet
+ (void)showSheetAndTimeStyle:(UIDatePickerMode)style Tittle:(NSString *)tittle CurrentTime:(NSDate *)currenttime CancelTittle:(NSString *)cancelTittle ConfirmTittle:(NSString *)confirmTittle ViewController:(UIViewController *)VC Cancel:(void (^)())Cancel Confirm:(void (^)(NSString * date))Confirm;

+ (CGSize) sizeWithText:(NSString *) text withFontSize:(float) fontSize withMaxSize:(CGSize) maxSize;



@end
