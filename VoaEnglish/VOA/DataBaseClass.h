//
//  dataBaseClass.h 
//  JPTListeningLevel-3
//
//  Created by zzl on 12-1-4.
//  Copyright 2012 iyuba. All rights reserved.
//
//  v1.0 
//  1.打开制定路径的数据库
//  2.实现对传入的SQL Query语句字符串（NSString）进行查询，将结果以数组形式返回。

#import "database.h"
#import "VOAView.h"

/**
 *
 */
@interface DataBaseClass : NSObject {
}
   
+ (void)querySQL:(NSMutableArray *)lyricArray 
	timeResultIn:(NSMutableArray *)timeArray 
   indexResultIn:(NSMutableArray *)indexArray
     voaResultIn:(VOAView *)voa;

+ (BOOL)querySQL:(NSMutableArray *)lyricArray 
 lyricCnResultIn:(NSMutableArray *)lyricCnArray 
	timeResultIn:(NSMutableArray *)timeArray 
   indexResultIn:(NSMutableArray *)indexArray
     voaResultIn:(VOAView *)voa;

@end
