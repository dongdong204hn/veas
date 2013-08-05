//
//  VOADetail.m
//  VOA
//
//  Created by song zhao on 12-2-3.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "VOADetail.h"
#import "database.h"

@implementation VOADetail

@synthesize _voaid;
@synthesize _paraid;
@synthesize _idIndex;
@synthesize _startTiming;
@synthesize _endTiming;
@synthesize _sentence;
@synthesize _imgWords;
@synthesize _imgPath;
@synthesize _sentence_cn;
//@synthesize _sentence_jp;

- (id) initWithVoaId:(NSInteger) voaid paraid:(NSInteger) paraid idIndex:(NSInteger) idIndex startTiming:(float) startTiming sentence:(NSString *)sentence  imgWords:(NSString *) imgWords imgPath:(NSString *) imgPath sentence_cn:(NSString *) sentence_cn {
	if (self = [super init]) {
		_voaid = voaid;
        _paraid = paraid;
        _idIndex = idIndex;
        _startTiming = startTiming;
        _sentence = [sentence retain];
        _imgWords = [imgWords retain];
        _imgPath = [imgPath retain];
        _sentence_cn = [sentence_cn retain];
//        _sentence_jp = [sentence_jp retain];
        }
	return self;
}

- (id) initWithVoaId:(NSInteger) voaid paraid:(NSInteger) paraid idIndex:(NSInteger) idIndex startTiming:(float) startTiming endTiming:(float)endTiming sentence:(NSString *)sentence  imgWords:(NSString *) imgWords imgPath:(NSString *) imgPath sentence_cn:(NSString *) sentence_cn {
    if (self = [super init]) {
		_voaid = voaid;
        _paraid = paraid;
        _idIndex = idIndex;
        _startTiming = startTiming;
        _endTiming = endTiming;
        _sentence = [sentence retain];
        _imgWords = [imgWords retain];
        _imgPath = [imgPath retain];
        _sentence_cn = [sentence_cn retain];
        //        _sentence_jp = [sentence_jp retain];
    }
	return self;
}

- (BOOL) insert
{
    PLSqliteDatabase *dataBase = [database setup];
    //    const char *myDate = [date UTF8String];//NSString转变为字符数组
    //    date 显示为 2011-11-01%2012:12:12
	NSString *findSql = [NSString stringWithFormat:@"insert into voadetail(Voaid,ParaId,IdIndex,StartTiming,Sentence,ImgWords,ImgPath,Sentence_cn) values(%d,%d,%d,%f,\"%@\",\"%@\",\"%@\",\"%@\") ;",self._voaid,self._paraid,self._idIndex,self._startTiming,self._sentence,self._imgWords,self._imgPath,self._sentence_cn];
    
	if([dataBase executeUpdate:findSql]) {
//        NSLog(@"--success!");
        return YES;
	}
	else {
//		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[errAlert show];
//        [errAlert release], errAlert = nil;
	}
    return NO;
}

- (BOOL) insertNew
{
    PLSqliteDatabase *dataBase = [database setup];
    //    const char *myDate = [date UTF8String];//NSString转变为字符数组
    //    date 显示为 2011-11-01%2012:12:12
	NSString *findSql = [NSString stringWithFormat:@"insert into voadetail(Voaid,ParaId,IdIndex,StartTiming,EndTiming,Sentence,ImgWords,ImgPath,Sentence_cn) values(%d,%d,%d,%f,%f,\"%@\",\"%@\",\"%@\",\"%@\") ;",self._voaid,self._paraid,self._idIndex,self._startTiming,self._endTiming,self._sentence,self._imgWords,self._imgPath,self._sentence_cn];
    
	if([dataBase executeUpdate:findSql]) {
        //        NSLog(@"--success!");
        return YES;
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
        //        [errAlert release], errAlert = nil;
	}
    return NO;
}

+ (id) find:(NSInteger) voaid{
	PLSqliteDatabase *dataBase = [database setup];
    
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM voadetail WHERE voaid = %d", voaid];
	rs = [dataBase executeQuery:findSql];
	
	VOADetail *voaDetail = nil;
    NSString *sentence_cn = nil;
    int i = 0;
	while ([rs next]) {
        i++;
        if (i < 4) {
            sentence_cn = [[[[rs objectForColumn:@"sentence_cn"]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"] stringByReplacingOccurrencesOfString:@"<b>" withString:@""] stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
//            NSLog(([sentence_cn isEqualToString:@""] || [sentence_cn isEqualToString:@"null"] || [sentence_cn isEqualToString:@"test"])?@"中文为空":@"有中文");
            if (![sentence_cn isEqualToString:@""] && ![sentence_cn isEqualToString:@"null"] && ![sentence_cn isEqualToString:@"test"]) {
//                NSLog(@"sentence_cn:%@",sentence_cn);
                NSInteger voaid = [rs intForColumn:@"voaid"];
                NSInteger paraid = [rs intForColumn:@"paraid"];
                NSInteger idIndex = [rs intForColumn:@"idIndex"];
                float startTiming = [rs floatForColumn:@"startTiming"];
                float endTiming = [rs floatForColumn:@"endTiming"];
                NSString *sentence = [rs objectForColumn:@"sentence"];
                NSString *imgWords = [rs objectForColumn:@"imgWords"];
                NSString *imgPath = [rs objectForColumn:@"imgPath"];
                
                voaDetail = [[VOADetail alloc] initWithVoaId:voaid paraid:paraid idIndex:idIndex startTiming:startTiming endTiming:endTiming sentence:sentence imgWords:imgWords imgPath:imgPath sentence_cn:sentence_cn];
                break;
            }
        } else {
            break;
        }
	}
	[rs close];
//    if (i<3) {
//        return nil;
//    }
	return [voaDetail autorelease];
}

+ (BOOL) isExist:(NSInteger) voaid{
    PLSqliteDatabase *dataBase = [database setup];
    
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM voadetail WHERE voaid = %d", voaid];
	rs = [dataBase executeQuery:findSql];
//	BOOL flg = NO;
	if ([rs next]) {
//        NSInteger voaid = [rs intForColumn:@"voaid"];
//        if (voaid > 0) {
//            NSLog(@"存在%d",voaid);
            return YES;
//        }
        
	}
//	else {
//        NSLog(@"不存在");
//        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        //		[errAlert show];
//	}
//	
	[rs close];
    NSLog(@"不存在");
    //	[voaDetail release];
	return NO;	
}


+ (void) deleteByVoaid:(NSInteger)voaid {
//    NSLog(@"删除内容-%d",voaid);
    PLSqliteDatabase *dataBase = [database setup];
    NSString *findSql = [NSString stringWithFormat:@"delete from voadetail where voaid = %d ;",voaid];
    if([dataBase executeUpdate:findSql]) {
    }
}

+(id)findByVoaidAndTime:(NSInteger)voaid timing:(float)startTiming{
    PLSqliteDatabase *dataBase = [database setup];
    
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM voadetail WHERE VoaId = %d and StartTiming > %f and StartTiming < %f", voaid,startTiming-0.1, startTiming+0.1];
	rs = [dataBase executeQuery:findSql];
	
	VOADetail *voaDetail = nil;
    NSString *sentence_cn = nil;

	while ([rs next]) {
        
        sentence_cn = [[[[rs objectForColumn:@"Sentence_cn"]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"] stringByReplacingOccurrencesOfString:@"<b>" withString:@""] stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
        //            NSLog(([sentence_cn isEqualToString:@""] || [sentence_cn isEqualToString:@"null"] || [sentence_cn isEqualToString:@"test"])?@"中文为空":@"有中文");
        if (![sentence_cn isEqualToString:@""] && ![sentence_cn isEqualToString:@"null"] && ![sentence_cn isEqualToString:@"test"]) {
        }else{
            NSString *sorry=@"抱歉，太过久远的VOA新闻未收录中文～";
            sentence_cn = sorry;
        }
        //                NSLog(@"sentence_cn:%@",sentence_cn);
        NSInteger voaid = [rs intForColumn:@"Voaid"];
        NSInteger paraid = [rs intForColumn:@"Paraid"];
        NSInteger idIndex = [rs intForColumn:@"IdIndex"];
        float startTiming = [rs floatForColumn:@"startTiming"];
        float endTiming = [rs floatForColumn:@"endTiming"];
        NSString *sentence = [rs objectForColumn:@"Sentence"];
        NSString *imgWords = [rs objectForColumn:@"ImgWords"];
        NSString *imgPath = [rs objectForColumn:@"ImgPath"];
        
        voaDetail = [[[VOADetail alloc] initWithVoaId:voaid paraid:paraid idIndex:idIndex startTiming:startTiming endTiming:endTiming sentence:sentence imgWords:imgWords imgPath:imgPath sentence_cn:sentence_cn] autorelease];
    }
    //            NSLog(@"voadetail:%d,%d,%d,%@",voaDetail._voaid,voaDetail._paraid,voaDetail._idIndex,voaDetail._sentence_cn);

	[rs close];
    //    if (i<3) {
    //        return nil;
    //    }
	return voaDetail;
}

/**
 数据库表voadetail添加增加float类型列EndTiming和StartTiming，然后将Timing的值拷贝到StartTiming。
 */
+ (void) alterTimefield {
    PLSqliteDatabase *db = [database setup];
    NSString *findSql = [NSString stringWithFormat:@"ALTER TABLE voadetail ADD EndTiming float default 0;"];
    [db executeUpdate:findSql];
    findSql = [NSString stringWithFormat:@"ALTER TABLE voadetail ADD StartTiming float;"];
    [db executeUpdate:findSql];
    findSql = [NSString stringWithFormat:@"update voadetail set StartTiming = Timing;"];
    [db executeUpdate:findSql];
}

@end
