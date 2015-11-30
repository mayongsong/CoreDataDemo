//
//  LoginViewController.m
//  CoreDataDemo
//
//  Created by mys on 15/11/26.
//  Copyright © 2015年 mys. All rights reserved.
//

#import "LoginViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginWithQQ:(id)sender{
    [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        NSLog(@"%d",result);
        if (result) {
            //成功登录后，判断该用户的ID是否在自己的数据库中。
            //如果有直接登录，没有就将该用户的ID和相关资料在数据库中创建新用户。
            
        }
    }];
}

@end
