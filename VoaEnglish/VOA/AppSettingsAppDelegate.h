//
//  AppSettingsAppDelegate.h
//  VOA应用主协议
//  
//  Created by song zhao on 12-2-2.
//  Copyright (c) 2012年 buaa. All rights reserved.
//  test github branches

#import "ASIFormDataRequest.h" //网络交互
#import "RegexKitLite.h" //正则表达式
#import "VOAView.h" //最新界面
#import "DDXML.h" //XML解析
#import "DDXMLElementAdditions.h" //XML解析
#import "PlayViewController.h" //播放界面
#import "StudyTime.h" //学习时间统计
#import "UIImage+SplitImageIntoTwoParts.h"

@interface AppSettingsAppDelegate : UIResponder <UIApplicationDelegate,UIScrollViewDelegate,ASIHTTPRequestDelegate> 
{
    UIView * myView; //用户帮助视图
    
    UIWindow *windowOne, *windowTwo; //iPhone和iPad界面
    
    UITabBarController  *rootControllerOne, *rootControllerTwo; //iPhone和iPad的主视图容器
    
    UIScrollView * scrollView; //展示用户帮助的滑动视图
    
    UIPageControl * pageControl; //用户帮助的页控制
    
    NSUInteger numOfPages; //用户帮助的页数
}


@property (retain, nonatomic) IBOutlet UIWindow *windowOne;
@property (retain, nonatomic) IBOutlet UIWindow *windowTwo;
@property (retain, nonatomic) IBOutlet UITabBarController  *rootControllerOne;
@property (retain, nonatomic) IBOutlet UITabBarController  *rootControllerTwo;
//@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) UIView *myView;
@property (retain, nonatomic) UIScrollView *scrollView;
@property (retain, nonatomic) UIPageControl * pageControl;

@property (nonatomic,strong) UIImageView *left;
@property (nonatomic,strong) UIImageView *right;
@property (nonatomic,strong) UIImageView *leftDefault;
@property (nonatomic,strong) UIImageView *rightDefault;
//@property (retain, nonatomic) UIView *myViewDefault;
/**
 *  设置Flurry需要实现的方法
 */
void uncaughtExceptionHandler(NSException *exception);

@end 
