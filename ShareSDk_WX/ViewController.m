//
//  ViewController.m
//  ShareSDk_WX
//
//  Created by 李林 on 16/6/16.
//  Copyright © 2016年 李林. All rights reserved.
//

#import "ViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)clickShareButton:(id)sender{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];

    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
}

// 微信登录授权
-(IBAction)clickAuthButton:(id)sender{
    
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                             message:@"已获取授权"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil, nil];
             [alert show];
             
             NSLog(@"uid=%@"        ,user.uid);
             NSLog(@"%@"            ,user.credential);
             NSLog(@"token=%@"      ,user.credential.token);
             NSLog(@"nickname=%@"   ,user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

@end
