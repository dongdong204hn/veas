//
//  InnerBuyController.m
//  BBC
//
//  Created by song zhao on 12-9-6.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "InnerBuyController.h"

@interface InnerBuyController ()

@end

@implementation InnerBuyController
@synthesize isIphone;
@synthesize intro;
@synthesize buyBtn;
@synthesize recoverBtn;
@synthesize HUD;
@synthesize storeKit;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)doBuy:(UIButton *) btn {
    
    NSLog(@"购买");
    switch (btn.tag) {
        case 2: //恢复购买
            NSLog(@"恢复购买");
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            HUD.labelText = @"正在恢复，请稍候";
            [self.view addSubview:HUD];
//            [HUD release];
            HUD.removeFromSuperViewOnHide = YES;
            [HUD show:YES];
            if (!storeKit) {
                storeKit = [[SVStoreKit alloc] initWithDelegate:self];
            }
            [storeKit restorePurchase];
            break;
        case 1: //购买
        {
            NSLog(@"购买");
            if (![SVStoreKit productPurchased:kBePro]) {
                storeKit = [[SVStoreKit alloc] initWithDelegate:self];
                [storeKit buyIdentifier:kBePro];
                //            storeKit.tag = IAPAlertTagText;
                HUD = [[MBProgressHUD alloc] initWithView:self.view];
                HUD.labelText = @"购买中";
                [self.view addSubview:HUD];
//                [HUD release];
                HUD.removeFromSuperViewOnHide = YES;
                [HUD show:YES];
            }
        }
            break;
        default:
            break;
    }
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kBePro];
}

- (void)loadView {
    isIphone = ![Constants isPad];
    buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recoverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIView *myView = [[UIView alloc] init];
    if (isIphone) {
        [myView setFrame:CGRectMake(0, 0, 320, 416)];
        intro = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 260, 200)];
        [buyBtn setFrame:CGRectMake(80, 250, 160, 30)];
        [recoverBtn setFrame:CGRectMake(80, 290, 160, 30)];
    } else {
        [myView setFrame:CGRectMake(0, 0, 768, 960)];
        intro = [[UILabel alloc] initWithFrame:CGRectMake(184, 50, 400, 400)];
        [buyBtn setFrame:CGRectMake(302, 500, 160, 50)];
        [recoverBtn setFrame:CGRectMake(302, 600, 160, 50)];
    }
    [buyBtn setTag:1];
    [recoverBtn setTag:2];
    [myView addSubview:intro];
    [intro release];
    [myView addSubview:buyBtn];
    [myView addSubview:recoverBtn];
    self.view = myView;
    [myView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
	// Do any additional setup after loading the view.
    [intro setText:@"升级为专业版,享受最佳体验:\n1.去除广告条(重启应用后生效)\n2.开启离线词库,无网环境照常学习,全面提升英语能力!\n3.功能加强!\n4.永久更新!"];
    [intro setNumberOfLines:0];
    [intro setBackgroundColor:[UIColor clearColor]];
    [intro setTextColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];
    
    [buyBtn setShowsTouchWhenHighlighted:YES];
    [buyBtn addTarget:self action:@selector(doBuy:) forControlEvents:UIControlEventTouchUpInside];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] || [[NSUserDefaults standardUserDefaults] boolForKey:@"isVip"]) {
        [buyBtn setTitle:@"已升级至专业版" forState:UIControlStateNormal];
        [buyBtn setUserInteractionEnabled:NO];
    } else {
        [buyBtn setTitle:@"升级至专业版" forState:UIControlStateNormal];
    }

    [buyBtn setBackgroundColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];
    [[buyBtn layer] setCornerRadius:10.0f];
    [[buyBtn layer] setMasksToBounds:YES];
    
    [recoverBtn setShowsTouchWhenHighlighted:YES];
    [recoverBtn addTarget:self action:@selector(doBuy:) forControlEvents:UIControlEventTouchUpInside];
    [recoverBtn setTitle:@"恢复已购买产品" forState:UIControlStateNormal];
    [recoverBtn setBackgroundColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];
    [[recoverBtn layer] setCornerRadius:10.0f];
    [[recoverBtn layer] setMasksToBounds:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc {
    [self.storeKit release], storeKit = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark SVStoreKitDelegate
- (void)storeKit:(SVStoreKit *)storeKit FailedWithError:(NSError *)error{
    NSLog(@"storeKitFailed:%@",error);
    [HUD hide:YES];
    if (error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"Transaction error: %@", error.localizedDescription);
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"购买失败" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
- (void) storeKit:(SVStoreKit *)_storeKit produtRequestDidFinished:(NSArray *)products{
    NSLog(@"%@",products);
    HUD.labelText = @"正在购买";
    //    for (SKProduct * product in products) {
    //        [_storeKit buyProduct:product];
    // ;   }
}
- (void) productPurchased:(SVStoreKit *)_storeKit{
    [HUD hide:YES];
    [buyBtn setTitle:@"已升级至专业版" forState:UIControlStateNormal];
    [buyBtn setUserInteractionEnabled:NO];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"购买成功" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
//    [self ensureIAPandDeleteAd:YES];
    //    storeKit = nil;
    [self.storeKit release];
    storeKit = nil;
}
- (void) storeKitRestoreComplete:(SVStoreKit *)_storeKit{
    [HUD hide:YES];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"恢复成功" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
    [self.storeKit release];
    storeKit = nil;
//    [self ensureIAPandDeleteAd:YES];
}

@end
