//
//  UserMessage.m
//  VOA
//
//  Created by zhao song on 13-1-23.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import "UserMessage.h"

@implementation UserMessage
@synthesize msgId = _msgId;
@synthesize fromUserId = _fromUserId;
@synthesize fromUserName = _fromUserName;
@synthesize toUserId = _toUserId;
@synthesize topicId = _topicId;
@synthesize toUserName = _toUserName;
@synthesize comment = _comment;
@synthesize flag = _flag;
@synthesize state = _state;
//@synthesize imgSrc = _imgSrc;

/**
 *  创建只包含简要信息的消息实例
 */
- (id) initWithFromUserId:(NSInteger) fromUserId fromUserName:(NSString *) fromUserName toUserId:(NSInteger) toUserId toUserName:(NSString *) toUserName comment:(NSString *) comment topicId:(NSInteger) topicId
{
    if (self = [super init]) {
        _fromUserId = fromUserId;
        _fromUserName = [fromUserName retain];
        _toUserId = toUserId;
        _toUserName = [toUserName retain];
        _comment = [comment retain];
        _topicId = topicId;
    }
    return self;
}

- (id) initWithMsgId:(NSInteger) msgId fromUserId:(NSInteger) fromUserId fromUserName:(NSString *) fromUserName toUserId:(NSInteger) toUserId toUserName:(NSString *) toUserName comment:(NSString *) comment createDate:(NSString *) createDate topicId:(NSInteger) topicId flag:(NSInteger) flag
{
    if (self = [super init]) {
        _msgId = msgId;
        _fromUserId = fromUserId;
        _fromUserName = [fromUserName retain];
        _toUserId = toUserId;
        _toUserName = [toUserName retain];
        _comment = [comment retain];
        _createDate = [createDate retain];
        _topicId = topicId;
        _flag = flag;
        _state = 0;
    }
    return self;
}

- (id) initWithMsgId:(NSInteger) msgId fromUserId:(NSInteger) fromUserId fromUserName:(NSString *) fromUserName toUserId:(NSInteger) toUserId toUserName:(NSString *) toUserName comment:(NSString *) comment createDate:(NSString *) createDate topicId:(NSInteger) topicId flag:(NSInteger) flag state:(NSInteger) state
{
    if (self = [super init]) {
        _msgId = msgId;
        _fromUserId = fromUserId;
        _fromUserName = [fromUserName retain];
        _toUserId = toUserId;
        _toUserName = [toUserName retain];
        _comment = [comment retain];
        _createDate = [createDate retain];
        _topicId = topicId;
        _flag = flag;
        _state = state;
    }
    return self;
}

- (BOOL) insert
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    //    const char *myDate = [date UTF8String];//NSString转变为字符数组
    //    date 显示为 2011-11-01%2012:12:12
	NSString *findSql = [NSString stringWithFormat:@"insert into comments(msgId,fromUserId,fromUserName,toUserId,toUserName,comment,createDate,topicId,flag,state) values(%d,%d,\"%@\",%d,\"%@\",\"%@\",\"%@\",%d,%d,%d) ;",self.msgId,self.fromUserId,self.fromUserName,self.toUserId,self.toUserName,self.comment,self.createDate,self.topicId,self.flag,self.state];
	if([dataBase executeUpdate:findSql]) {
        //        NSLog(@"--success!");
        return YES;
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
        //        [errAlert release];
	}
    return NO;
}

+ (NSArray *) findAllByUserId:(NSInteger)fromUserId  infors:(NSMutableArray *) infors{
	PLSqliteDatabase *dataBase = [favdatabase setup];
	
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"SELECT * FROM comments where fromUserId = %d ORDER BY msgId desc ;", fromUserId];
	rs = [dataBase executeQuery:findSql];
    //    NSLog(@"sql:%@",findSql);
    
    
	//定义一个数组存放所有信息
    //	NSMutableArray *voaViews = [[NSMutableArray alloc] init];
	
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger msgId = [rs intForColumn:@"msgId"];
        NSInteger fromUserId = [rs intForColumn:@"fromUserId"];
        NSString *fromUserName = [rs objectForColumn:@"fromUserName"];
        NSInteger toUserId = [rs intForColumn:@"toUserId"];
        NSString *toUserName = [rs objectForColumn:@"toUserName"];
        NSString *comment = [rs objectForColumn:@"comment"];
        NSString *createDate = [rs objectForColumn:@"createDate"];
        NSInteger topicId = [rs intForColumn:@"topicId"];
        NSInteger flag = [rs intForColumn:@"flag"];
        NSInteger state = [rs intForColumn:@"state"];
        
//        NSString *creatTime = nil;
//        NSString *regEx = @"\\S+";
//        for(NSString *matchOne in [[rs objectForColumn:@"creatTime"] componentsMatchedByRegex:regEx]) {
//            creatTime = matchOne;
//            break;
//        }
        //        NSString *title_cn = [rs objectForColumn:@"Title_cn"];
        //        NSString *title_jp = [rs objectForColumn:@"title_jp"];
        //		NSString *collect = [rs objectForColumn:@"collect"];
        
        UserMessage *userMsg = [[UserMessage alloc] initWithMsgId:msgId fromUserId:fromUserId fromUserName:fromUserName toUserId:toUserId toUserName:toUserName comment:comment createDate:createDate topicId:topicId flag:flag state:state];
        //		[voaViews addObject:voaView];
		[infors addObject:userMsg];
		[userMsg release],userMsg = nil;
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
	return infors;
}

/**
 *  根据msgId获取对象的方法
 */
+ (id) find:(NSInteger ) msgId{
	PLSqliteDatabase *dataBase = [favdatabase setup];
    //    const char *myVoaid = [voaid UTF8String];//NSString转变为字符数组
    //    int myVoaid = voaid.intValue;//NSString转变为整型
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM comments WHERE msgId = %d", msgId];
	rs = [dataBase executeQuery:findSql];
	
	UserMessage *userMsg = nil;
	
	if([rs next]) {
        NSInteger msgId = [rs intForColumn:@"msgId"];
        NSInteger fromUserId = [rs intForColumn:@"fromUserId"];
        NSString *fromUserName = [rs objectForColumn:@"fromUserName"];
        NSInteger toUserId = [rs intForColumn:@"toUserId"];
        NSString *toUserName = [rs objectForColumn:@"toUserName"];
        NSString *comment = [rs objectForColumn:@"comment"];
        NSString *createDate = [rs objectForColumn:@"createDate"];
        NSInteger topicId = [rs intForColumn:@"topicId"];
        NSInteger flag = [rs intForColumn:@"flag"];
        NSInteger state = [rs intForColumn:@"state"];
        
//        NSString *creatTime = nil;
//        NSString *regEx = @"\\S+";
//        for(NSString *matchOne in [[rs objectForColumn:@"creatTime"] componentsMatchedByRegex:regEx]) {
//            creatTime = matchOne;
//            break;
//        }
        
        userMsg = [[UserMessage alloc] initWithMsgId:msgId fromUserId:fromUserId fromUserName:fromUserName toUserId:toUserId toUserName:toUserName comment:comment createDate:createDate topicId:topicId flag:flag state:state];//接收返回值的变量会释放这块内存
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	
	[rs close];
    //	[dataBase close];//
	return userMsg;	
}

/**
 *  根据msgId删除消息
 */
+ (void) deleteById:(NSInteger)msgId {
    //    NSLog(@"删除标题-%d",voaid);
    PLSqliteDatabase *dataBase = [favdatabase setup];
    if ([self find:msgId]) {
        NSString *findSql = [NSString stringWithFormat:@"delete from comments where msgId = %d ;",msgId];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
    }
}

/**
 *  根据msgId标记删除
 */
+ (void) alterFlgDeleteById:(NSInteger)msgId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    if ([self find:msgId]) {
        NSString *findSql = [NSString stringWithFormat:@"update comments set state = -1 WHERE msgId = %d ;",msgId];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
    }
}

/**
 *  根据msgId标记已读
 */
+ (void) readedById:(NSInteger)msgId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    if ([self find:msgId]) {
        NSString *findSql = [NSString stringWithFormat:@"update comments set flag = 0 WHERE msgId = %d ;",msgId];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
    }
}

/**
 *  根据msgId标记已读
 */
+ (void) alterFlgReadedById:(NSInteger)msgId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    if ([self find:msgId]) {
        NSString *findSql = [NSString stringWithFormat:@"update comments set state = 1 WHERE msgId = %d ;",msgId];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
    }
}

+ (BOOL) isExist:(NSInteger) msgId {
    PLSqliteDatabase *dataBase = [favdatabase setup];
    
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select msgId FROM comments WHERE msgId = %d", msgId];
	rs = [dataBase executeQuery:findSql];
	BOOL flg = NO;
	if([rs next]) {
        flg = YES;
	}
	else {
	}
	
	[rs close];
	return flg;
}

@end
