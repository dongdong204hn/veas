//
//  SVShareTool.m
//  CET6
//
//  Created by Seven Lee on 12-5-17.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "SVShareTool.h"

@implementation SVShareTool
@synthesize titleId;
@synthesize delegate;
@synthesize ViewController;
@synthesize Message;
@synthesize renren;

static SVShareTool * ShareTool;
+ (SVShareTool *) DefaultShareTool{
    if (!ShareTool) {
        ShareTool = [[SVShareTool alloc] init];
    }
    return ShareTool;
}
- (id)init{
    self = [super init];
    if (self) {
        delegate = nil;
        ViewController = nil;
//        _engine = nil;
//        weiboClient = nil;
//        composeViewController = nil;
        Message = nil;
        RenRenFeedParam = nil;
        WeiboImg = nil;
    }
    return self;
}
//- (void) GetScreenshotAndShareOnWeibo:(UIViewController *)FatherController WithContent:(NSString *)Content AndDelegate:(id<SVShareToolDelegate>)_delegate{
//    self.delegate = _delegate;
//    self.ViewController = FatherController;
//    UIImage * img = [self screenshot];
//    WeiboImg = img;
//    [self ShareOnWeibo:FatherController WithImage:img andContent:Content];
////    //Take a screenshot 
////    UIWindow * window = FatherController.view.window;
////
////    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
////        UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0.0);
////    else
////        UIGraphicsBeginImageContext(window.bounds.size);
////    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
////    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
////    [self ShareOnWeibo:FatherController WithImage:image andContent:Content];
//////    NSData * data = UIImagePNGRepresentation(image);
//////    [data writeToFile:@"foo.png" atomically:YES];
//}
//- (UIImage*)screenshot 
//{
//    // Create a graphics context with the target size
//    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
//    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
//    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
////    CGSize imageSize = ViewController.navigationController.view.bounds.size;
//    if (NULL != UIGraphicsBeginImageContextWithOptions)
//        UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
//    else
//        UIGraphicsBeginImageContext(imageSize);
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    // Iterate over every window from back to front
//    for (UIWindow *window in [[UIApplication sharedApplication] windows]) 
//    {
//        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
//        {
//            // -renderInContext: renders in the coordinate space of the layer,
//            // so we must first apply the layer's geometry to the graphics context
//            CGContextSaveGState(context);
//            // Center the context around the window's anchor point
//            CGContextTranslateCTM(context, [window center].x, [window center].y);
//            // Apply the window's transform about the anchor point
//            CGContextConcatCTM(context, [window transform]);
//            // Offset by the portion of the bounds left of and above the anchor point
//            CGContextTranslateCTM(context,
//                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
//                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
//            
//            // Render the layer hierarchy to the current context
//            [[window layer] renderInContext:context];
//            
//            // Restore the context
//            CGContextRestoreGState(context);
//        }
//    }
//    
//    // Retrieve the screenshot image
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    CGRect contentRectToCrop = CGRectMake(0, 20, 320, 460);
////    UIImage *imageout = UIGraphicsGetImageFromCurrentImageContext();
//    
//    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], contentRectToCrop);
//    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
//    return croppedImage;
//}


//- (UIImage *)grabScreen {
//    unsigned char buffer[320*480*4];
//    glReadPixels(0,0,320,480,GL_RGBA,GL_UNSIGNED_BYTE,&buffer);
//    
//    CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, &buffer, 320*480*4, NULL);
//    CGImageRef iref = CGImageCreate(320,480,8,32,320*4,CGColorSpaceCreateDeviceRGB(),kCGBitmapByteOrderDefault,ref,NULL,true,kCGRenderingIntentDefault);
//    CGFloat width = CGImageGetWidth(iref);
//    CGFloat height = CGImageGetHeight(iref);
//    size_t length = width*height*4;
//    uint32_t *pixels = (uint32_t *)malloc(length);
//    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, 320*4, CGImageGetColorSpace(iref), kCGImageAlphaLast | kCGBitmapByteOrder32Big);
//    CGContextTranslateCTM(context, 0.0, height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextDrawImage(context, CGRectMake(0.0, 0.0, width, height), iref);
//    CGImageRef outputRef = CGBitmapContextCreateImage(context);
//    UIImage *outputImage = [UIImage imageWithCGImage:outputRef];
//    
////    UIImageWriteToSavedPhotosAlbum(outputImage, nil, nil, nil); 
//    
//    CGContextRelease(context);
//    CGImageRelease(iref);
//    CGDataProviderRelease(ref);
//    return outputImage;
//} 
//- (void) ShareOnWeibo:(UIViewController *)FatherController WithImage:(UIImage *)Image andContent:(NSString *)Content{
//    self.Message = Content;
//    
//    if (!_engine){
//		_engine = [[OAuthEngine alloc] initOAuthWithDelegate: self];
//		_engine.consumerKey = kOAuthConsumerKey;
//		_engine.consumerSecret = kOAuthConsumerSecret;
//	}
//    UIViewController *controller = [OAuthController controllerToEnterCredentialsWithEngine: _engine delegate: self];
//	
//	if (controller) 
//		[FatherController presentModalViewController: controller animated: YES];
//	else {
//		NSLog(@"Authenicated for %@..", _engine.username);
//		[OAuthEngine setCurrentOAuthEngine:_engine];
//        composeViewController = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil];
//        [FatherController presentModalViewController:composeViewController animated:YES];
//        [composeViewController newTweet];
//        composeViewController.messageTextField.text = self.Message;
//        [composeViewController AddImage:Image];
//    }
//
//}
- (void) PublishFeedOnRenRen:(UIViewController *)FatherController WithFeedParam:(NSMutableDictionary *)param TitleId:(NSString *) mytitleId{
    self.renren = [Renren sharedRenren];
    self.ViewController = FatherController;
    RenRenFeedParam = [[NSMutableDictionary alloc]initWithDictionary:param];
    self.titleId = mytitleId;
//    RenRenFeedParam = param;
    if (![self.renren isSessionValid]) {
//        NSLog(@"无效");
		NSArray *permissions = [NSArray arrayWithObjects:@"read_user_album",@"status_update",@"photo_upload",@"publish_feed",@"create_album",@"operate_like",nil];
//        NSLog(@"param2:%@",[param valueForKey:@"action_name"]);
		[self.renren authorizationWithPermisson:permissions andDelegate:self];
	} else {
//         NSLog(@"有效");
//		RenrenPublishViewController *publishViewController = [[RenrenPublishViewController alloc] initWithNibName:@"RenrenPublishViewController" bundle:nil];
//		publishViewController.renren = self.renren;
//		[self.ViewController presentModalViewController:publishViewController animated:YES];
//        NSLog(@"param1:%@",[param valueForKey:@"action_name"]);
        [self.renren dialogInNavigation:@"feed" andParams:param andDelegate:self TitleId:titleId];
	}
}

- (void) RenrenLogout{
    [self.renren logout:self];
}
//#pragma mark OAuthEngineDelegate
//- (void) storeCachedOAuthData: (NSString *) data forUsername: (NSString *) username {
//	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
//	
//	[defaults setObject: data forKey: @"authData"];
//	[defaults synchronize];
//}
//
//- (NSString *) cachedOAuthDataForUsername: (NSString *) username {
//	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
//}
//
//- (void)removeCachedOAuthDataForUsername:(NSString *) username{
//	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
//	
//	[defaults removeObjectForKey: @"authData"];
//	[defaults synchronize];
//}
//#pragma mark OAuthSinaWeiboControllerDelegate
//- (void) OAuthController: (OAuthController *) controller authenticatedWithUsername: (NSString *) username {
//	NSLog(@"Authenicated for %@", username);
////    [self ShareOnWeibo:ViewController WithImage:WeiboImg andContent:self.Message];
//    //	[self loadTimeline];
//    
//    
//}
//
//- (void) OAuthControllerFailed: (OAuthController *) controller {
//	NSLog(@"Authentication Failed!");
//	//UIViewController *controller = [OAuthController controllerToEnterCredentialsWithEngine: _engine delegate: self];
//	
//	if (controller) 
//		[ViewController presentModalViewController: controller animated: YES];
//	
//}
//
//- (void) OAuthControllerCanceled: (OAuthController *) controller {
//	NSLog(@"Authentication Canceled.");
//	//UIViewController *controller = [OAuthController controllerToEnterCredentialsWithEngine: _engine delegate: self];
//	
//	//if (controller) 
//    //[self presentModalViewController: controller animated: YES];
//	
//}
#pragma mark RenRenDelegate
/**
 * 接口请求成功，第三方开发者实现这个方法
 * @param renren 传回代理服务器接口请求的Renren类型对象。
 * @param response 传回接口请求的响应。
 */
- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse*)response{
    NSLog(@"requestDidReturnResponse:%@",response.description);
}

/**
 * 接口请求失败，第三方开发者实现这个方法
 * @param renren 传回代理服务器接口请求的Renren类型对象。
 * @param response 传回接口请求的错误对象。
 */
- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error{
    NSLog(@"requestFailWithError%@",error);
}

/**
 * renren取消Dialog时调用，第三方开发者实现这个方法
 * @param renren 传回代理授权登录接口请求的Renren类型对象。
 */
- (void)renrenDialogDidCancel:(Renren *)renren{
    NSLog(@"renrenDialogDidCancel");
}
/**
 * 授权登录成功时被调用，第三方开发者实现这个方法
 * @param renren 传回代理授权登录接口请求的Renren类型对象。
 */
- (void)renrenDidLogin:(Renren *)renren{
    NSLog(@"renrenDidLogin");
    NSLog(@"RenRenFeedParam:%@",[RenRenFeedParam valueForKey:@"action_name"]);
    [self.renren dialogInNavigation:@"feed" andParams:RenRenFeedParam andDelegate:self TitleId:titleId];
}

/**
 * 用户登出成功后被调用 第三方开发者实现这个方法
 * @param renren 传回代理登出接口请求的Renren类型对象。
 */
- (void)renrenDidLogout:(Renren *)renren{
//    [renreno logout:self];
    NSLog(@"renrenDidLogout");
}

/**
 * 授权登录失败时被调用，第三方开发者实现这个方法
 * @param renren 传回代理授权登录接口请求的Renren类型对象。
 */
- (void)renren:(Renren *)renren loginFailWithError:(ROError*)error{
    NSLog(@"loginFailWithError%@",error);
} 
#pragma mark RODialogDelegate
- (void)authDialog:(RODialog *)dialog withOperateType:(RODialogOperateType )operateType{
    if (operateType == RODialogOperateFailure) {
        NSLog(@"error:%@",dialog.response.error);
    }
    if (operateType == RODialogOperateCancel) {
        NSLog(@"RODialogOperateCancel");
    }
    if (operateType == RODialogOperateSuccess) {
        NSLog(@"RODialogOperateSuccess");
    }
}

- (void)widgetDialog:(RODialog *)dialog withOperateType:(RODialogOperateType )operateType{
    if (operateType == RODialogOperateFailure) {
        NSLog(@"error:%@",dialog.response.error);
    }
    if (operateType == RODialogOperateCancel) {
        NSLog(@"RODialogOperateCancel");
    }
    if (operateType == RODialogOperateSuccess) {
        NSLog(@"RODialogOperateSuccess");
    }
}

@end
