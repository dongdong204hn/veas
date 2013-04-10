//
//  LogViewController.h
//  VOA
//  登录容器
//  Created by song zhao on 12-3-14.
//  Copyright (c) 2012年 buaa. All rights reserved.
//
#import "RegistViewController.h"
//#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"//contain method isExistenceNetwork
#import "ROUtility.h"

@interface LogController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *logTable;
    UILabel *userL;
    UILabel *codeL;
    UILabel *nowUser;
    UITextField *userF;
    UITextField *codeF;
    UIButton *remCodeL;
    UIButton *remCode;
    UIButton *registBtnTwo;
    UIButton *logBtnTwo;
    UIButton *logOutBtn;
    UIAlertView *alert;
    UIImageView *afterLog;
    UIImageView *userImg;
    BOOL isiPhone;
    //    BOOL isExisitNet;
}

@property (nonatomic, retain) IBOutlet UITableView *logTable;
@property (nonatomic, retain) IBOutlet UIButton *registBtnTwo;
@property (nonatomic, retain) IBOutlet UIButton *logBtnTwo;
@property (nonatomic, retain) IBOutlet UIButton *logOutBtn;
@property (nonatomic, retain) IBOutlet UILabel *nowUser;
@property (nonatomic, retain) IBOutlet UIButton *remCode;
@property (nonatomic, retain) IBOutlet UIButton *remCodeL;
@property (nonatomic, retain) IBOutlet UIButton *yubBtn;
@property (nonatomic, retain) IBOutlet UIButton *yubNumBtn;
@property (nonatomic, retain) IBOutlet UIImageView *afterLog;
@property (nonatomic, retain) IBOutlet UIImageView *userImg;
@property (nonatomic, retain) UILabel *userL;
@property (nonatomic, retain) UILabel *codeL;
@property (nonatomic, retain) UITextField *userF;
@property (nonatomic, retain) UITextField *codeF;
@property (nonatomic) BOOL isiPhone;
//@property (nonatomic) BOOL isExisitNet;

- (IBAction) doRegist:(UIButton *)sender;
- (IBAction) doCatchYub:(UIButton *)sender;
- (IBAction) doLog:(UIButton *)sender;
-(BOOL) isExistenceNetwork:(NSInteger)choose;
- (void)catchLogs;
//- (void)catchNetA;
- (void)catchYub:(NSString  *)userID;
- (IBAction) doLogout:(UIButton *)sender;
- (IBAction) doRem:(UIButton *)sender;


@end
