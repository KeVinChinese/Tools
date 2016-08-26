//
//  Tools.m
//  工具封装
//
//  Created by Bubble on 16/8/23.
//  Copyright © 2016年 Bubble. All rights reserved.
//

#import "Tools.h"
#import <AddressBook/AddressBook.h>



@implementation Tools



/**
 *  倒计时
 */
+ (void)Timer:(NSInteger)surplusSecond Process:(void(^)(NSInteger num))process Finish:(void(^)())finish{
    //全局并发队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //主队列；属于串行队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    //定时循环执行事件
    //dispatch_source_set_timer 方法值得一提的是最后一个参数（leeway），他告诉系统我们需要计时器触发的精准程度。所有的计时器都不会保证100%精准，这个参数用来告诉系统你希望系统保证精准的努力程度。如果你希望一个计时器每5秒触发一次，并且越准越好，那么你传递0为参数。另外，如果是一个周期性任务，比如检查email，那么你会希望每10分钟检查一次，但是不用那么精准。所以你可以传入60，告诉系统60秒的误差是可接受的。他的意义在于降低资源消耗。
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    
    __block NSInteger _surplusSecond = surplusSecond;
    dispatch_source_set_event_handler(timer, ^{ //计时器事件处理器
        
        if (_surplusSecond <= 0) {
            dispatch_source_cancel(timer); //取消定时循环计时器；使得句柄被调用，即事件被执行
            dispatch_async(mainQueue, ^{
                if (finish) {
                    finish();
                }
                
            });
        } else {
            
            dispatch_async(mainQueue, ^{
                if (process) {
                    process(_surplusSecond);
                }
            });
            _surplusSecond--;
        }
    });
    dispatch_source_set_cancel_handler(timer, ^{ //计时器取消处理器；调用 dispatch_source_cancel 时执行
        NSLog(@"Cancel Handler");
    });
    dispatch_resume(timer);  //恢复定时循环计时器；Dispatch Source 创建完后默认状态是挂起的，需要主动恢复，否则事件不会被传递，也不会被执行
    
}



/**
 *  判断是否共享通讯录
 *  需要导入CoreTelephony.framework
 */
+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error){
                    NSLog(@"Error: %@", (__bridge NSError *)error);
                }
                else if (!granted)
                {
                    block(NO);
                }
                else
                {
                    block(YES);
                }
            });
        });
    }
    else
    {
        block(YES);
    }
    
}


/**
 *  根据当前经纬度得到城市名称  需要导入 CoreLocation.framework
 */
+ (NSArray<CLPlacemark *> *)getcitywithLatitude:(NSString *)latitude Longitude:(NSString *)longitude {
    
    NSArray<CLPlacemark *> * placemark = [NSArray array];
    CLGeocoder * geocoderManager = [[CLGeocoder alloc]init];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:longitude.intValue longitude:longitude.intValue];
    __block NSArray<CLPlacemark *> * myplacemark  = placemark;
    [geocoderManager reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        myplacemark = placemarks;
    }];
    return placemark;
}

/**
 *  反地理便把得到经纬度
 */
+(CLLocationCoordinate2D)getcoordinateWithName:(NSString *)oreillyAddress{
    
    CLLocationCoordinate2D Location;
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    __block CLLocationCoordinate2D myLocation = Location;
    [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
            NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
            NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
            myLocation = firstPlacemark.location.coordinate;
        }
        
    }];
    return Location;
}




+(UIImage *) imageWithColor:(UIColor *) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



/**
 *  alert的展示
 */
+ (void)showAlertWithTittle:(NSString *)tittle Message:(NSString *)message CancelTittle:(NSString *)cancelTittle ConfirmTittle:(NSString *)confirmTittle ViewController:(UIViewController *)VC Cancel:(void(^)())Cancel Confirm:(void(^)())Confirm{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:tittle message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:cancelTittle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        Cancel();
    }];
    
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:confirmTittle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Confirm();
    }];
    
    [alert addAction:cancel];
    [alert addAction:confirm];
    [VC presentViewController:alert animated:YES completion:nil];

    
}


//sheet的展示
+ (void) showSheetWithTittle:(NSString *)tittle Message:(NSString *)message CancelTittle:(NSString *)cancelTittle SubTittles:(NSArray *)SubTittles ViewController:(UIViewController *)VC Cancel:(void (^)())Cancel Confirm:(void (^)(int i))Confirm{
    
    UIAlertController * Sheet = [UIAlertController alertControllerWithTitle:tittle message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:cancelTittle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        Cancel();
    }];
    [Sheet addAction:cancel];
    for (int i = 0; i < SubTittles.count ; i++) {
        UIAlertAction * subAction = [UIAlertAction actionWithTitle:SubTittles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            Confirm(i);
        }];
        [Sheet addAction:subAction];
    }
    [VC presentViewController:Sheet animated:YES completion:nil];
}

/**
 *  带有时间的sheet
 */
+ (void)showSheetAndTimeStyle:(UIDatePickerMode)style Tittle:(NSString *)tittle CurrentTime:(NSDate *)currenttime CancelTittle:(NSString *)cancelTittle ConfirmTittle:(NSString *)confirmTittle ViewController:(UIViewController *)VC Cancel:(void (^)())Cancel Confirm:(void (^)(NSString * date))Confirm{
    
    UIAlertController * sheet = [UIAlertController alertControllerWithTitle:tittle message:@"\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:cancelTittle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        Cancel();
    }];
    UIDatePicker * picker = [[UIDatePicker alloc]init];
    picker.datePickerMode = style;
    picker.date = currenttime;
    
    
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:confirmTittle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *destDateString = [dateFormatter stringFromDate:picker.date];
        
        Confirm(destDateString);
    }];
    [sheet addAction:confirm];
    [sheet addAction:cancel];
    [sheet.view addSubview:picker];
    [VC presentViewController:sheet animated:YES completion:nil];
    
}



+ (CGSize) sizeWithText:(NSString *) text withFontSize:(float) fontSize withMaxSize:(CGSize) maxSize{
    CGSize size;
    if (text) {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil];
        size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
        
    }
    return size;
}








@end
