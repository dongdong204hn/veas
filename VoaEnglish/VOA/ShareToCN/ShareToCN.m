//
//  ShareToCN.m
//  ShareToCN
//
//  Created by Haoxiang on 7/6/11.
//  Copyright 2011 mr.pppoe All rights reserved.
//

#import "ShareToCN.h"
#import "WBEngine.h"
#import "WBAuthorize.h"
#import "WBUtil.h"
#import "ASIFormDataRequest.h"

#import <QuartzCore/QuartzCore.h>

#define kActiveIndicatorTag 0x1234

#define kBorderWidth 10.0f
#define kPadding 52.0f

#define kTransitionDuration 0.3f

//< For Sina
//#define kSinaKeyCodeLead @"获取到的授权码"
//#define kSinaCode @"code="
//#define kSinaPostImagePath @"http://api.t.sina.com.cn/statuses/upload.json"
//#define kSinaPostPath @"http://api.t.sina.com.cn/statuses/update.json"

static ShareToCN *sharedCenter = nil;

@interface ShareToCN (Private) <UIWebViewDelegate, WBEngineDelegate, WBAuthorizeDelegate>

+ (ShareToCN *)center;
- (BOOL)touchForAuth;
- (void)afterAuth;
- (void)postTweet;
- (void)dismissView;
//- (void)showView;

@end

@implementation ShareToCN
@synthesize _autho;
@synthesize text = _text;
@synthesize image = _image;
@synthesize delegate = _delegate;
@synthesize _engine;

- (id)init
{
    self = [super init];
    if (self) {
//        NSLog(@"新建CENTER");
        _engine = [[WBEngine alloc] initWithAppKey:kShareToCNKey appSecret:kShareToCNSecret];
        _engine.appKey = kShareToCNKey;
        _engine.appSecret = kShareToCNSecret;
        [_engine setDelegate:self];
        [_engine setRedirectURI:@"http://www.iyuba.com"];
        [_engine setIsUserExclusive:NO];
        
//        _autho = [[WBAuthorize alloc] initWithAppKey:kShareToCNKey appSecret:kShareToCNSecret];
//        _autho.appKey = kShareToCNKey;
//        _autho.appSecret = kShareToCNSecret;
//        [_autho setDelegate:self];
//        [_autho setRedirectURI:@"http://www.iyuba.com"];
//        [OAuthEngine setCurrentOAuthEngine:_engine];

        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        
        //< CoverView
        _containerView = [[UIView alloc] initWithFrame:keyWindow.bounds];
        _containerView.backgroundColor = [UIColor darkGrayColor];
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kPadding + kBorderWidth, 
                                                               keyWindow.frame.size.width, 
                                                               keyWindow.frame.size.height - 2 * (kPadding + kBorderWidth))];
        _webView.delegate = self;
        _webView.alpha = 0.0f;        
        [_containerView addSubview:_webView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = _containerView.bounds;
        button.alpha = 0.1f;
        [button addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [_containerView addSubview:button];
        [_containerView sendSubviewToBack:button];
        
        UIActivityIndicatorView *activeIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activeIndicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
                                         | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        activeIndicator.tag = kActiveIndicatorTag;
        activeIndicator.hidden = YES;
        activeIndicator.frame = CGRectMake(CGRectGetMidX(_webView.bounds) - 20.0f,
                                           CGRectGetMidY(_webView.bounds) - 20.0f,
                                           40.0f, 40.0f);
        [_webView addSubview:activeIndicator];
        [activeIndicator release];
        
    }
    return self;
}

- (void)clearCookies{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

- (void)dealloc
{
    
    self.text = nil;
    self.image = nil;
    
    [_containerView release];
    [_engine release];
    [_webView release];
    [super dealloc];
}

#pragma mark Methods
//+ (void)logoutSn{
//    [];
//}

+ (void)shareText:(NSString *)text {
    [ShareToCN shareText:text withDelegate:nil];
}

+ (void)shareText:(NSString *)text WithImage:(UIImage *)image {
    [ShareToCN shareText:text WithImage:image withDelegate:nil];
}

+ (void)shareText:(NSString *)text withDelegate:(id<ShareToCNDelegate>)delegate {
    [ShareToCN shareText:text WithImage:nil withDelegate:delegate];
}

+ (void)shareText:(NSString *)text WithImage:(UIImage *)image withDelegate:(id<ShareToCNDelegate>)delegate {
//    NSLog(@"获取授权页面实例");
    ShareToCN *center = [ShareToCN center];
    center.text = text;
    center.delegate = delegate;
    center.image = image;
//    NSLog(@"检测授权状态");
    if ([center touchForAuth])
    {
        [center postTweet];
        
    }
    
}

+ (void)logoutSn{
//    if (sharedCenter) {
//        ShareToCN *center = [ShareToCN center];
//        [center._engine signOut];
////        [center dealloc];
////        [ShareToCN centerDel];
//    }
    ShareToCN *center = [ShareToCN center];
    [center._engine logOut];
    [center clearCookies];
}

@end
@implementation ShareToCN (Private)

+ (ShareToCN *)center {
    if (!sharedCenter)
    {
        sharedCenter = [[ShareToCN alloc] init];
    }
    return sharedCenter;
}

- (BOOL)touchForAuth {
    
    if (![_engine isAuthorizeExpired] && [_engine isLoggedIn])
    {
//        NSLog(@"已经授权");
        return YES;
    }
//    NSLog(@"未授权");
    //< Not Authorized
//    if (!_engine.isLoggedIn)
//    {
        [_engine logIn];
        
//    } 
//    [_engine.authorize startAuthorize];
    //< Reveal a WebView for Authorization
    if (_containerView.superview)
    {
        [_containerView removeFromSuperview];
    }
    
//    [self showView];
    
    return NO;
}

//- (void)showView {
////    NSLog(@"展现授权页面");
//    [[[UIApplication sharedApplication] keyWindow] addSubview:_containerView];
//    
//    _containerView.backgroundColor = [UIColor darkGrayColor];
//    _webView.alpha = 1.0f;
//    _webView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
//    _containerView.alpha = 1.0f;
//    
//    [UIView beginAnimations:@"auth" context:nil];
//    [UIView setAnimationDidStopSelector:@selector(showViewAnim1)];
//    [UIView setAnimationDelegate:self];
//    
//    _containerView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.6f];
//    [_webView setScalesPageToFit:YES];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@", _engine.appKey, _engine.redirectURI]]]];
//    _webView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
//    
//    [UIView commitAnimations];
//        
//}
//
//- (void)showViewAnim1 {
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:kTransitionDuration/2];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(showViewAnim2)];
//    _webView.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
//    [UIView commitAnimations];
//}
//
//- (void)showViewAnim2 {
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:kTransitionDuration/2];
//    _webView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
//    [UIView commitAnimations];    
//}

- (void)postTweet {
    ShareToCN *center = [ShareToCN center];
    [_engine sendWeiBoWithText:center.text image:center.image];
}

//- (void)postTweet {
//    
//    NSString* path = (self.image ? kSinaPostImagePath : kSinaPostPath);
//    
////    NSString *postString = @"song";
//    NSString *postString = [NSString stringWithFormat:@"status=%@",
//                            [self.text encodeAsURIComponent]]; 
//    
//    NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)path, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
//    [URL autorelease];
//    NSURL *finalURL = [NSURL URLWithString:URL];
//    OAMutableURLRequest* req = [[[OAMutableURLRequest alloc] initWithURL:finalURL
//                                                                consumer:_engine.consumer 
//                                                                   token:_engine.accessToken 
//                                                                   realm: nil
//                                                       signatureProvider:nil] autorelease];
//    [req setHTTPMethod:@"POST"];
//    [req setHTTPShouldHandleCookies:NO];
//    
//    NSString *textBody = [NSString stringWithString:postString];
//    textBody = [textBody stringByAppendingString:[NSString stringWithFormat:@"%@source=%@", 
//                                                  (postString) ? @"&" : @"?" , 
//                                                  _engine.consumerKey]];
//    
//    [req setHTTPBody:[textBody dataUsingEncoding:NSUTF8StringEncoding]];
//
//    NSError *err = nil;
//    
//    [(OAMutableURLRequest *)req prepare];
//    
//    ASIFormDataRequest *asiReq = [ASIFormDataRequest requestWithURL:[req URL]];
//    [asiReq setRequestHeaders:[NSMutableDictionary dictionaryWithCapacity:1]];
//    [asiReq.requestHeaders setDictionary:[req allHTTPHeaderFields]];
//    [asiReq setPostValue:self.text forKey:@"status"];
//    [asiReq setPostValue:_engine.consumerKey forKey:@"source"];
//    if (self.image)
//    {
//        NSData *jpegImageData = UIImageJPEGRepresentation(self.image, 1.0f);
//        [asiReq addData:jpegImageData withFileName:@"image.jpeg" andContentType:@"image/jpeg" forKey:@"pic"];
//    }
//    
//    [asiReq startSynchronous];
//    
//    err = asiReq.error;
//    
//    if (err)
//    {
//        //< Error Handle
////        NSLog(@"Error %@", err);
//        if (self.delegate)
//        {
//            [self.delegate shareFailedWithError:err];
//        }
//    }
//    else
//    {
////        NSLog(@"成功发送");
//        if (self.delegate)
//        {
////            NSLog(@"有协议");
//            [self.delegate shareSucceed];
//        }
//    }
//}

- (void)afterAuth {
//    NSLog(@"授权后发送");
    [self postTweet];
}

- (void)dismissView {
    
    [UIView beginAnimations:@"afterAuth" context:nil];
    [UIView setAnimationDuration:kTransitionDuration];
    [UIView setAnimationDelegate:_containerView];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    
    _webView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    _containerView.alpha = 0.0f;
    
    [UIView commitAnimations];
}

/*
#pragma mark UIWebViewDelegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
////    NSLog(@"%@", request);  
//    return YES;
//}

- (void)webViewDidStartLoad:(UIWebView *)webView {
//    NSString *returnCode = [[NSString alloc] initWithData:[webView.request HTTPBody] encoding:NSASCIIStringEncoding];
//    NSLog(@"code:%@", returnCode);
//     NSLog(@"1111code request :%@", webView.request);
    UIActivityIndicatorView *activeIndicator = (UIActivityIndicatorView *)[webView viewWithTag:kActiveIndicatorTag];
    [activeIndicator sizeToFit];
    [activeIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //< The Pin Code, Copy-Paste from https://github.com/JimLiu/WeiboSDK
//    @try{
//        NSLog(@"1111code request :%@", [[webView.request URL] absoluteString]);
//        NSRange codeRan = [[[webView.request URL] absoluteString] rangeOfString:kSinaCode];
//        NSString *code = [[[webView.request URL] absoluteString] substringFromIndex:codeRan.location+5];
//        NSLog(@"code:%@", code);
//        if ([code length] > 0) {
////            _autho 
//        }
//        NSString *returnCode = [NSString stringWithContentsOfURL:webView.request.URL encoding:NSASCIIStringEncoding error:nil];
//        NSLog(@"code:%@", returnCode);
////        NSString *pin;
////        
////        NSString *html = [webView stringByEvaluatingJavaScriptFromString: @"document.body.innerText"];
////        if ([html rangeOfString:kSinaKeyCodeLead].length > 0)
////        {        
////            if (html.length == 0) 
////            {
////                pin = nil;
////            }
////            else
////            {
////                const char *rawHTML = (const char *) [html UTF8String];
////                int	length = strlen(rawHTML), chunkLength = 0;
////                
////                for (int i = 0; i < length; i++) {
////                    if (rawHTML[i] < '0' || rawHTML[i] > '9') {
////                        if (chunkLength == 6) {
////                            char *buffer = (char *) malloc(chunkLength + 1);				
////                            memmove(buffer, &rawHTML[i - chunkLength], chunkLength);
////                            buffer[chunkLength] = 0;
////                            
////                            pin = [NSString stringWithUTF8String:buffer];
////                            free(buffer);
////                        }
////                        chunkLength = 0;
////                    } else
////                        chunkLength++;
////                }
////            }
////            
//            if (pin && [pin length] > 0)
//            {
//                _engine.pin = pin;
//                [_engine requestAccessToken];
//                
//                [self performSelector:@selector(dismissView) withObject:nil afterDelay:0.001f];
//                [self performSelector:@selector(afterAuth) withObject:nil afterDelay:0.1f]; //< Skip some run loops
//            }
////        }
//    } @catch (NSException *e) {
//        
//    }
//
//    UIActivityIndicatorView *activeIndicator = (UIActivityIndicatorView *)[_webView viewWithTag:kActiveIndicatorTag];
//    activeIndicator.hidden = YES;
//    [activeIndicator stopAnimating];    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {    
    
    if (self.delegate)
    {
        [self.delegate shareFailedWithError:error];
    }

    UIActivityIndicatorView *activeIndicator = (UIActivityIndicatorView *)[_webView viewWithTag:kActiveIndicatorTag];
    activeIndicator.hidden = YES;
    [activeIndicator stopAnimating];    

    [self performSelector:@selector(dismissView) withObject:nil afterDelay:0.5f];
}


- (BOOL) webView: (UIWebView *) webView shouldStartLoadWithRequest: (NSURLRequest *) request navigationType: (UIWebViewNavigationType) navigationType {
	NSData				*data = [request HTTPBody];
	char				*raw = data ? (char *) [data bytes] : "";
//	NSLog(@"data:%s", raw);
	if (raw && strstr(raw, "cancel=")) {
//		[self denied];/////
		return NO;
	}
	if (navigationType != UIWebViewNavigationTypeOther) _webView.alpha = 1.0;//保证登录失败时登录框仍然明显置前
	return YES;
}
*/

//#pragma mark OAuthEngineDelegate
//- (void) storeCachedOAuthData: (NSString *) data forUsername: (NSString *) username {
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];	
//	[defaults setObject:data forKey: @"authData"];
//	[defaults synchronize];
//}
//
//- (NSString *) cachedOAuthDataForUsername: (NSString *) username {
//	return [[NSUserDefaults standardUserDefaults] objectForKey:@"authData"];
//}
//
//- (void)removeCachedOAuthDataForUsername:(NSString *) username{
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];	
//	[defaults removeObjectForKey: @"authData"];
//	[defaults synchronize];
//}
    
#pragma mark WBAuthorizeDelegate
- (void)authorize:(WBAuthorize *)authorize didSucceedWithAccessToken:(NSString *)accessToken userID:(NSString *)userID expiresIn:(NSInteger)seconds {
//    NSLog(@"成功授权");
    [self postTweet];
}

- (void)authorize:(WBAuthorize *)authorize didFailWithError:(NSError *)error {

}
        
#pragma mark WBEngineDelegate 

- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result {
    if (self.delegate)
    {
        //            NSLog(@"有协议");
        [self.delegate shareSucceed];
    }
//    NSLog(@"成功发送");
}

- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error
{
    if (self.delegate)
    {
        [self.delegate shareFailedWithError:error];
    }
}

@end
