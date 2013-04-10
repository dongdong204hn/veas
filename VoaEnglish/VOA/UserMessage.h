//
//  UserMessage.h
//  VOA
//  用户消息数据类
//  Created by zhao song on 13-1-23.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "favdatabase.h"

@interface UserMessage : NSObject

//以发信人口气设置字段，from*表示当前用户，to*表示原发信用户
@property (nonatomic) NSInteger msgId;
@property (nonatomic) NSInteger fromUserId;
@property (nonatomic, retain) NSString *fromUserName;
@property (nonatomic) NSInteger toUserId;
@property (nonatomic, retain) NSString *toUserName;
@property (nonatomic, retain) NSString *comment; 
@property (nonatomic, retain) NSString *createDate;//消息发送日期
@property (nonatomic) NSInteger topicId; //VOA的id
@property (nonatomic) NSInteger flag;//标记已读0和未读1
@property (nonatomic) NSInteger state;//0:正常 1:已读但未成功告知服务器 -1:已删但未成功告知服务器
//@property (nonatomic, retain) NSString *imgSrc;

- (id) initWithFromUserId:(NSInteger) fromUserId fromUserName:(NSString *) fromUserName toUserId:(NSInteger) toUserId toUserName:(NSString *) toUserName comment:(NSString *) comment  topicId:(NSInteger) topicId;

- (id) initWithMsgId:(NSInteger) msgId fromUserId:(NSInteger) fromUserId fromUserName:(NSString *) fromUserName toUserId:(NSInteger) toUserId toUserName:(NSString *) toUserName comment:(NSString *) comment createDate:(NSString *) createDate topicId:(NSInteger) topicId flag:(NSInteger) flag;

- (id) initWithMsgId:(NSInteger) msgId fromUserId:(NSInteger) fromUserId fromUserName:(NSString *) fromUserName toUserId:(NSInteger) toUserId toUserName:(NSString *) toUserName comment:(NSString *) comment createDate:(NSString *) createDate topicId:(NSInteger) topicId flag:(NSInteger) flag state:(NSInteger) state;

- (BOOL) insert;

+ (NSArray *) findAllByUserId:(NSInteger)fromUserId  infors:(NSMutableArray *) infors;

+ (id) find:(NSInteger ) msgId;

+ (void) deleteById:(NSInteger)msgId;

+ (void) alterFlgDeleteById:(NSInteger)msgId;

+ (void) readedById:(NSInteger)msgId;

+ (void) alterFlgReadedById:(NSInteger)msgId;

+ (BOOL) isExist:(NSInteger) msgId;

@end
