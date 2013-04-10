//
//  ROWebNavigationViewController.h
//  RenrenSDKDemo
//
//  Created by xiawh on 11-11-14.
//  Copyright (c) 2011年 renren－inc. All rights reserved.
//

#import "ROBaseNavigationViewController.h"
#import "ROResponse.h"
#import "RODialog.h"
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonDigest.h>
#import "ASIHTTPRequest.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"

@interface ROWebNavigationViewController : ROBaseNavigationViewController<ASIHTTPRequestDelegate,UIWebViewDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>{
    UIWebView *_webView;
    NSString *_serverURL;
    ROResponse* _response;
    NSMutableDictionary *_params;
    id<RODialogDelegate> _delegate;
//    UIActivityIndicatorView *_indicatorView;
    MBProgressHUD * HUD;
}
@property(nonatomic, assign)id<RODialogDelegate> delegate;
@property (nonatomic,retain)UIWebView *webView;
@property (nonatomic,retain)NSString *serverURL;
@property (nonatomic,retain)ROResponse *response;
@property (nonatomic,retain)NSMutableDictionary *params;
//@property (nonatomic,retain)UIActivityIndicatorView *indicatorView;

@end