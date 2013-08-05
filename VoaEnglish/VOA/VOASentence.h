//
//  VOASentence.h
//  VOAAdvanced
//  句子收藏数据类
//  Created by iyuba on 12-11-16.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "favdatabase.h"

@interface VOASentence : NSObject{
    NSInteger SentenceId;
    NSInteger VoaId;
    NSInteger ParaId; 
    NSInteger IdIndex; 
    float StartTime;
    float EndTime;
    NSString *Sentence;
    NSString *Sentence_cn;
    NSInteger userId;
    NSInteger collected; //-1：被删除 1：被收藏 （均尚未与服务器同步）
    NSInteger synchroFlg;//标志服务器同步时是否有此词 0没有 1有
}

@property NSInteger SentenceId;
@property NSInteger VoaId;
@property NSInteger ParaId;
@property NSInteger IdIndex;
@property float StartTime;
@property float EndTime;
@property (nonatomic,retain) NSString * Sentence;
@property (nonatomic,retain) NSString * Sentence_cn;
@property NSInteger userId;
@property NSInteger collected;
@property NSInteger synchroFlg;

- (id) initWithVOASentence:(NSInteger) _SentenceId VoaId:(NSInteger) _VoaId ParaId:(NSInteger) _ParaId IdIndex:(NSInteger) _IdIndex StartTime:(float) _StartTime EndTime:(float) _EndTime  Sentence:(NSString *) _Sentence Sentence_cn:(NSString *) _Sentence_cn  userId:(NSInteger)_userId collected:(NSInteger) _collected synchroFlg:(NSInteger) _synchroFlg;
- (BOOL) alterCollect;
+ (void) alterCollectBySenId:(NSInteger)SentenceId;
- (void) alterSynchroCollect;
- (BOOL) isExist;
+ (NSInteger) findLastId;
+ (NSMutableArray *) findSentences: (NSInteger) userId;
+ (NSArray*) findAlterSentences:(NSInteger)userId;
+ (void) deleteSentence:(NSInteger ) SentenceId;
+ (void) deleteSenBySenId:(NSInteger)SentenceId;
+ (void) deleteSynchro:(NSInteger) userId;
+ (void) clearSynchro;
+ (id ) findBySentenceId:(NSInteger) SentenceId userId:(NSInteger)userId;
+ (NSInteger) countOfCollected;

+ (void) creatSynFlg;

+ (void) alterTimefield;

//+ (id) find:(NSString *) key userId:(NSInteger)userId;
@end
