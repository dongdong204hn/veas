//
//  database.h
//  TableTest
//
//  Created by Cui Celim on 11-11-14.
//  Copyright 2011 DMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PlausibleDatabase/PlausibleDatabase.h>
#include <sys/xattr.h>

@interface database : NSObject {
	
}
+ (PLSqliteDatabase *) setup;

+ (void) close;

/**
 *  离线数据
 可以下载，或重新创建，但用户希望在离线时也能访问这些数据。存放在<Application_Home>/Documents 或<Application_Home>/Library/Private Documents ，并标记为"do not backup"。这两个位置的数据在低存储空间时都会保留，而"do not backup"属性会阻止iTunes或iCloud备份。应用不再需要离线数据文件时，应该尽快删除，以避免浪费用户的存储空间。
 设置do not back up属性 
 */
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end

