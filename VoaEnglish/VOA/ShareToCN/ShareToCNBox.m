//
//  ShareToCNBox.m
//  ShareToCN
//
//  Created by hli on 7/7/11.
//  Copyright 2011 mr.pppoe. All rights reserved.
//

#import "ShareToCNBox.h"
#import "ShareToCN.h"
#import <QuartzCore/QuartzCore.h>

#define kTagTextView 0x1234
#define kTagLabel 0x1235

static ShareToCNBox *sharedBox = nil;

static const float kVPadding = 5.0f;
static const float kHPadding = 10.0f;
static const float kUpperPartRate = 0.75f;

static const float kButtonWidth = 80.0f;
static const float kButtonHeight = 30.0f;

static const int kFontSize = 14.0f;


/////////////////////////////////////////////////////////////////////
@interface ShareToCNBoxView : UIView {
}
@end

/////////////////////////////////////////////////////////////////////
@implementation ShareToCNBoxView

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGPoint points[2];
    points[0] = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + kUpperPartRate * rect.size.height);
    points[1] = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + kUpperPartRate * rect.size.height);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokeLineSegments(context, points, 2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
//    CGFloat colors[] = {
//        0x2f/255.0f, 0x2f/255.0f, 0x2f/255.0f, 1.0f,
//        0x12/255.0f, 0x12/255.0f, 0x12/255.0f, 1.0f
//    };
    
    /*voa的黑红*/
//    CGFloat colors[] = { //设置分享框下边的颜色
//        0/255.0f, 0/255.0f, 0.f/255.0f, 1.0f,
//        198/255.0f, 18/255.0f, 0/255.0f, 1.0f
//    };
    
    CGFloat colors[] = { //设置分享框下边的颜色
        255/255.0f, 255/255.0f, 255.f/255.0f, 1.0f,
        50/255.0f, 79/255.0f, 133/255.0f, 1.0f
    };

    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    CGContextDrawLinearGradient(context, gradient, 
                                CGPointMake(CGRectGetMidX(rect), 
                                            CGRectGetMinY(rect) + kUpperPartRate * rect.size.height),
                                CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect)), 0);
    CGColorSpaceRelease(colorSpace);
}

@end

/////////////////////////////////////////////////////////////////////
@interface ShareToCNBox (Private) <ShareToCNDelegate, UITextViewDelegate>

+ (ShareToCNBox *)box;
- (void)showWithPreText:(NSString *)preText;
- (void)showWithPreText:(NSString *)preText andImage:(UIImage *)image;

- (IBAction)buttonTapped:(id)sender;

- (void)reveal;
- (void)hide;

- (void)showKeyboard;
- (void)hideKeyboard;

- (int)charCountOfString:(NSString *)string;
- (NSString *)trimString:(NSString *)string toCharCount:(int)charCount;

- (void)setBackgroundImage:(UIImage *)image;
- (UIImage *)backgroundImage;

@end

/////////////////////////////////////////////////////////////////////
@implementation ShareToCNBox
@synthesize maxUnitCount = _maxUnitCount;
@synthesize unitCharCount = _unitCharCount;
@synthesize link = _link;
@synthesize titleId = _titleId;
+ (void)showWithText:(NSString *)text {
    [[ShareToCNBox box] showWithPreText:text];
}

//+ (void)showWithText:(NSString *)text andImage:(UIImage *)image link:(NSString *)link{
//    [[ShareToCNBox box] setLink:link];
//    [[ShareToCNBox box] showWithPreText:text andImage:image];
//}

+ (void)showWithText:(NSString *)text link:(NSString *)link titleId:(NSInteger)titleId {
    [[ShareToCNBox box] setLink:link];
    [[ShareToCNBox box] setTitleId:titleId];
    [[ShareToCNBox box] showWithPreText:text andImage:[self screenshot]];
}

+ (UIImage*)screenshot  
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    //    CGSize imageSize = ViewController.navigationController.view.bounds.size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) 
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect contentRectToCrop = CGRectMake(0, 20, 320, 460);
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] || [[NSUserDefaults standardUserDefaults] boolForKey:@"isVip"])  {
        contentRectToCrop = CGRectMake(0, 20, 320, 460);
        if ([[UIScreen mainScreen]scale]>1.1) {
            contentRectToCrop = CGRectMake(0, 20, 640, 920);
        }
        if ([Constants isPad]) {
            contentRectToCrop = CGRectMake(0, 20, 768, 1004);
            if ([[UIScreen mainScreen]scale]>1.1) {
                contentRectToCrop = CGRectMake(0, 20, 768*2, 2008);
            }
        }
    }
    else {
        contentRectToCrop = CGRectMake(0, 20, 320, 410);
        if ([[UIScreen mainScreen]scale]>1.1) {
            contentRectToCrop = CGRectMake(0, 40, 640, 820);
        }
        if ([Constants isPad]) {
            contentRectToCrop = CGRectMake(0, 20, 768, 914);
            if ([[UIScreen mainScreen]scale]>1.1) {
                contentRectToCrop = CGRectMake(0, 40, 768*2, 1828);
            }
        }
    }
    
    //    UIImage *imageout = UIGraphicsGetImageFromCurrentImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], contentRectToCrop);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    return croppedImage;
}

- (id)init {
    if ((self = [super init]))
    {
        CGRect frame = CGRectMake(20, 60, 280, 200);
        if ([Constants isPad]) {
            frame = CGRectMake(244, 200, 280, 200);
        }
        
        CGRect winBounds = [[UIApplication sharedApplication] keyWindow].bounds;
        CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
        UIButton *bkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bkButton.frame = CGRectMake(0, CGRectGetMaxY(statusFrame), winBounds.size.width, winBounds.size.height - statusFrame.size.height);
        [bkButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];        
        
        _coverView = [bkButton retain];
        
        _containerView = [[ShareToCNBoxView alloc] initWithFrame:frame];
        _containerView.layer.cornerRadius = 10.0f;
        _containerView.clipsToBounds = YES;
        
        float width = frame.size.width;
        float height = frame.size.height;
        
        self.maxUnitCount = 140;
        self.unitCharCount = 2;
        
        //< GUI
        CGRect textViewRect = CGRectMake(kHPadding, kVPadding, 
                                         width - 2 * kHPadding, 
                                         height * kUpperPartRate - 2 * kVPadding);
        CGRect labelRect = CGRectMake(CGRectGetMinX(textViewRect), 
                                      height * kUpperPartRate + (height * (1.0f - kUpperPartRate) - kButtonHeight)/2.0f, 
                                      kButtonWidth, kButtonHeight);
        CGRect buttonRect = CGRectMake(CGRectGetMaxX(textViewRect) - kButtonWidth, 
                                       height * kUpperPartRate + (height * (1.0f - kUpperPartRate) - kButtonHeight)/2.0f, 
                                       kButtonWidth, kButtonHeight);
        CGRect logoutRect = CGRectMake(CGRectGetMaxX(textViewRect) - 2*kButtonWidth, /////
                                       height * kUpperPartRate + (height * (1.0f - kUpperPartRate) - kButtonHeight)/2.0f, 
                                       kButtonWidth, kButtonHeight);
        CGRect imageRect = CGRectMake(kHPadding, CGRectGetMaxY(frame) + kVPadding, 
                                      textViewRect.size.width, 
                                      winBounds.size.height - frame.size.height - kVPadding);
        if ([Constants isPad]) {
            imageRect = CGRectMake(kHPadding+240, CGRectGetMaxY(frame) + kVPadding - 150.0f, 
                                          textViewRect.size.width, 
                                          winBounds.size.height - frame.size.height - kVPadding);
        }
        
        CALayer *shadowLayer = [CALayer layer];
        shadowLayer.frame = textViewRect;
        
        UITextView *textView = [[UITextView alloc] initWithFrame:textViewRect];
        textView.layer.shadowColor = [UIColor blackColor].CGColor;
        textView.layer.shadowOffset = CGSizeMake(2, -2);
        textView.layer.shadowOpacity = 0.8f;
        textView.layer.shadowRadius = 1.0f;
        textView.font = [UIFont systemFontOfSize:kFontSize];
        textView.delegate = self;
        textView.tag = kTagTextView;
        [_containerView addSubview:textView];
        [textView release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
        label.font = [UIFont systemFontOfSize:kFontSize];
        label.textColor = [UIColor whiteColor];
        label.shadowOffset = CGSizeMake(2, 2);
        label.shadowColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%d", self.maxUnitCount];
        label.backgroundColor = [UIColor clearColor];
        label.tag = kTagLabel;
        [_containerView addSubview:label];
        [label release];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:NSLocalizedStringFromTable(@"share_to_cn_button", @"ShareToCN", @"") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = buttonRect;
        [_containerView addSubview:button];
        
        UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [logoutBtn setTitle:NSLocalizedStringFromTable(@"share_to_cn_logout", @"ShareToCN", @"") forState:UIControlStateNormal];
        [logoutBtn addTarget:self action:@selector(doLogout:) forControlEvents:UIControlEventTouchUpInside];
        logoutBtn.frame = logoutRect;
        [_containerView addSubview:logoutBtn];
        
        _imageView = [[UIImageView alloc] initWithFrame:imageRect];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_coverView addSubview:_imageView];
        
        _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
        [_coverView addSubview:_containerView];
    }
    return self;
}

- (void)dealloc {
    [_imageView release];
    [_coverView release];
    [_containerView release];
    [super dealloc];
}

@end

/////////////////////////////////////////////////////////////////////
@implementation ShareToCNBox (Private)
                          
+ (ShareToCNBox *)box {
    if (!sharedBox)
    {
        sharedBox = [[ShareToCNBox alloc] init];
    }
    return sharedBox;
}

- (void)setBackgroundImage:(UIImage *)image {
//    [(UIButton *)_coverView setBackgroundImage:image forState:UIControlStateNormal];
    _imageView.image = image;
}

- (UIImage *)backgroundImage {
//    return [(UIButton *)_coverView backgroundImageForState:UIControlStateNormal];
    return _imageView.image;
}

- (void)showWithPreText:(NSString *)preText {
    
    UITextView *textView = (UITextView *)[_containerView viewWithTag:kTagTextView];
//    textView.text = [preText substringToIndex:MIN(self.maxUnitCount * self.unitCharCount, [preText length])];
    textView.text = preText;
    [self textViewDidChange:textView];

    [self setBackgroundImage:nil];

    [self reveal];
}

- (void)showWithPreText:(NSString *)preText andImage:(UIImage *)image {

    UITextView *textView = (UITextView *)[_containerView viewWithTag:kTagTextView];
//    textView.text = [preText substringToIndex:MIN(self.maxUnitCount * self.unitCharCount, [preText length])];
    textView.text = preText;
    [self textViewDidChange:textView];
    [self setBackgroundImage:image];
    [self reveal];
}

- (void)reveal {

    if (_coverView.superview)
    {
        [_coverView removeFromSuperview];
    }
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:_coverView];
    
    _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    _containerView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    _imageView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    
    _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    _containerView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    _imageView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    
    [UIView commitAnimations];
    
}

- (void)hide {

    _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    _containerView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    _imageView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationDelegate:_coverView];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    
    _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    _containerView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    _imageView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    
    [UIView commitAnimations];

}

- (void)showKeyboard {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    
    _containerView.transform = CGAffineTransformMakeTranslation(0.0f, -30.0f);
    
    [UIView commitAnimations];
}

- (void)hideKeyboard {

    UITextView *textView = (UITextView *)[_containerView viewWithTag:kTagTextView];
    [textView resignFirstResponder];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    
    _containerView.transform = CGAffineTransformMakeTranslation(0.0f, 0.0f);
    
    [UIView commitAnimations];
    
}

- (void)cancel:(id)sender {
    UITextView *textView = (UITextView *)[_containerView viewWithTag:kTagTextView];
    if ([textView isFirstResponder])
    {
        [self hideKeyboard];
    }
    else
    {
        [self hide];
    }
}

- (int)charCountOfString:(NSString *)string {
    int count = 0;
    for (int i = 0; i < [string length]; i++)
    {
        unichar c = [string characterAtIndex:i];
        if (isblank(c) || isascii(c))
        {
            count++;
        }
        else
        {
            count += 2;
        }
    }
    return count;
}

- (NSString *)trimString:(NSString *)string toCharCount:(int)charCount {
    
    int curCharCount = [self charCountOfString:string];
    
    NSString *trimedStr = string;
    
    if (curCharCount > charCount)
    {
        int delta = curCharCount - charCount;
        for (int i = [string length] - 1; i >= 0; i--)
        {
            unichar c = [string characterAtIndex:i];
            if (isblank(c) || isascii(c))
            {
                delta--;
            }
            else
            {
                delta -= 2;
            }
            if (delta <= 0)
            {
                trimedStr = [string substringToIndex:i];
                break;
            }
        }
    }
    
    return trimedStr;
}

#pragma mark - Http connect
- (void)doShareReward{
    NSInteger nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    //    if (nowUserId > 0) {
    NSString *sign = [NSString stringWithFormat:@"%d104iosweibo%d1iyuba",nowUserId,[[ShareToCNBox box] titleId]];
//    NSLog(@"sign:%@",sign);
//    NSLog(@"md5sign:%@",[self md5:sign]);
    NSString *url = [NSString stringWithFormat:@"http://app.iyuba.com/share/doShare.jsp?userId=%d&appId=104&from=ios&to=weibo&type=1&titleId=%d&sign=%@",nowUserId,[[ShareToCNBox box] titleId],[self md5:sign]];
//    NSLog(@"url song : %@",url);
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
        [alert release];
        [self hide];
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
                    [alert release];
                }else {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
                [self hide];
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


#pragma mark ShareToCNDelegate
- (void)shareFailedWithError:(NSError *)error {
//    UITextView *textView = (UITextView *)[_containerView viewWithTag:kTagTextView];
//    textView.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedStringFromTable(@"share_to_cn_failed", @"ShareToCN", @""), error];
//    [self hide];
    UIAlertView *netAlert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:@"请勿重复发送或检查您的网络连接是否正常" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [netAlert show];
    [netAlert release];
    [self hide];
}

- (void)shareSucceed {
//    UITextView *textView = (UITextView *)[_containerView viewWithTag:kTagTextView];
//    textView.text = [NSString stringWithFormat:@"%@!", NSLocalizedStringFromTable(@"share_to_cn_succeed", @"ShareToCN", @"")];
//    [self hide];
    NSInteger nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    if (nowUserId > 0) {
        [self doShareReward];
    } else {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        [self hide];
    }
}

//- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result{
//    NSInteger nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
//    if (nowUserId > 0) {
//        [self doShareReward];
//    } else {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//        [self hide];
//    }
//}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self showKeyboard];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    textView.text = [self trimString:textView.text toCharCount:(self.maxUnitCount * self.unitCharCount)];
    
    int unitCount = ceil((float)[self charCountOfString:textView.text]/(float)self.unitCharCount);
    
    UILabel *label = (UILabel *)[_containerView viewWithTag:kTagLabel];
    label.text = [NSString stringWithFormat:@"%d", (self.maxUnitCount - unitCount)];
}

#pragma mark IBAction
- (IBAction)buttonTapped:(id)sender {
    
    [self hideKeyboard];

    UIImage *image = [self backgroundImage];
    
    UITextView *textView = (UITextView *)[_containerView viewWithTag:kTagTextView];
    
    [ShareToCN shareText:[textView.text stringByAppendingString:[[ShareToCNBox box]link]] WithImage:image withDelegate:self];
    
}

- (IBAction)doLogout:(id)sender {
//    NSLog(@"注销");
    [ShareToCN logoutSn];
    [self hide];
}

@end

/////////////////////////////////////////////////////////////////////

