//
//  MyUser.h
//  VOA
//  用户信息数据类
//  Created by song zhao on 12-3-15.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "favdatabase.h"

@interface MyUser : NSObject
{
    NSInteger _userId;
    NSString * _userName;
    NSString * _code; //密码
    NSString * _mail; //邮箱
    NSInteger _remember; //是否设置记住密码 1：是 0：否
}

@property NSInteger  _userId;
@property NSInteger _remember;
@property (nonatomic, retain) NSString * _userName;
@property (nonatomic, retain) NSString * _code;
@property (nonatomic, retain) NSString * _mail;

- (BOOL) insert;
+ (NSString *) findCodeByName:(NSString *)userName;
+ (NSString *) findNameById:(NSInteger)userId;
+ (void) acceptRem:(NSString *)userName;
+ (void) cancelRem:(NSString *)userName;
+ (NSInteger) findIdByName:(NSString *)userName;

//+ (BOOL) isRem:(NSString *)userName;

@end
