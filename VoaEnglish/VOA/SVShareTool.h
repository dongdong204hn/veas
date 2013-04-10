//
//  SVShareTool.h
//  CET6
//
//  Created by Seven Lee on 12-5-17.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "OAuthController.h"
//#import "WeiboClient.h"
//#import "ComposeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Renren.h"
#import "ROConnect.h"


@class SVShareTool;

@protocol SVShareToolDelegate <NSObject>


@end

//@interface SVShareTool : NSObject<OAuthEngineDelegate,OAuthControllerDelegate,RenrenDelegate,RODialogDelegate,UIAlertViewDelegate>{
//    OAuthEngine				*_engine;
//	WeiboClient *weiboClient;
//    //	NSMutableArray *statuses;
//	ComposeViewController *composeViewController;
    id<SVShareToolDelegate> delegate;
@interface SVShareTool : NSObject<RenrenDelegate,RODialogDelegate,UIAlertViewDelegate>{
    UIViewController * ViewController;
    NSString * Message;
    Renren * renren;
    NSMutableDictionary * RenRenFeedParam;
    UIImage * WeiboImg;
}
@property (nonatomic, strong) id<SVShareToolDelegate> delegate;
@property (nonatomic, strong) UIViewController * ViewController;
@property (nonatomic, strong) NSString * Message;
@property (nonatomic, strong) Renren * renren;
@property (nonatomic, strong) NSString * titleId;

+ (SVShareTool *) DefaultShareTool;
//- (void) GetScreenshotAndShareOnWeibo:(UIViewController *)FatherController WithContent:(NSString *)Content AndDelegate:(id<SVShareToolDelegate>)_delegate;
////- (void) ShareOnWeibo:(UIViewController *)FatherController WithImage:(UIImage *)Image andContent:(NSString *)Content;
- (void) PublishFeedOnRenRen:(UIViewController *)FatherController WithFeedParam:(NSMutableDictionary *)param TitleId:(NSString *) titleId;
- (void) RenrenLogout;
@end
