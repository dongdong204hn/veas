//
//  ShareToCNBox.h
//  ShareToCN
//
//  Created by hli on 7/7/11.
//  Copyright 2011 mr.pppoe. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "OAuthEngine.h"
#import "ShareToCN.h"
#import "ASIHTTPRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import "DDXML.h"
#import "DDXMLElementAdditions.h"

@interface ShareToCNBox : NSObject{

    int _maxUnitCount;
    int _unitCharCount;
    
    //< GUI Comps
    UIImageView *_imageView;
    UIView *_coverView;
    UIView *_containerView;
}

@property (nonatomic, assign) int maxUnitCount;
@property (nonatomic, assign) int unitCharCount;
@property (nonatomic, retain) NSString *link;
@property NSInteger titleId;

+ (void)showWithText:(NSString *)text;
+ (void)showWithText:(NSString *)text link:(NSString *)link titleId:(NSInteger)titleId;
+ (UIImage*)screenshot;
@end
