//
//  detaildatabase.m
//  VOA
//
//  Created by song zhao on 12-2-8.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "detaildatabase.h"
#import <PlausibleDatabase/PlausibleDatabase.h>

static PLSqliteDatabase * dbPointer;

@implementation detaildatabase 

+ (PLSqliteDatabase *) setup{
	
	if (dbPointer) {
		return dbPointer;
	}
    
	
	NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
	NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *realPath = [documentPath stringByAppendingPathComponent:@"mydatabase.sqlite"];
	
	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"mydatabase" ofType:@"sqlite"];
	
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
	
	if ([dbPointer open]) {
		NSLog(@"open succeed!");
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

