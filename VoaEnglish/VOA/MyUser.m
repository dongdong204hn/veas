//
//  MyUser.m
//  VOA
//
//  Created by song zhao on 12-3-15.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "MyUser.h"

@implementation MyUser
@synthesize  _userId;
@synthesize  _userName;
@synthesize  _code;
@synthesize  _mail;
@synthesize _remember;

- (BOOL) insert
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
//	NSString *findSql = [NSString stringWithFormat:@"insert into user( _userId, _userName, _code, _mail) values(%d,\"%@\",\"%@\",\"%@\");",self._userId,self._userName,self._code,self._mail];
    
    NSString *findSql = [NSString stringWithFormat:@"insert into user(userId, userName, code) values(%d,\"%@\",\"%@\");",self._userId,self._userName,self._code];
	if([dataBase executeUpdate:findSql]) {
//        NSLog(@"--success!");
        return YES;
	}
	else {
//		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[errAlert show];
//        [errAlert release], errAlert = nil;
	}
    return NO;
}

+ (NSString *) findCodeByName:(NSString *)userName
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    //    const char *myVoaid = [voaid UTF8String];//NSString转变为字符数组
    //    int myVoaid = voaid.intValue;//NSString转变为整型
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select code FROM user WHERE userName = \"%@\" and remCode = 1",userName];
	rs = [dataBase executeQuery:findSql];
	
	NSString *code = nil;
	
	if([rs next]) {
        code = [rs stringForColumn:@"code"];
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	
	[rs close];
    //	[dataBase close];//
	return code;
}

+ (NSString *) findNameById:(NSInteger)userId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    //    const char *myVoaid = [voaid UTF8String];//NSString转变为字符数组
    //    int myVoaid = voaid.intValue;//NSString转变为整型
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select userName FROM user WHERE userId = %d ",userId];
	rs = [dataBase executeQuery:findSql];
	
	NSString *userName = nil;
	
	if([rs next]) {
        userName = [rs stringForColumn:@"userName"];
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	
	[rs close];
    //	[dataBase close];//
	return userName;
}

+ (NSInteger) findIdByName:(NSString *)userName
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    //    const char *myVoaid = [voaid UTF8String];//NSString转变为字符数组
    //    int myVoaid = voaid.intValue;//NSString转变为整型
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select userId FROM user WHERE userName = \"%@\";",userName];
	rs = [dataBase executeQuery:findSql];
	
	NSInteger userId = 0;
	
	if([rs next]) {
        userId = [rs intForColumn:@"userId"];
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	
	[rs close];
    //	[dataBase close];//
	return userId;
}

+ (void) acceptRem:(NSString *)userName
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	NSString *findSql = [NSString stringWithFormat:@"update user set remCode = 1 WHERE userName = \"%@\" ;",userName];
	if([dataBase executeUpdate:findSql]) {
//        NSLog(@"--success!");
	}
	else {
	}
}
+ (void) cancelRem:(NSString *)userName{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	NSString *findSql = [NSString stringWithFormat:@"update user set remCode = 0 WHERE userName = \"%@\" ;",userName];
	if([dataBase executeUpdate:findSql]) {
//        NSLog(@"--success!");
	}
	else {
	}
}
@end
