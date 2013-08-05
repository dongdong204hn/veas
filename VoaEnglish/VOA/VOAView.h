//
//  VOAView.h
//  VOA
//  新闻信息数据类
//  Created by song zhao on 12-2-3.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RegexKitLite.h"
#import "VOAContent.h"
#import "VOAFav.h"
@interface VOAView : NSObject
{
    NSInteger _voaid;
    NSString *_title;
    NSString *_descCn;
    NSString *_descJp;
    NSString *_titleCn;
    NSString *_titleJp;
    NSString *_category;
    NSString *_sound;
    NSString *_url;
    NSString *_pic;
    NSString *_creatTime;
    NSString *_pulishTime; //未用(保留字段)
    NSString *_readCount;
    NSString *_hotFlg;
    NSString *_isRead;
    NSInteger _downloading; //标记是否正在下载 1：正在下载
//    NSString *_title_cn;
//    NSString *_title_jp;

}

@property NSInteger _voaid;
@property (nonatomic, retain) NSString *_title;
@property (nonatomic, retain) NSString *_descCn;
@property (nonatomic, retain) NSString *_descJp;
@property (nonatomic, retain) NSString *_title_Cn;
@property (nonatomic, retain) NSString *_title_Jp;
@property (nonatomic, retain) NSString *_category;
@property (nonatomic, retain) NSString *_sound;
@property (nonatomic, retain) NSString *_url;
@property (nonatomic, retain) NSString *_pic;
@property (nonatomic, retain) NSString *_creatTime;
@property (nonatomic, retain) NSString *_publishTime;
@property (nonatomic, retain) NSString *_readCount;
@property (nonatomic, retain) NSString *_hotFlg;
@property (nonatomic, retain) NSString *_isRead;
@property NSInteger _downloading;
//@property (nonatomic, retain) NSString *_title_jp;

- (BOOL) insert;

//全赋值初始化VOAView对象
- (id) initWithVoaId:(NSInteger ) voaid title:(NSString *) title descCn:(NSString *) descCn descJp:(NSString *) descJp title_Cn:(NSString *)title_Cn  title_Jp:(NSString *) title_Jp category:(NSString *) category sound:(NSString *) sound url:(NSString *) url pic:(NSString *) pic creatTime:(NSString *) creatTime publishTime:(NSString *) publishTime readcount:(NSString *) readCount hotFlg:(NSString *) hotFlg isRead:(NSString *) isRead;


+ (NSMutableArray *) findNew:(NSInteger)offset newVoas:(NSMutableArray *) newVoas;

+ (NSMutableArray *) findNewByCategory:(NSInteger)offset category:(NSInteger ) category myArray:(NSMutableArray *) myArray;
//查找并返回指定id的对象
+ (id) find:(NSInteger ) voaid;

+ (BOOL) isSimilar:(NSInteger) voaid search:(NSString *) search;

+ (NSString *) getContent:(NSInteger) voaid;

+ (NSMutableArray *) findFavSimilar:(NSArray *) favsArray search:(NSString *) search;

+ (int) numberOfMatch:(NSString *) sentence search:(NSString *)search;

+ (NSInteger) findLastId;

+ (void) alterRead:(NSInteger)voaid;

+ (NSMutableArray *) findDownloading;

+ (void) alterDownload:(NSInteger)voaid;

+ (void) deleteByVoaid:(NSInteger)voaid;

+ (void) clearDownload:(NSInteger)voaid;

+ (void) clearAllDownload;

+ (BOOL) isDownloading:(NSInteger)voaid;

+ (BOOL) isExist:(NSInteger) voaid;

+ (NSArray *) getList:(NSMutableArray *)listArray category:(NSInteger)category;

+ (BOOL) isRead:(NSInteger)voaid;

+ (void) alterReadCount:(NSInteger)voaid count:(NSInteger)count;

+ (NSInteger) findReadCount:(NSInteger)voaid;

+ (NSInteger) countOfReaded;

+ (NSInteger) findLoveClass;

//查找并返回全部对象
//+ (NSMutableArray *) findAll;

//+ (NSMutableArray *) findVoaBetween:(NSInteger)max mix:(NSInteger)mix;
//+ (NSMutableArray *) findNew:(NSInteger)offset;
//+ (NSMutableArray *) findByCategory:(NSString *) category;

//+ (NSMutableArray *) findDate;

//+ (NSMutableArray *) findDateByCategory:(NSString *) category;

//+ (NSMutableArray *) findByDate:(NSString *) Date;

//+ (NSInteger) findNumberByDate:(NSString *) Date;

//+ (NSMutableArray *) findByCategoryDate:(NSString *) Date category:(NSString *) category;
//+ (NSMutableArray *) findSimilar:(NSArray *) voasArray search:(NSString *) search progressBar:progressView;
//+ (NSMutableArray *) findAfterByCategory:(NSInteger)voaid;
//+ (NSMutableArray *) findSimilar:(NSArray *) voasArray search:(NSString *) search;

@end
