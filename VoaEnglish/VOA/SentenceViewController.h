//
//  SentenceViewController.h
//  VOA
//  展示收藏句子详细内容的容器
//  Created by iyuba on 12-11-21.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayViewController.h"

/**
 *  展示收藏句子详细内容的容器
 */
@interface SentenceViewController : UIViewController{
    NSInteger row; //正在展示的句子序列
    NSInteger nowUserId; //当前用户id
    UITextView *SenEn; //英文内容
    UITextView *SenCn; //中文内容
    MBProgressHUD *HUD; //等待图标
    NSArray * sentences; //句子队列
    UIImageView *myImageView; //新闻图片视图
}

@property (nonatomic, retain) IBOutlet UITextView *SenEn;
@property (nonatomic, retain) IBOutlet UITextView *SenCn;
@property (nonatomic, retain) IBOutlet UIImageView *myImageView;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) NSArray *sentences;
@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger nowUserId;

-(IBAction)preSen:(id)sender;
-(IBAction)nextSen:(id)sender;

@end
