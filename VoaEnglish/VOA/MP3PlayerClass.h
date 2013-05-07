//
//  MP3PlayerClass.h
//  JPTListeningLevel-3
//  音频控制辅助
//  Created by aiyuba on 12-1-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

/**
 *
 */
@interface MP3PlayerClass : NSObject {
}

//+ (void)timeSliderChanged:(UISlider *)slider 
//			   timeSlider:(UISlider *)timeSlider
//				localPlayer:(AVPlayer *)localPlayer 
//				   button:(UIButton *)playButton ;
//+ (void)playButton:(UIButton *)button 
//		 localPlayer:(AVPlayer *)localPlayer ;

/**
 *  拖动进度条响应事件
 */
+ (void)timeSliderChanged:(UISlider *)slider 
			   timeSlider:(UISlider *)timeSlider
              localPlayer:(AVPlayer *)localPlayer 
				   button:(UIButton *)playButton ;

/**
 *  控制播放/暂停
 */
+ (void)playButton:(UIButton *)button 
       localPlayer:(AVPlayer *)localPlayer ;

@end
