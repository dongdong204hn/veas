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
    NSInteger StartTime;
    NSInteger EndTime;
    NSString *Sentence;
    NSString *Sentence_cn;
    NSInteger userId;
    NSInteger collected; //-1：被删除 1：被收藏
}

@property NSInteger SentenceId;
@property NSInteger VoaId;
@property NSInteger ParaId;
@property NSInteger IdIndex;
@property NSInteger StartTime;
@property NSInteger EndTime;
@property (nonatomic,retain) NSString * Sentence;
@property (nonatomic,retain) NSString * Sentence_cn;
@property NSInteger userId;
@property NSInteger collected;

- (id) initWithVOASentence:(NSInteger) _SentenceId VoaId:(NSInteger) _VoaId ParaId:(NSInteger) _ParaId IdIndex:(NSInteger) _IdIndex StartTime:(NSInteger) _StartTime EndTime:(NSInteger) _EndTime  Sentence:(NSString *) _Sentence Sentence_cn:(NSString *) _Sentence_cn  userId:(NSInteger)_userId collected:(NSInteger) _collected;
- (BOOL) alterCollect;
- (BOOL) isExist;
+ (NSInteger) findLastId;
+ (NSMutableArray *) findSentences: (NSInteger) userId;
+ (void) deleteSentence:(NSInteger ) SentenceId userId:(NSInteger)userId;
+ (id ) findBySentenceId:(NSInteger) SentenceId userId:(NSInteger)userId;
+ (NSInteger) countOfCollected;

//+ (id) find:(NSString *) key userId:(NSInteger)userId;
@end
