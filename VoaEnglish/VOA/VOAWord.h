//
//  VOAWord.h
//  VOA
//  生词本单词数据类
//  Created by song zhao on 12-2-24.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface VOAWord : NSObject
{
    NSInteger wordId;
    NSInteger userId;
    NSString *key;
    NSString *lang;
    NSString *audio;
    NSString *pron;
    NSString *def;
    NSString *date;
    NSInteger checks;//标记单词在生词本中被用户点击查看释义的次数
    NSInteger remember;//标记单词在生词本某块被显示的次数
    NSInteger flag;//标志增/删 
    NSInteger synchroFlg;//标志服务器同步时是否有此词 0没有 1有
    NSMutableArray *engArray; //英文例句
    NSMutableArray *chnArray; //中文例句
}
@property NSInteger wordId;
@property NSInteger userId;
@property(nonatomic,retain) NSString *key;
@property(nonatomic,retain) NSString *lang;
@property(nonatomic,retain) NSString *audio;
@property(nonatomic,retain) NSString *pron;
@property(nonatomic,retain) NSString *def;
@property(nonatomic,retain) NSString *date;
@property NSInteger checks;
@property NSInteger remember;
@property NSInteger flag;
@property NSInteger synchroFlg;
@property(nonatomic,retain) NSMutableArray *engArray;
@property(nonatomic,retain) NSMutableArray *chnArray;

- (id) initWithVOAWord:(NSInteger) wordId key:(NSString *) _key audio:(NSString *) _audio pron:(NSString *) _pron def:(NSString *) _def date:(NSString *) _date  checks:(NSInteger) _checks remember:(NSInteger) _remember  userId:(NSInteger)_userId flag:(NSInteger) _flag;


- (BOOL) alterCollect;
- (BOOL) isExisit;
- (BOOL) isDelete;
- (void) addRemember;
- (void) update;
- (void) alterSynchroCollect;

+ (NSMutableArray *) findWords:(NSInteger)userId;
+ (NSMutableArray *) findDelWords:(NSInteger)userId;
+ (void) deleteWord:(NSString *) key userId:(NSInteger) userId;
+ (void) addCheck:(NSInteger) wordId userId:(NSInteger)_userId;
+ (NSInteger) findLastId;
+ (VOAWord *) findById:(NSInteger) wordId userId:(NSInteger) userId;
+ (void) updateBykey:(NSString *) key audio:(NSString *) _audio pron:(NSString *) _pron def:(NSString *) _def userId:(NSInteger) _userId;
+ (void) updateFlgByKey:(NSString *) key userId:(NSInteger) _userId;
+ (void) deleteByKey:(NSString *) key userId:(NSInteger) userId;
+ (void) deleteByUserId:(NSInteger) userId;
+ (void) deleteSynchro:(NSInteger) userId;
+ (void) clearSynchro;
+ (NSInteger) countOfCollected;
+ (float) countOfRemember;
+ (NSArray*) findWorstWords:(NSMutableArray *) wordsArray;

//+ (id) find:(NSString *) key userId:(NSInteger)userId;
//+ (NSInteger) findCountByUserId:(NSInteger)userId;
@end
