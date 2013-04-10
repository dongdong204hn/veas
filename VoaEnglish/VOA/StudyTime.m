//
//  StudyTime.m
//  VOA
//
//  Created by zhao song on 13-1-26.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import "StudyTime.h"

@implementation StudyTime
@synthesize timeId = _timeId;
@synthesize userId = _userId;
@synthesize seconds = _seconds;
@synthesize date = _date;
@synthesize beginTime = _beginTime;
@synthesize endTime = _endTime;

- (id) initWithTimeId:(NSInteger) timeId userId:(NSInteger) userId seconds:(NSInteger) seconds date:(NSString *) date beginTime:(NSString *) beginTime endTime:(NSString *) endTime {
    if (self = [super init]) {
        _timeId = timeId;
        _userId = userId;
        _seconds = seconds;
        _date = [date retain];
        _beginTime = [beginTime retain];
        _endTime = [endTime retain];
    }
    return self;
}

- (BOOL) insert {
    PLSqliteDatabase *dataBase = [favdatabase setup];
    //    const char *myDate = [date UTF8String];//NSString转变为字符数组
    //    date 显示为 2011-11-01%2012:12:12
	NSString *findSql = [NSString stringWithFormat:@"insert into studyTime(timeId,userId,seconds,date,beginTime,endTime) values(%d,%d,%d,\"%@\",\"%@\",\"%@\");", self.timeId,self.userId, self.seconds,self.date,self.beginTime,self.endTime];
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

/**
 *  获取最大记录id
 */
+ (NSInteger) findLastId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select max(timeId) last from studyTime"];
	rs = [dataBase executeQuery:findSql];
    int last = 0;
	if([rs next]) {
        @try {
            last = [[rs objectForColumn:@"last"] integerValue];
        }
        @catch (NSException *exception) {
            last = 0;
        }
        @finally {
//            NSLog(@"--last：%i!", last );
        }
        
//        last = [rs intForColumn:@"last"];
        
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	[rs close];
    //	[dataBase close];//
	return last;
    
}

/**
 *  获取除日期date以外的每日平均学习时间
 */
+ (NSInteger)avgStudyTime:(NSString *) date {
    PLSqliteDatabase *dataBase = [favdatabase setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select sum(seconds) sumSec FROM studyTime where date != \"%@\" group by date", date];
    rs = [dataBase executeQuery:findSql];
    NSInteger count = 0;
    NSInteger num = 0;
    while([rs next]) {
        @try {
            count = [[rs objectForColumn:@"sumSec"] integerValue];
        }
        @catch (NSException *exception) {
            count = 0;
        }
        @finally {
            num++;
//            NSLog(@"avgStudyTime：%i! %i", count, num);
        }
    }
    [rs close];
    return (count > 0? count/num: 0);
}

/**
 *  根据date获取该日学习秒数时长
 */
+ (NSInteger)findSecsByDate:(NSString *) date {
    PLSqliteDatabase *dataBase = [favdatabase setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select sum(seconds) sumSec FROM studyTime where date = \"%@\"", date];
    rs = [dataBase executeQuery:findSql];
    NSInteger count = 0;
    if([rs next]) {
        @try {
            count = [[rs objectForColumn:@"sumSec"] integerValue];
        }
        @catch (NSException *exception) {
            count = 0;
        }
        @finally {
//            NSLog(@"findSecsByDate：%i!", count );
        }
        
    }
    [rs close];
    return count;
}

@end
