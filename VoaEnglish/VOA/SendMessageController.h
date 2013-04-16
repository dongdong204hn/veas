//
//  SendMessageController.h
//  VOA
//  “消息发送”容器
//  Created by zhao song on 13-1-23.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMessage.h"
#import "MyUser.h"
#import "NSString+URLEncoding.h"
#import "LogController.h"

@interface SendMessageController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *nameLab; //姓名标签
@property (nonatomic, retain) IBOutlet UITextView *messageTv; //消息编辑框
@property (nonatomic, retain) IBOutlet UIButton *sendBtn; //发送按钮
@property (nonatomic, retain) UserMessage *userMsg;
@property (nonatomic, retain) UIAlertView *sucAlert;
@end
