//
//  ViewController.m
//  工具封装
//
//  Created by Bubble on 16/8/23.
//  Copyright © 2016年 Bubble. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Tools.h"
#import "Tools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * ben = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    ben.backgroundColor = [UIColor redColor];
    [self.view addSubview:ben];
    [ben addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}
-(void)show{
    
    [Tools showSheetAndTimeStyle:UIDatePickerModeDate Tittle:@"ni" CurrentTime:[NSDate date] CancelTittle:@"qu" ConfirmTittle:@"qued" ViewController:self Cancel:^{
        
    } Confirm:^(NSString *date) {
        NSLog(@"%@",date);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
