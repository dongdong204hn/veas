//
//  VOASentence.m
//  VOAAdvanced
//
//  Created by iyuba on 12-11-16.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "VOASentence.h"

@implementation VOASentence
@synthesize SentenceId;
@synthesize VoaId;
@synthesize ParaId;
@synthesize IdIndex;
@synthesize StartTime;
@synthesize EndTime;
@synthesize Sentence;
@synthesize Sentence_cn;
@synthesize userId;
@synthesize collected;

-(id) initWithVOASentence:(NSInteger) _SentenceId VoaId:(NSInteger)_VoaId ParaId:(NSInteger)_ParaId IdIndex:(NSInteger)_IdIndex StartTime:(NSInteger)_StartTime EndTime:(NSInteger)_EndTime Sentence:(NSString *)_Sentence Sentence_cn:(NSString *)_Sentence_cn userId:(NSInteger)_userId collected:(NSInteger)_collected
{
    
    if (self = [super init]) {
        self.SentenceId = _SentenceId;
        self.VoaId = _VoaId;
        //        self.lang = [_lang retain];
        self.ParaId = _ParaId;
        self.IdIndex = _IdIndex;
        self.StartTime =_StartTime;
        self.EndTime =_EndTime;
        self.Sentence=[_Sentence retain];
        self.Sentence_cn=[_Sentence_cn retain];
        self.userId=_userId;
        self.collected =_collected;
    }
    return self;

}

-(BOOL) isExist
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM favsentence WHERE VoaId=%d and ParaId=%d and IdIndex=%d and userId = %d and collected = 1",self.VoaId,self.ParaId,self.IdIndex,self.userId];
    rs = [dataBase executeQuery:findSql];
	BOOL myflag = NO;
	
	if([rs next]) {
        myflag = YES;
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	
	[rs close];
    //	[dataBase close];//
	return myflag;

}

/**
 *  收藏句子
 */
- (BOOL) alterCollect{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    BOOL flg;
    if (![self isExist]) {
        NSString *findSql = [NSString stringWithFormat:@"insert into favsentence(SentenceId,VoaId,ParaId,IdIndex,StartTime,EndTime,Sentence,SentenceCn,userId,collected) values(%d,%d,%d,%d,%d,%d,\"%@\",\"%@\",%d,1);",SentenceId,VoaId,ParaId,IdIndex,StartTime,EndTime,Sentence,Sentence_cn,userId];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
        else {
//            UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [errAlert show];
//            [errAlert release];
        }
        flg = YES;
    }else
    {
        UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:kVoaWordOne message:kVoaSentenceTwo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errAlert show];
        [errAlert release];
        flg = NO;
    }
    return flg;
}

+(NSArray*) findSentences:(NSInteger)userId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	
	id<PLResultSet> rs;
	rs = [dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM favsentence where collected>-1 and userId = %d order by SentenceId desc",userId]];
    
	//定义一个数组存放所有信息
	NSMutableArray *sentences = [[NSMutableArray alloc] init];
	
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger SentenceId = [rs intForColumn:@"SentenceId"];
                //        NSString *lang = [rs objectForColumn:@"lang"];
        NSInteger VoaId =[rs intForColumn:@"VoaId"];
        NSInteger ParaId = [rs intForColumn:@"ParaId"];
        NSInteger IdIndex = [rs intForColumn:@"IdIndex"];
        NSInteger StartTime = [rs intForColumn:@"StartTime"];
        NSInteger EndTime = [rs intForColumn:@"EndTime"];
        NSString *Sentence =[rs objectForColumn:@"Sentence"];
        NSString *Sentence_cn = [rs objectForColumn:@"SentenceCn"];

        NSInteger userId = [rs intForColumn:@"userId"];
        NSInteger collected = [rs intForColumn:@"collected"];
        VOASentence *sentence=[[VOASentence alloc]initWithVOASentence:SentenceId VoaId:VoaId ParaId:ParaId IdIndex:IdIndex StartTime:StartTime EndTime:EndTime Sentence:Sentence Sentence_cn:Sentence_cn userId:userId collected:collected];
		[sentences addObject:sentence];
		[sentence release];
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
    return [sentences autorelease];
}

+ (void) deleteSentence:(NSInteger)SentenceId userId:(NSInteger)userId{
	PLSqliteDatabase *dataBase = [favdatabase setup];
    //	NSString* date;
    //    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    //    [formatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    //    date = [formatter stringFromDate:[NSDate date]];
    //    NSLog(@"%@",date);
    //	NSString *findSql = [NSString stringWithFormat:@"delete from favword WHERE key = \"%@\" and userId = %d ;",key,userId];
    NSString *findSql = [NSString stringWithFormat:@"update favsentence set collected = -1  WHERE SentenceId = %d and userId = %d ;",SentenceId,userId];
	if([dataBase executeUpdate:findSql]) {
//               NSLog(@"sentence delete success!");
	}
	else {
//		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[errAlert show];
//        [errAlert release];
	}
}

/**
 *  查询最大SentenceId
 */
+ (NSInteger) findLastId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select max(SentenceId) last from favsentence"];
	rs = [dataBase executeQuery:findSql];
    int last = 0;
    if([rs next]) {
        @try {
            last = [rs intForColumn:@"last"];
        }
        @catch (NSException *exception) {}
        
    }
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	[rs close];
//    NSLog(@"last:%d",last);
    //	[dataBase close];//
	return last;
    
}

/**
 *  non-used
 */
+(id) findBySentenceId:(NSInteger)SentenceId userId:(NSInteger)userId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    //    const char *myVoaid = [voaid UTF8String];//NSString转变为字符数组
    //    int myVoaid = voaid.intValue;//NSString转变为整型
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM favsentence WHERE SentenceId = %d and userId = %d", SentenceId,userId];
	rs = [dataBase executeQuery:findSql];
	if([rs next]) {
        //        int voaid = [rs intForColumn:@"voaid"];
        NSInteger SentenceId = [rs intForColumn:@"SentenceId"];
        //        NSString *lang = [rs objectForColumn:@"lang"];
        NSInteger VoaId =[rs intForColumn:@"VoaId"];
        NSInteger ParaId = [rs intForColumn:@"ParaId"];
        NSInteger IdIndex = [rs intForColumn:@"IdIndex"];
        NSInteger StartTime = [rs intForColumn:@"StartTime"];
        NSInteger EndTime = [rs intForColumn:@"EndTime"];
        NSString *Sentence =[rs objectForColumn:@"Sentence"];
        NSString *Sentence_cn = [rs objectForColumn:@"SentenceCn"];
        NSInteger userId = [rs intForColumn:@"userId"];
        NSInteger collected = [rs intForColumn:@"collected"];
        VOASentence *voaSen=[[VOASentence alloc]initWithVOASentence:SentenceId VoaId:VoaId ParaId:ParaId IdIndex:IdIndex StartTime:StartTime EndTime:EndTime Sentence:Sentence Sentence_cn:Sentence_cn userId:userId collected:collected];
        [rs close];
        //	[dataBase close];//
        return [voaSen autorelease];
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
        return nil;
	}
    
}

/**
 *  查询收藏句子数
 */
+ (NSInteger) countOfCollected {
    PLSqliteDatabase *dataBase = [favdatabase setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select count(collected) collectCount FROM favsentence where collected=1"];
    rs = [dataBase executeQuery:findSql];
    NSInteger count = 0;
    if([rs next]) {
        count = [[rs objectForColumn:@"collectCount"] integerValue];
    }
    [rs close];
    return count;
}

@end
