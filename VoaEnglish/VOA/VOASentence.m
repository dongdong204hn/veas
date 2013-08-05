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
@synthesize synchroFlg;

-(id) initWithVOASentence:(NSInteger) _SentenceId VoaId:(NSInteger)_VoaId ParaId:(NSInteger)_ParaId IdIndex:(NSInteger)_IdIndex StartTime:(float)_StartTime EndTime:(float)_EndTime Sentence:(NSString *)_Sentence Sentence_cn:(NSString *)_Sentence_cn userId:(NSInteger)_userId collected:(NSInteger) _collected  synchroFlg:(NSInteger) _synchroFlg
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
        self.synchroFlg = _synchroFlg;
    }
    return self;

}

-(BOOL) isExist
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM favsentence WHERE VoaId=%d and StartTime>%f and StartTime<%f and userId = %d and collected > -1",self.VoaId,self.StartTime-0.1,self.StartTime+0.1,self.userId];
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
 *  收藏句子， 并标记
 */
- (BOOL) alterCollect{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    BOOL flg;
    if (![self isExist]) {
        NSString *findSql = [NSString stringWithFormat:@"insert into favsentence(SentenceId,VoaId,ParaId,IdIndex,StartTime,EndTime,Sentence,SentenceCn,userId,collected,synchroFlg) values(%d,%d,%d,%d,%f,%f,\"%@\",\"%@\",%d,1,0);",SentenceId,VoaId,ParaId,IdIndex,StartTime,EndTime,Sentence,Sentence_cn,userId];
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

/**
 *  完成告知服务器，取消标记
 */
+ (void) alterCollectBySenId:(NSInteger)SentenceId{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    NSString *findSql = [NSString stringWithFormat:@"update favsentence set collected = 0  WHERE SentenceId = %d;",SentenceId];
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
 *  同步用户句子时标识此句是存在的
 */
- (void) alterSynchroCollect
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    NSString* myDate;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    myDate = [formatter stringFromDate:[NSDate date]];
    //    NSLog(@"%@",myDate);
    if (![self isExist]) {
        NSString *findSql = [NSString stringWithFormat:@"insert into favsentence(SentenceId,VoaId,ParaId,IdIndex,StartTime,EndTime,Sentence,SentenceCn,userId,collected,synchroFlg) values(%d,%d,%d,%d,%f,%f,\"%@\",\"%@\",%d,0,1);",SentenceId,VoaId,ParaId,IdIndex,StartTime,EndTime,Sentence,Sentence_cn,userId];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
        else {
            
        }
    }else
    {
        NSString *findSql = [NSString stringWithFormat:@"update favsentence set synchroFlg = 1 WHERE VoaId = %d and userId= %d and StartTime>%f and StartTime<%f;", VoaId,userId,StartTime-0.1,StartTime+0.1];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
    }
    [formatter release],formatter = nil;
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
        float StartTime = [rs floatForColumn:@"StartTime"];
        float EndTime = [rs floatForColumn:@"EndTime"];
        NSString *Sentence =[[rs objectForColumn:@"Sentence"] autorelease];
        NSString *Sentence_cn = [[rs objectForColumn:@"SentenceCn"] autorelease];

        NSInteger userId = [rs intForColumn:@"userId"];
        NSInteger collected = [rs intForColumn:@"collected"];
        NSInteger synchroFlg = [rs intForColumn:@"synchroFlg"];
        VOASentence *sentence=[[VOASentence alloc]initWithVOASentence:SentenceId VoaId:VoaId ParaId:ParaId IdIndex:IdIndex StartTime:StartTime EndTime:EndTime Sentence:Sentence Sentence_cn:Sentence_cn userId:userId collected:collected synchroFlg:synchroFlg];
		[sentences addObject:sentence];
		[sentence release];
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
    return [sentences autorelease];
}

+(NSArray*) findAlterSentences:(NSInteger)userId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	
	id<PLResultSet> rs;
	rs = [dataBase executeQuery:[NSString stringWithFormat:@"SELECT * FROM favsentence where collected!=0 and userId = %d",userId]];
    
	//定义一个数组存放所有信息
	NSMutableArray *sentences = [[NSMutableArray alloc] init];
	
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger SentenceId = [rs intForColumn:@"SentenceId"];
        //        NSString *lang = [rs objectForColumn:@"lang"];
        NSInteger VoaId =[rs intForColumn:@"VoaId"];
        NSInteger ParaId = [rs intForColumn:@"ParaId"];
        NSInteger IdIndex = [rs intForColumn:@"IdIndex"];
        float StartTime = [rs floatForColumn:@"StartTime"];
        float EndTime = [rs floatForColumn:@"EndTime"];
        NSString *Sentence =[[rs objectForColumn:@"Sentence"] autorelease];
        NSString *Sentence_cn = [[rs objectForColumn:@"SentenceCn"] autorelease];
        
        NSInteger userId = [rs intForColumn:@"userId"];
        NSInteger collected = [rs intForColumn:@"collected"];
        NSInteger synchroFlg = [rs intForColumn:@"synchroFlg"];
        VOASentence *sentence=[[VOASentence alloc]initWithVOASentence:SentenceId VoaId:VoaId ParaId:ParaId IdIndex:IdIndex StartTime:StartTime EndTime:EndTime Sentence:Sentence Sentence_cn:Sentence_cn userId:userId collected:collected synchroFlg:synchroFlg];
		[sentences addObject:sentence];
		[sentence release];
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
    return [sentences autorelease];
}

+ (void) deleteSentence:(NSInteger)SentenceId{
	PLSqliteDatabase *dataBase = [favdatabase setup];
    //	NSString* date;
    //    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    //    [formatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    //    date = [formatter stringFromDate:[NSDate date]];
    //    NSLog(@"%@",date);
    //	NSString *findSql = [NSString stringWithFormat:@"delete from favword WHERE key = \"%@\" and userId = %d ;",key,userId];
    NSString *findSql = [NSString stringWithFormat:@"update favsentence set collected = -1  WHERE SentenceId = %d;",SentenceId];
	if([dataBase executeUpdate:findSql]) {
//               NSLog(@"sentence delete success!");
	}
	else {
//		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[errAlert show];
//        [errAlert release];
	}
}

+ (void) deleteSenBySenId:(NSInteger)SentenceId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	NSString *findSql = [NSString stringWithFormat:@"delete from favsentence where SentenceId = %d",SentenceId];
    if([dataBase executeUpdate:findSql]) {
        //        NSLog(@"--success!");
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
    //	[dataBase close];//
}

/**
 *  同步后删除服务器该用户没有的句子
 */
+ (void) deleteSynchro:(NSInteger) userId
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	NSString *findSql = [NSString stringWithFormat:@"delete from favsentence where synchroFlg = 0 and collected = 0 and userId = %d;",userId];
    if([dataBase executeUpdate:findSql]) {
        //        NSLog(@"--success!");
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
}

/**
 *  全部句子标记已同步
 */
+ (void) clearSynchro
{
    PLSqliteDatabase *dataBase = [favdatabase setup];
	NSString *findSql = [NSString stringWithFormat:@"update favsentence set synchroFlg = 0;"];
    if([dataBase executeUpdate:findSql]) {
        //        NSLog(@"--success!");
	}
	else {
        
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
        float StartTime = [rs floatForColumn:@"StartTime"];
        float EndTime = [rs floatForColumn:@"EndTime"];
        NSString *Sentence =[[rs objectForColumn:@"Sentence"] autorelease];
        NSString *Sentence_cn = [[rs objectForColumn:@"SentenceCn"] autorelease];
        NSInteger userId = [rs intForColumn:@"userId"];
        NSInteger collected = [rs intForColumn:@"collected"];
        NSInteger synchroFlg = [rs intForColumn:@"synchroFlg"];
        VOASentence *voaSen=[[VOASentence alloc]initWithVOASentence:SentenceId VoaId:VoaId ParaId:ParaId IdIndex:IdIndex StartTime:StartTime EndTime:EndTime Sentence:Sentence Sentence_cn:Sentence_cn userId:userId collected:collected synchroFlg:synchroFlg];
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

/**
    在表favsentence中增加字段：synchroFlg
 */
+ (void) creatSynFlg {
    PLSqliteDatabase *dataBase = [favdatabase setup];
    NSString *findSql = [NSString stringWithFormat:@"ALTER TABLE favsentence ADD synchroFlg integer DEFAULT 0"];
    [dataBase executeUpdate:findSql];
}

/**
 数据库表favsentence修改列StartTime和EndTime类型为float.
 */
+ (void) alterTimefield {
    PLSqliteDatabase *db = [favdatabase setup];
    NSString *findSql = [NSString stringWithFormat:@"CREATE TABLE favsentenceTwo (SentenceId integer NOT NULL PRIMARY KEY,VoaId integer,ParaId integer,IdIndex integer,StartTime float,EndTime float DEFAULT 1800,Sentence varchar,SentenceCn varchar,userId integer NOT NULL DEFAULT 0,collected integer DEFAULT 0,synchroFlg integer NOT NULL DEFAULT 0);"];
    [db executeUpdate:findSql];
    findSql = [NSString stringWithFormat:@"insert into favsentenceTwo select * from favsentence;"];
    [db executeUpdate:findSql];
    findSql = [NSString stringWithFormat:@"drop table favsentence;"];
    [db executeUpdate:findSql];
    findSql = [NSString stringWithFormat:@"alter table favsentenceTwo rename to favsentence;"];
    [db executeUpdate:findSql];
}

@end
