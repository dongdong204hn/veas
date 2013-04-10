//
//  SVStoreKit.m
//  CET4Free
//
//  Created by Seven Lee on 12-9-4.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import "SVStoreKit.h"
#import "JSON.h"
#import "NSString+SBJSON.h"
#import "NSData+Base64.h"

@interface SVStoreKit (privateMethods)
- (void) requestProducts:(NSSet*)idSet;
- (void) timeout;
@end

@implementation SVStoreKit
//@synthesize product = _product;
@synthesize products = _products;
@synthesize delegate = _delegate;
//@synthesize identifiersSet = _identifiersSet;
@synthesize request = _request;
@synthesize tag = _tag;

-(id) initWithDelegate:(id<SVStoreKitDelegate>) dele{
    if (self = [super init]) {
        self.delegate = dele;
        self.products = nil;
//        self.identifiersSet = nil;
        self.request = nil;
        self.tag = 0;
        _requestFrom = RequestFromDelegate;
        _buying = NO;
    }
    return self;
}
- (void)buyIdentifier:(NSString *)identifier{
    NSSet * set = [NSSet setWithObject:identifier];
    _requestFrom = RequestFromIdentifier;
    [self requestProducts:set];
}
- (void) requestProductsWithIds:(NSSet*)idSet{
    _requestFrom = RequestFromDelegate;
    [self requestProducts:idSet];
}
- (void) requestProducts:(NSSet*)idSet{
    if ([SKPaymentQueue canMakePayments]) {
        self.request = [[SKProductsRequest alloc] initWithProductIdentifiers:idSet];
        _request.delegate = self;
        NSLog(@"requestProducts");
        [_request start];
    }
    else {
        
        NSError * err = [NSError errorWithDomain:@"iap not supported" code:0 userInfo:[NSDictionary dictionaryWithObject:@"内部购买不可用" forKey:NSLocalizedDescriptionKey]];
        if (_delegate && [_delegate respondsToSelector:@selector(storeKit:FailedWithError:)]) {
            [_delegate storeKit:self FailedWithError:err];
        }
    }
}
- (void) timeout{
    if (_buying) {
        [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
        NSError * err = [NSError errorWithDomain:@"time out" code:0 userInfo:[NSDictionary dictionaryWithObject:@"连接超时，请稍候再试" forKey:NSLocalizedDescriptionKey]];
        if (_delegate && [_delegate respondsToSelector:@selector(storeKit:FailedWithError:)])
            [_delegate storeKit:self FailedWithError:err];
    }
}
+(BOOL)networkExist{
    Reachability *reach = [Reachability reachabilityForInternetConnection];    
    NetworkStatus netStatus = [reach currentReachabilityStatus];    
    return netStatus != NotReachable;
}
+(BOOL)productPurchased:(NSString *)identifier{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:identifier]) {
        return YES;
    }
    return NO;
}

- (void)buyProduct:(SKProduct *)product{
    NSLog(@"Buying %@...", product.productIdentifier);
//    _requestFrom = RequestFromProduct;
    if ([SKPaymentQueue canMakePayments]) {
        _buying = YES;
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [self performSelector:@selector(timeout) withObject:nil afterDelay:40.0];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
    }
    else {
        NSError * err = [NSError errorWithDomain:@"iap not supported" code:0 userInfo:[NSDictionary dictionaryWithObject:@"内部购买不可用" forKey:NSLocalizedDescriptionKey]];
        if (_delegate && [_delegate respondsToSelector:@selector(storeKit:FailedWithError:)])
            [_delegate storeKit:self FailedWithError:err];
    }
    
}
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"completeTransaction...");
    
//    [self recordTransaction: transaction];
    [self provideContent: transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    if (_delegate && [_delegate respondsToSelector:@selector(productPurchased:)]) {
        [_delegate productPurchased:transaction.payment.productIdentifier];
    }
    
}
- (void) restorePurchase{
//    if ([SKPaymentQueue canMakePayments]) {
    _buying = YES;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    NSLog(@"restoring");
    [self performSelector:@selector(timeout) withObject:nil afterDelay:40.0];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
//    }
//    else {
//        NSError * err = [NSError errorWithDomain:nil code:0 userInfo:[NSDictionary dictionaryWithObject:@"内部购买不可用" forKey:NSLocalizedDescriptionKey]];
//        if (_delegate && [_delegate respondsToSelector:@selector(storeKit:FailedWithError:)])
//            [_delegate storeKit:self FailedWithError:err];
//    }

}
- (void)provideContent:(NSString *)productIdentifier {
    
    NSLog(@"Toggling flag for: %@", productIdentifier);
    [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (void)failedTransaction:(SKPaymentTransaction *)transaction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(storeKit:FailedWithError:)]) {
        [_delegate storeKit:self FailedWithError:transaction.error];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"restoreTransaction...");
    
//    [self recordTransaction: transaction];
    [self provideContent: transaction.originalTransaction.payment.productIdentifier];
    
    if (_delegate && [_delegate respondsToSelector:@selector(storeKitRestoreComplete:)]) {
        [_delegate storeKitRestoreComplete:self];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void)buyProductIdentifier:(NSString *)identifier{
    for (SKProduct * p in _products) {
        if ([p.productIdentifier isEqualToString:identifier]) {
            [self buyProduct:p];
            return;
        }
    }
    NSLog(@"wrong identifier");
}
+ (NSString *)localizedPriceStringOfProduct:(SKProduct *)product{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:product.priceLocale];
    NSString *formattedString = [numberFormatter stringFromNumber:product.price];
    [numberFormatter release];
    return formattedString;
}
#pragma mark -
#pragma mark iap cracker defense
-(BOOL)putStringToItunes:(NSData*)iapData{//用户购成功的transactionReceipt
    
    NSString*encodingStr = [iapData base64EncodedString];
//#if DEBUG
//    NSString *URL=@"https://sandbox.itunes.apple.com/verifyReceipt";
    NSString *URL=@"https://buy.itunes.apple.com/verifyReceipt";
//#endif//发布时URL换为下面的
    //https://buy.itunes.apple.com/verifyReceipt
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];// autorelease];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    //设置contentType
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", [encodingStr length]] forHTTPHeaderField:@"Content-Length"];  
    
    NSDictionary* body = [NSDictionary dictionaryWithObjectsAndKeys:encodingStr, @"receipt-data", nil];
    SBJsonWriter *writer = [SBJsonWriter new];
    [request setHTTPBody:[[writer stringWithObject:body] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSHTTPURLResponse *urlResponse=nil;
    NSError *errorr=nil;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&urlResponse
                                                             error:&errorr];
    
    //解析
    NSString *results=[[NSString alloc]initWithBytes:[receivedData bytes] length:[receivedData length] encoding:NSUTF8StringEncoding];
    NSLog(@"-Himi-  %@",results);
    NSDictionary*dic = [results JSONValue];
    if([[dic objectForKey:@"status"] intValue]==0){//注意，status=@"0" 是验证收据成功
        return true;
    }
    return false;
}
#pragma mark - 
#pragma mark SKProductRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"didReceiveResponse");
    self.request = nil;
//    self.products = [NSMutableArray array];
    switch (_requestFrom) {
        case RequestFromDelegate:
            self.products = response.products;
            if (_delegate && [_delegate respondsToSelector:@selector(storeKit:produtRequestDidFinished:)]) {
                [_delegate storeKit:self produtRequestDidFinished:_products];
            }
            break;
        case RequestFromIdentifier:
            if ([response.products count] >= 1) {
                [self buyProduct:[response.products objectAtIndex:0]];
            }
            else {
                NSError * err = [NSError errorWithDomain:@"can not connect to iTunes sotre" code:0 userInfo:[NSDictionary dictionaryWithObject:@"获取商品信息失败" forKey:NSLocalizedDescriptionKey]];
                if (_delegate && [_delegate respondsToSelector:@selector(storeKit:FailedWithError:)]) {
                    [_delegate storeKit:self FailedWithError:err];
                }
            }
        default:
            break;
    }
    
}
- (void) request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
    if (_delegate && [_delegate respondsToSelector:@selector(storeKit:FailedWithError:)]) {
        [_delegate storeKit:self FailedWithError:error];
    }
}
#pragma mark paymentQueue
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    _buying = NO;
    NSLog(@"updatedTransactions");
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
//                if ([self putStringToItunes:transaction.transactionReceipt]) {//检测
                    [self completeTransaction:transaction];
                    NSLog(@"购买成功");
//                }
//                else {
//                    NSError * err = [NSError errorWithDomain:@"iap Cracker found" code:0 userInfo:[NSDictionary dictionaryWithObject:@"监测到您的设备正在使用IAP Cracker，故无法购买此产品" forKey:NSLocalizedDescriptionKey]];
//                    if (_delegate && [_delegate respondsToSelector:@selector(storeKit:FailedWithError:)]) {
//                        [_delegate storeKit:self FailedWithError:err];
//                    }
//                }
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                NSLog(@"购买失败");
                break;
            case SKPaymentTransactionStateRestored:
//                if ([self putStringToItunes:transaction.transactionReceipt]) {
                    [self restoreTransaction:transaction];
                    NSLog(@"恢复成功");
//                }
//                else {
//                    NSError * err = [NSError errorWithDomain:@"iap Cracker found" code:0 userInfo:[NSDictionary dictionaryWithObject:@"监测到您的设备正在使用IAP Cracker，故无法购买此产品" forKey:NSLocalizedDescriptionKey]];
//                    if (_delegate && [_delegate respondsToSelector:@selector(storeKit:FailedWithError:)]) {
//                        [_delegate storeKit:self FailedWithError:err];
//                    }
//                }
                break;
            default:
                break;
        }
    }
//    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self ];
}

@end
