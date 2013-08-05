//
//  dataBaseClass.m
//  VOA
//
//  Created by song zhao on 12-2-6.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "DataBaseClass.h"


@implementation DataBaseClass

+ (void)querySQL:(NSMutableArray *)lyricArray 
	timeResultIn:(NSMutableArray *)timeArray 
   indexResultIn:(NSMutableArray *)indexArray 
     voaResultIn:(VOAView *)voa{
	
//	传进来的参数引用+1
	[lyricArray retain];
	[timeArray retain];
	[indexArray retain];
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select StartTiming,sentence FROM voadetail WHERE voaid = %d order by paraid,idindex ", voa._voaid];
	rs = [dataBase executeQuery:findSql];
    int myIndex = 0;
    float time = 0.0;
	while ([rs next]) {
        NSString *lyric = [rs objectForColumn:@"sentence"];
        time = [rs floatForColumn:@"StartTiming"];
        NSNumber *timeNum = [[NSNumber alloc] initWithFloat:time];
        NSNumber *indexNum = [[NSNumber alloc] initWithInt:++myIndex];
        NSString *lyricStr = [[NSString alloc] initWithUTF8String:[lyric UTF8String]];
        [timeArray addObject:timeNum];
        [indexArray addObject:indexNum];
        [lyricArray addObject:lyricStr];
        [timeNum release], timeNum = nil;
        [indexNum release], indexNum = nil;
        [lyricStr release], lyricStr = nil;
	}	
	[rs close];
	
//  释放引用
	[lyricArray release];
	[timeArray release];
	[indexArray release];
}

+ (BOOL)querySQL:(NSMutableArray *)lyricArray
 lyricCnResultIn:(NSMutableArray *)lyricCnArray 
	timeResultIn:(NSMutableArray *)timeArray 
   indexResultIn:(NSMutableArray *)indexArray
     voaResultIn:(VOAView *)voa{
	[lyricArray retain];
	[timeArray retain];
	[indexArray retain];
    [lyricCnArray retain];
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
//    NSLog(@"voaid:%d",voa._voaid);
	NSString *findSql = [NSString stringWithFormat:@"select StartTiming,sentence,sentence_cn FROM voadetail WHERE voaid = %d order by paraid,idindex", voa._voaid];
	rs = [dataBase executeQuery:findSql];
    int myIndex = 0;
    float time = 0.0;
	while ([rs next]) {
        NSString *lyric = [rs objectForColumn:@"sentence"];
        NSString *lyricCn = [rs objectForColumn:@"sentence_cn"];
        time = [rs floatForColumn:@"StartTiming"];
        NSNumber *timeNum = [[NSNumber alloc] initWithFloat:time];
        NSNumber *indexNum = [[NSNumber alloc] initWithInt:++myIndex];
        NSString *lyricStr = [[NSString alloc] initWithUTF8String:[lyric UTF8String]];
        NSString *lyrciCnStr = [[NSString alloc] initWithUTF8String:[lyricCn UTF8String]];
        [timeArray addObject:timeNum];
        [indexArray addObject:indexNum];
        [lyricArray addObject:lyricStr];
        [lyricCnArray addObject:lyrciCnStr];
        [timeNum release], timeNum = nil;
        [indexNum release], indexNum = nil;
        [lyricStr release], lyricStr = nil;
        [lyrciCnStr release], lyrciCnStr = nil;
	}	
	[rs close];
	[lyricArray release];
    [lyricCnArray release];
	[timeArray release];
	[indexArray release];
    
    if ([lyricArray count] > 0) {
        return  YES;
    }
    return  NO;
}

+ (BOOL)querySQL:(NSMutableArray *)lyricArray
 lyricCnResultIn:(NSMutableArray *)lyricCnArray
	timeResultIn:(NSMutableArray *)timeArray
    endTimeResultIn:(NSMutableArray *)endTimeArray
   indexResultIn:(NSMutableArray *)indexArray
     voaResultIn:(VOAView *)voa {
    [lyricArray retain];
	[timeArray retain];
    [endTimeArray retain];
	[indexArray retain];
    [lyricCnArray retain];
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    //    NSLog(@"voaid:%d",voa._voaid);
	NSString *findSql = [NSString stringWithFormat:@"select StartTiming,EndTiming,sentence,sentence_cn FROM voadetail WHERE voaid = %d order by paraid,idindex", voa._voaid];
	rs = [dataBase executeQuery:findSql];
    int myIndex = 0;
    float time = 0.0;
    float endTime = 0.0;
	while ([rs next]) {
        NSString *lyric = [rs objectForColumn:@"sentence"];
        NSString *lyricCn = [rs objectForColumn:@"sentence_cn"];
        time = [rs floatForColumn:@"StartTiming"];
        endTime = [rs floatForColumn:@"EndTiming"];
        NSNumber *timeNum = [[NSNumber alloc] initWithFloat:time];
        NSNumber *endTimeNum = [[NSNumber alloc] initWithFloat:endTime];
        NSNumber *indexNum = [[NSNumber alloc] initWithInt:++myIndex];
        NSString *lyricStr = [[NSString alloc] initWithUTF8String:[lyric UTF8String]];
        NSString *lyrciCnStr = [[NSString alloc] initWithUTF8String:[lyricCn UTF8String]];
        [timeArray addObject:timeNum];
        [endTimeArray addObject:endTimeNum];
        [indexArray addObject:indexNum];
        [lyricArray addObject:lyricStr];
        [lyricCnArray addObject:lyrciCnStr];
        [timeNum release], timeNum = nil;
        [indexNum release], indexNum = nil;
        [lyricStr release], lyricStr = nil;
        [lyrciCnStr release], lyrciCnStr = nil;
	}
	[rs close];
	[lyricArray release];
    [lyricCnArray release];
	[timeArray release];
    [endTimeArray release];
	[indexArray release];
    
    if ([lyricArray count] > 0) {
        return  YES;
    }
    return  NO;
}
 
@end
