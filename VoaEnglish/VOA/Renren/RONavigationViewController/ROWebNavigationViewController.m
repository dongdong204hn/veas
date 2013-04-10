//
//  ROWebNavigationViewController.m
//  RenrenSDKDemo
//
//  Created by xiawh on 11-11-14.
//  Copyright (c) 2011年 renren－inc. All rights reserved.
//

#import "ROWebNavigationViewController.h"
#import "ROUtility.h"
#import "Renren.h"

@interface ROWebNavigationViewController(Private)

- (BOOL)isAuthDialog;
    
- (void)dismissWithError:(NSError*)error animated:(BOOL)animated;
    
- (void)dialogDidSucceed:(NSURL *)url;
    
- (void)dialogDidCancel:(NSURL *)url;

@end

@implementation ROWebNavigationViewController
@synthesize webView = _webView;
@synthesize serverURL = _serverURL;
@synthesize response = _response;
@synthesize params = _params;
@synthesize delegate = _delegate;
//@synthesize indicatorView = _indicatorView;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.webView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)] autorelease];
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:self.webView];
        //        [self.webView release];
        
//        self.indicatorView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
//        self.indicatorView.hidesWhenStopped = YES;
//        self.indicatorView.center = self.webView.center;
//        [self.view addSubview:self.indicatorView];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)logout{
    [self.delegate dialogShouldLogout:self];
}
#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
- (void) viewDidAppear:(BOOL)animated{
    HUD = [[MBProgressHUD alloc] initWithView:self.webView];
    [self.webView addSubview:HUD];
    
//    [HUD release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


#pragma mark - Http connect
- (void)doShareReward{
    NSInteger nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
//    if (nowUserId > 0) {
        NSString *sign = [NSString stringWithFormat:@"%d104iosrenren%@1iyuba",nowUserId,[_params objectForKey:@"titleId"]];
//        NSLog(@"sign:%@",sign);
//        NSLog(@"md5sign:%@",[self md5:sign]);
        NSString *url = [NSString stringWithFormat:@"http://app.iyuba.com/share/doShare.jsp?userId=%d&appId=104&from=ios&to=renren&type=1&titleId=%@&sign=%@",nowUserId,[_params objectForKey:@"titleId"],[self md5:sign]];
//        NSLog(@"url song : %@",url);
        ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
        request.delegate = self;
        [request setUsername:@"share"];
        [request startAsynchronous]; 
//    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    if ([request.username isEqualToString:@"share" ]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert.tag = 9;
        [alert release];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"share" ]) {
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                int result = [[[obj elementForName:@"result"] stringValue] intValue];
                NSString *msg = [[obj elementForName:@"msg"] stringValue];
                if (result == 1) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    alert.tag = 9;
                    [alert release];
                }else {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    alert.tag = 9;
                    [alert release];
                }
            }
        }
    }
    [doc release],doc = nil;
    [myData release], myData = nil;
    request.delegate = nil;
}

#pragma mark - MD5
- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[32];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:32];
    
    for(int i = 0; i < 16; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

#pragma mark - UIWebViewDelegate Method

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
	
    HUD.delegate = self;
    HUD.labelText = @"加载中...";
	HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    NSURL *url = request.URL;
    NSString *query = [url fragment]; // url中＃字符后面的部分。
    if (!query) {
        query = [url query];
    }
    NSDictionary *params = [ROUtility parseURLParams:query];
    NSString *accessToken = [params objectForKey:@"access_token"];
    //    NSString *error_desc = [params objectForKey:@"error_description"];
    NSString *errorReason = [params objectForKey:@"error"];
    if(nil != errorReason) {
        [self dialogDidCancel:nil];
        return NO;
    }
    if (navigationType == UIWebViewNavigationTypeLinkClicked)/*点击链接*/{
        BOOL userDidCancel = ((errorReason && [errorReason isEqualToString:@"login_denied"])||[errorReason isEqualToString:@"access_denied"]);
        if(userDidCancel){
            [self dialogDidCancel:url];
        }else {
            NSString *q = [url absoluteString];
            if (![q hasPrefix:self.serverURL]) {
                [[UIApplication sharedApplication] openURL:request.URL];
            }
        }
        return NO;
    }
    if (navigationType == UIWebViewNavigationTypeFormSubmitted) {//提交表单
        NSString *state = [params objectForKey:@"flag"];
        if ((state && [state isEqualToString:@"success"])||accessToken) {
            [self dialogDidSucceed:url];
        }
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [self.indicatorView stopAnimating];
    [HUD hide:YES];
    //    self.cancelButton.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [HUD hide:YES];
    if (!([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code == 102)) {
        [self dismissWithError:error animated:YES];
    }
}

- (void)show
{
    [super show];
    NSLog(@"444");
    [self.params setObject:kWidgetDialogUA forKey:@"ua"];
    
    NSURL *url = [ROUtility generateURL:self.serverURL params:self.params];
	NSLog(@"start load URL: %@", url);
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    NSLog(@"555");
//    [self.indicatorView startAnimating];
    
}

- (void)updateSubviewOrientation 
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        [_webView stringByEvaluatingJavaScriptFromString:
         @"document.body.setAttribute('orientation', 90);"];
    } else {
        [_webView stringByEvaluatingJavaScriptFromString:
         @"document.body.removeAttribute('orientation');"];
    }
}

- (void)dialogDidSucceed:(NSURL *)url {
	NSString *q = [url absoluteString];
	if([self isAuthDialog]) {
        NSString *token = [ROUtility getValueStringFromUrl:q forParam:@"access_token"];
        NSString *expTime = [ROUtility getValueStringFromUrl:q forParam:@"expires_in"];
        NSDate   *expirationDate = [ROUtility getDateFromString:expTime];
        NSDictionary *responseDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:token,expirationDate,nil]
                                                                forKeys:[NSArray arrayWithObjects:@"token",@"expirationDate",nil]];
        self.response = [ROResponse responseWithRootObject:responseDic];
        
        if ((token == (NSString *) [NSNull null]) || (token.length == 0)) {
            [self dialogDidCancel:nil];
        } else {
            if ([self.delegate respondsToSelector:@selector(authDialog:withOperateType:)])  {
                [self.delegate authDialog:self withOperateType:RODialogOperateSuccess];
            }
        }
    }else {
        NSString *flag = [ROUtility getValueStringFromUrl:q forParam:@"flag"];	
        if ([flag isEqualToString:@"success"]) {
            NSString *query = [url fragment];
            if (!query) {
                query = [url query];
            }
            NSDictionary *params = [ROUtility parseURLParams:query];
            self.response = [ROResponse responseWithRootObject:params];
            if ([self.delegate respondsToSelector:@selector(widgetDialog:withOperateType:)]) {
                [self.delegate widgetDialog:self withOperateType:RODialogOperateSuccess];
            }
        }
    }
    
    NSInteger nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    if (nowUserId > 0) {
        [self doShareReward];
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert.tag = 9;
        [alert release];
    }
    
//    [self close];
}

- (void)dismissWithError:(NSError*)error animated:(BOOL)animated {
    self.response = [ROResponse responseWithError:[ROError errorWithNSError:error]];
    if ([self isAuthDialog]) {
        if ([self.delegate respondsToSelector:@selector(authDialog:withOperateType:)]){
            [self.delegate authDialog:self withOperateType:RODialogOperateFailure];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(widgetDialog:withOperateType:)]) {
            
            [self.delegate widgetDialog:self withOperateType:RODialogOperateFailure];
        }
    }
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"发送失败" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.tag = 9;
    [alert show];
    [alert release];
//    [self close];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 9) {
        [HUD hide:YES];
        [self close];
    }
}
- (void)dialogDidCancel:(NSURL *)url {
    if ([self isAuthDialog]) {
        if ([self.delegate respondsToSelector:@selector(authDialog:withOperateType:)]){
            [self.delegate authDialog:self withOperateType:RODialogOperateCancel];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(widgetDialog:withOperateType:)]){
            [self.delegate widgetDialog:self withOperateType:RODialogOperateCancel];
        }
    }
    
    [self close];
}
- (void) close{
    [HUD hide:YES];
    [super close];
}
- (BOOL)isAuthDialog
{
    return [_serverURL isEqualToString:kAuthBaseURL];
}

- (void)selfChangeOption:(ROBaseNavigationViewController *)newController
{
    [newController otherChangeOption:self];
}

- (void)dealloc
{
    [HUD release];
    self.webView = nil;
    self.serverURL = nil;
    self.response = nil;
    self.params = nil;
//    self.indicatorView = nil;
    [super dealloc];
}
@end
