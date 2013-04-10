//
//  InnerBuyController.h
//  BBC
//  内购容器
//  Created by song zhao on 12-9-6.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> //操作layer
#import "SVStoreKit.h"
#import "MBProgressHUD.h"



@interface InnerBuyController : UIViewController <SVStoreKitDelegate> {
    BOOL isIphone;
    UILabel *intro; //内购秒数
    UIButton *buyBtn; //购买按钮
    UIButton *recoverBtn; //恢复购买按钮
    SVStoreKit *storeKit; //内购工具对象
    MBProgressHUD *HUD; 
}

@property (nonatomic) BOOL isIphone;
@property (nonatomic, retain) UILabel *intro;
@property (nonatomic, retain) UIButton *buyBtn;
@property (nonatomic, retain) UIButton *recoverBtn;
@property (nonatomic, retain) SVStoreKit *storeKit;
@property (nonatomic, retain) MBProgressHUD *HUD;

@end
