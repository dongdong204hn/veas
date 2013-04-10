//
//  SVStoreKit.h
//  CET4Free
//
//  Created by Seven Lee on 12-9-4.
//  Copyright (c) 2012年 iyuba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreKit/StoreKit.h"
#import "Reachability.h"

@class SVStoreKit;
@protocol SVStoreKitDelegate <NSObject>

- (void) storeKit:(SVStoreKit *)storeKit FailedWithError:(NSError *) error;
- (void) storeKit:(SVStoreKit *)storeKit produtRequestDidFinished:(NSArray *)products;
- (void) productPurchased:(NSString *)identifier;
- (void) storeKitRestoreComplete:(SVStoreKit *)storeKit;

@end

enum RequestFrom {
    RequestFromProduct = 4,
    RequestFromIdentifier = 5,
    RequestFromDelegate = 6
};
@interface SVStoreKit : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>{
//    SVProduct * _product;
    NSArray * _products;
//    NSSet * _identifiersSet;
    SKProductsRequest * _request;
    id<SVStoreKitDelegate> _delegate;
    NSInteger _tag;
    enum RequestFrom _requestFrom;
    BOOL _buying ;
}
//@property (nonatomic, strong) SVProduct * product;
@property (nonatomic, strong) NSArray * products;
@property (nonatomic, strong) SKProductsRequest * request;
//@property (nonatomic, strong) NSSet * identifiersSet;
@property (nonatomic, strong) id<SVStoreKitDelegate> delegate;
@property (nonatomic, assign) NSInteger tag;

//初始化
-(id) initWithDelegate:(id<SVStoreKitDelegate>) dele;

//用来获取参数idSet中所有identifier相关的产品信息，并以数组形式保存在products中，元素为SKProduct类，数组在委托方法中返回
- (void) requestProductsWithIds:(NSSet*)idSet;

//若存在网络返回YES，否则返回NO
+(BOOL)networkExist;

//指定参数的产品是否被购买（是否被存在standardDefaults里）
+(BOOL)productPurchased:(NSString *)identifier;

//购买指定产品
- (void)buyProduct:(SKProduct *)product;

//购买指定id的产品
- (void)buyIdentifier:(NSString *)identifier;

//恢复购买
- (void) restorePurchase;

+ (NSString *)localizedPriceStringOfProduct:(SKProduct *)product;
@end
