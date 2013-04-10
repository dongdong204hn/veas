//
//  VOADetail.h
//  VOA
//  新闻内容类
//  Created by song zhao on 12-2-3.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VOAView.h"
#import "VOAContent.h"
@interface VOADetail : NSObject
{
    NSInteger _voaid;
    NSInteger _paraid; //段落号
    NSInteger _idIndex; //句数号
    NSInteger _timing; //时长
    NSString *_sentence;
    NSString *_imgWords; //图片描述
    NSString *_imgPath; //图片路径
    NSString *_sentence_cn;
//    NSString *_sentence_jp;
}

@property NSInteger _voaid;
@property NSInteger _paraid;
@property NSInteger _idIndex;
@property NSInteger _timing;
@property (nonatomic, retain) NSString *_sentence;
@property (nonatomic, retain) NSString *_imgWords;
@property (nonatomic, retain) NSString *_imgPath;
@property (nonatomic, retain) NSString *_sentence_cn;
//@property (nonatomic, retain) NSString *_sentence_jp;

- (BOOL) insert;
- (id) initWithVoaId:(NSInteger) voaid paraid:(NSInteger) paraid idIndex:(NSInteger) idIndex timing:(NSInteger) timing sentence:(NSString *)sentence  imgWords:(NSString *) imgWords imgPath:(NSString *) imgPath sentence_cn:(NSString *) sentence_cn;
+ (id) find:(NSInteger) voaid;
+ (BOOL) isExist:(NSInteger) voaid;
+ (void) deleteByVoaid:(NSInteger)voaid ;
+ (id) findByVoaidAndTime:(NSInteger)voaid timing:(NSInteger) timing;

//+ (NSArray *) findAll;
//+ (NSInteger) findLastId;
//+ (NSString *) findImgWords:(NSInteger) voaid;
@end
