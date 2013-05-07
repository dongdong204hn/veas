//
//  feedbackView.h
//  VOA
//  用户反馈容器
//  Created by song zhao on 12-2-11.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "ASIFormDataRequest.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "Reachability.h"//isExistenceNetwork
#import "Constants.h"

/**
 *  
 */
@interface feedbackView : UIViewController<ASIHTTPRequestDelegate,UITextFieldDelegate,UITextViewDelegate>{
    UITextView *_feedback; //反馈内容文本框
    UITextField *_mail; //反馈邮箱文本框
    UIAlertView *_alert; 
    BOOL isiPhone;
}

@property(nonatomic,retain) IBOutlet UITextView *feedback;
@property(nonatomic,retain) IBOutlet UITextField *mail;
@property(nonatomic,retain) UIAlertView *alert;
@property(nonatomic) BOOL isiPhone;
@property(nonatomic) BOOL sendLock;

- (void)sendFeedback;

@end
