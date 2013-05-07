//
//  THUtility.h
//  1.0.0
//  Base64 encode&decode
//  Created by TanHao on 12-12-10.
//  Copyright (c) 2012年 tanhao.me. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *
 */
@interface THUtility : NSObject

+ (NSString *)encodeBase64WithData:(NSData *)objData;
+ (NSData *)decodeBase64WithString:(NSString *)string;

+ (NSString *)encodeBase64AtURL:(NSURL *)fileUrl;
+ (NSData *)decodeBase64AtURL:(NSURL *)fileUrl;

+ (BOOL)encodeBase64AtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL;
+ (BOOL)decodeBase64AtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL;

@end
