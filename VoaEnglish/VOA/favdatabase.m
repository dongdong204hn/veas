//
//  favdatabase.m
//  VOA
//
//  Created by song zhao on 12-2-8.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "favdatabase.h"
#import <PlausibleDatabase/PlausibleDatabase.h>

static PLSqliteDatabase * dbPointer;

@implementation favdatabase

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

+ (PLSqliteDatabase *) setup{
	
	if (dbPointer) {
		return dbPointer;
	}
	
	
//	NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //创建audio份目录在Documents文件夹下，not to back up
	NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
	if ([fileManager fileExistsAtPath:audioPath] == NO) {
		[fileManager createDirectoryAtPath:audioPath withIntermediateDirectories:YES attributes:nil error:nil];
		if ([self addSkipBackupAttributeToItemAtURL:[NSURL URLWithString:audioPath]] == YES) {
            //			NSLog(@"succes!");
		}
	}
	NSString *realPath = [audioPath stringByAppendingPathComponent:@"favvoadata.sqlite"];
	
	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"favvoadata" ofType:@"sqlite"];
	
//	NSLog(@"sourcePath:%@",sourcePath);

	if (![fileManager fileExistsAtPath:realPath]) {
		NSError *error;
		if (![fileManager copyItemAtPath:sourcePath toPath:realPath error:&error]) {
//			NSLog(@"error:%@",[error localizedDescription]);
		}
	}
	
//	NSLog(@"复制sqlite到路径：%@成功。",realPath);
	
    //	把dbpointer地址修改为可修改的realPath。
	dbPointer = [[PLSqliteDatabase alloc] initWithPath:realPath];
	
	if ([dbPointer open]) {
//		NSLog(@"open fav succeed!");
        id<PLResultSet> rs;

        NSString *findSql = [NSString stringWithFormat:@"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='favsentence'"];
        rs = [dbPointer executeQuery:findSql];
        if ([rs next]) {
            NSString *count=[rs objectForColumn:@"count"];
            if (count.intValue == 0) {
                 NSString *findSql1 = [NSString stringWithFormat:@"CREATE TABLE favsentence (SentenceId integer NOT NULL PRIMARY KEY,VoaId integer,ParaId integer,IdIndex integer,StartTime integer,EndTime integer DEFAULT 1800,Sentence varchar,SentenceCn varchar,userId integer NOT NULL DEFAULT 0,collected integer DEFAULT 0, synchroFlg integer NOT NULL DEFAULT 0)"];
                [dbPointer executeUpdate:findSql1];
            }
        }
        
        findSql = [NSString stringWithFormat:@"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='comments'"];
        rs = [dbPointer executeQuery:findSql];
        if ([rs next]) {
            NSString *count=[rs objectForColumn:@"count"];
            if (count.intValue == 0) {
                NSString *findSql1 = [NSString stringWithFormat:@"CREATE TABLE comments (msgId integer NOT NULL PRIMARY KEY,fromUserId integer,fromUserName varchar,toUserId integer,toUserName varchar,comment varchar,createDate varchar,topicId integer,flag integer NOT NULL DEFAULT 1,state integer NOT NULL DEFAULT 0)"];
                [dbPointer executeUpdate:findSql1];
            }
        }
        
        findSql = [NSString stringWithFormat:@"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='studyTime'"];
        rs = [dbPointer executeQuery:findSql];
        if ([rs next]) {
            NSString *count=[rs objectForColumn:@"count"];
            if (count.intValue == 0) {
                NSString *findSql1 = [NSString stringWithFormat:@"CREATE TABLE studyTime (timeId integer NOT NULL PRIMARY KEY,userId integer NOT NULL DEFAULT 0,seconds integer NOT NULL DEFAULT 0,date varchar,beginTime varchar,endTime varchar)"];
                [dbPointer executeUpdate:findSql1];
            }
        }
        [rs close];
	};
	
	return dbPointer;
}

+ (void) close{
	if (dbPointer) {
		[dbPointer close];
		dbPointer = NULL;
	}
}


@end

