//
//  database.m
//  TableTest
//
//  Created by Cui Celim on 11-11-14.
//  Copyright 2011 DMS. All rights reserved.
//

#import "database.h"
#import <PlausibleDatabase/PlausibleDatabase.h>

static PLSqliteDatabase * dbPointer;

@implementation database

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}
/*
+ (PLSqliteDatabase *) setup{
	
	if (dbPointer) {
		return dbPointer;
	}

	
	NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
	NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *realPath = [documentPath stringByAppendingPathComponent:@"mydatabase.sqlite"];
    NSLog(@"realPath:%@",realPath);
	
	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"voadata" ofType:@"sqlite"];
	
	NSLog(@"sourcePath:%@",sourcePath);
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:realPath]) {
		NSError *error;
		if (![fileManager copyItemAtPath:sourcePath toPath:realPath error:&error]) {
			NSLog(@"%@",[error localizedDescription]);
		}
	}
	
	NSLog(@"复制sqlite到路径：%@成功。",realPath);
	
//	把dbpointer地址修改为可修改的realPath。
	dbPointer = [[PLSqliteDatabase alloc] initWithPath:realPath];
//	dbPointer = [[PLSqliteDatabase alloc] initWithPath:sourcePath];
	if ([dbPointer open]) {
		NSLog(@"open voa succeed!");
	};
	
	return dbPointer;
}*/

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
	NSString *realPath = [audioPath stringByAppendingPathComponent:@"mydatabase.sqlite"];
//    NSLog(@"realPath:%@",realPath);
	
	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"voadata" ofType:@"sqlite"];
	
//	NSLog(@"sourcePath:%@",sourcePath);
	
	
	if (![fileManager fileExistsAtPath:realPath]) {
		NSError *error;
		if (![fileManager copyItemAtPath:sourcePath toPath:realPath error:&error]) {
//			NSLog(@"%@",[error localizedDescription]);
		}
	}
	
//	NSLog(@"复制sqlite到路径：%@成功。",realPath);
	
    //	把dbpointer地址修改为可修改的realPath。
	dbPointer = [[PLSqliteDatabase alloc] initWithPath:realPath];
//    dbPointer = [[PLSqliteDatabase alloc] initWithPath:sourcePath];
	if ([dbPointer open]) {
//		NSLog(@"open voa succeed!");
        id<PLResultSet> rs;
        NSString *findSql = [NSString stringWithFormat:@"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='voaDetailTwo'"];
        rs = [dbPointer executeQuery:findSql];
        if ([rs next]) {
            NSString *count=[rs objectForColumn:@"count"];
            if (count.intValue == 0) {
                NSString *findSqlOne = [NSString stringWithFormat:@"CREATE TABLE voaDetailTwo (VoaId integer,ParaId integer,IdIndex integer,Timing integer,Sentence varchar,ImgWords varchar,ImgPath varchar,Sentence_cn varchar,Sentence_jp varchar)"];
                [dbPointer executeUpdate:findSqlOne];
                findSqlOne = [NSString stringWithFormat:@"insert into voaDetailTwo select distinct * from voaDetail"];
                [dbPointer executeUpdate:findSqlOne];
                findSqlOne = [NSString stringWithFormat:@"delete from voaDetail"];
                [dbPointer executeUpdate:findSqlOne];
                findSqlOne = [NSString stringWithFormat:@"insert into voaDetail select * from voaDetailTwo"];
                [dbPointer executeUpdate:findSqlOne];
                findSqlOne = [NSString stringWithFormat:@"delete from voaDetailTwo"];
                [dbPointer executeUpdate:findSqlOne];
            }
            
            //            else {
            //                NSString *findSqlOne = [NSString stringWithFormat:@"drop table voaDetail"];
            //                [dbPointer executeUpdate:findSqlOne];
            //            }
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

