//
//  worddatabase.m
//  VOAAdvanced
//
//  Created by song zhao on 12-6-29.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "worddatabase.h"

static PLSqliteDatabase * dbPointer;

@implementation worddatabase

+ (PLSqliteDatabase *) setup{
	
	if (dbPointer) {
		return dbPointer;
	}
	
	
    //	NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
//	NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
//	NSString *realPath = [audioPath stringByAppendingPathComponent:@"WORDS.sqlite"];
	
	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"WORDS" ofType:@"sqlite"];
	
    //	NSLog(@"sourcePath:%@",sourcePath);
	
//	NSFileManager *fileManager = [NSFileManager defaultManager];
//	if (![fileManager fileExistsAtPath:realPath]) {
//		NSError *error;
//		if (![fileManager copyItemAtPath:sourcePath toPath:realPath error:&error]) {
//            //			NSLog(@"%@",[error localizedDescription]);
//		}
//	}
	
    //	NSLog(@"复制sqlite到路径：%@成功。",realPath);
	
    //	把dbpointer地址修改为可修改的realPath。
	dbPointer = [[PLSqliteDatabase alloc] initWithPath:sourcePath];
	
	if ([dbPointer open]) {
        //		NSLog(@"open fav succeed!");
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
