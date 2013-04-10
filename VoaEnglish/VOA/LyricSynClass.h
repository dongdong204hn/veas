//
//  LyricSyn.h
//  VOA
//  音频控制类
//  Created by song zhao on 12-1-11.
//  Copyright 2012 iyuba. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "TextScrollView.h"
#import "RegexKitLite.h"
#import "PlayViewController.h"
#import "MyTextView.h"
//#import "MyLabel.h"

@interface LyricSynClass : NSObject{
//    id <UITextViewDelegate> delegate;
}

//@property (nonatomic,retain)id <UITextViewDelegate> delegate;

/**
 *  歌词同步
 */
+ (void)lyricSyn : (NSMutableArray *)lyricLabelArray 
lyricCnLabelArray: (NSMutableArray *)lyricCnLabelArray 
		   index : (NSMutableArray *)indexArray
			time : (NSMutableArray *)timeArray
	   localPlayer : (AVPlayer *)mp3Player 
		  scroll : (TextScrollView *)textScroll ;//歌词

//+ (void)lyricSynNet : (NSMutableArray *)lyricLabelArray 
//   lyricCnLabelArray: (NSMutableArray *)lyricCnLabelArray 
//              index : (NSMutableArray *)indexArray
//               time : (NSMutableArray *)timeArray
//        localPlayer : (AVPlayer *)mp3Player 
//             scroll : (TextScrollView *)textScroll ;//歌词

/**
 *  切换上一句
 */
+ (void)preLyricSyn: (NSMutableArray *)timeArray
       localPlayer : (AVPlayer *)mp3Player;

/**
 *  切换下一句
 */
+ (void)aftLyricSyn: (NSMutableArray *)timeArray
       localPlayer : (AVPlayer *)mp3Player;

//+ (void)preLyricSynNet: (NSMutableArray *)timeArray
//          localPlayer : (AVPlayer *)mp3Player;
//
//+ (void)aftLyricSynNet: (NSMutableArray *)timeArray
//          localPlayer : (AVPlayer *)mp3Player;

/**
 歌词排布
 @param  lyricLabelArray 存放英文歌词标签
 @return offSetY 全部歌词总高度
 */
+ (int)lyricView : (NSMutableArray *)lyricLabelArray
lyricCnLabelArray: (NSMutableArray *)lyricCnLabelArray
           index : (NSMutableArray *)indexArray
           lyric : (NSMutableArray *)lyricArray
         lyricCn : (NSMutableArray *)lyricCnArray
            time : (NSMutableArray *)timeArray
     localPlayer : (AVPlayer *)mp3Player
          scroll : (TextScrollView *)textScroll;
//  myLabelDelegate: (id <UITextViewDelegate>) myLabelDelegate
//        engLines : (int *)engLines //歌词显示
//         cnLines : (int *)cnLines ;//歌词显示

//+ (int)lyricView : (NSMutableArray *)lyricLabelArray 
//lyricCnLabelArray: (NSMutableArray *)lyricCnLabelArray 
//           index : (NSMutableArray *)indexArray 
//           lyric : (NSMutableArray *)lyricArray
//         lyricCn : (NSMutableArray *)lyricCnArray    
//          scroll : (TextScrollView *)textScroll 
//  myLabelDelegate: (id <MyLabelDelegate>) myLabelDelegate
//        engLines : (int *)engLines //歌词显示
//         cnLines : (int *)cnLines ;//歌词显示

/**
 *  按指定区域截屏
 */
+ (UIImage*)screenshot:(CGRect) senRect;
@end
