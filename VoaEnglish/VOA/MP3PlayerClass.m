//
//  MP3PlayerClass.m
//  VOA
//
//  Created by song zhao on 12-2-6.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "MP3PlayerClass.h"


@implementation MP3PlayerClass

//+ (void)timeSliderChanged:(UISlider *)slider 
//			   timeSlider:(UISlider *)timeSlider
//				localPlayer:(AVAudioPlayer *)mp3Player 
//				   button:(UIButton *)playButton {
////  引用+1
//	[slider retain];
//	[timeSlider retain];
//	[mp3Player retain];
//	[playButton retain];
//	
////	Fast skip the music when user scroll the UISlider
////  暂停的时候也可以拖动进度条
//	if (slider.maximumValue == slider.value) {
//		
//		mp3Player.currentTime = 0;
//		
//	}//end if
//	else {
//		
//		if (mp3Player.playing == NO) {
//			[mp3Player pause];
//			[mp3Player setCurrentTime:timeSlider.value];
//		}//end if
//		else {
//			[mp3Player stop];
//			[mp3Player setCurrentTime:timeSlider.value];
//			[mp3Player prepareToPlay];
//			[mp3Player play];
//		}//end else
//		
//	}//end else
//	
////释放
//	[slider release];
//	[timeSlider release];
//	[mp3Player release];
//	[playButton release];
//}
//
//+ (void)playButton:(UIButton *)button 
//		 localPlayer:(AVAudioPlayer *)mp3Player {
////	retain
//	[button retain];
//	[mp3Player retain];
//	
////	Play the audio
//	if (mp3Player.playing) {
//        [button setImage:[UIImage imageNamed:@"PpausePressed.png"] forState:UIControlStateNormal];
//		[mp3Player pause];
//	}
//	else {
//		[button setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
//		[mp3Player prepareToPlay];
//		[mp3Player play];
//	}
//	
////  release
//	[button release];
//	[mp3Player release];
//	
//}

+ (void)timeSliderChanged:(UISlider *)slider 
			   timeSlider:(UISlider *)timeSlider
              localPlayer:(AVPlayer *)mp3Player 
				   button:(UIButton *)playButton {
    //  引用+1
	[slider retain];
	[timeSlider retain];
	[mp3Player retain];
	[playButton retain];
	
    //	Fast skip the music when user scroll the UISlider
    //  暂停的时候也可以拖动进度条
	if (slider.maximumValue <= slider.value) {
		[playButton.layer removeAllAnimations];
//		[mp3Player seekToTime:kCMTimeZero];//#$$#
        [mp3Player seekToTime:CMTimeMakeWithSeconds(slider.maximumValue - 1, NSEC_PER_SEC)];
//        NSLog(@"maximumValue:%f", slider.maximumValue);
//        [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
		
	}//end if
	else {
//        if ((slider.maximumValue-6) < slider.value)
//        {
//            
//        }else
//        {
            [mp3Player seekToTime:CMTimeMakeWithSeconds(timeSlider.value, NSEC_PER_SEC)];
//        }
		
	}//end else

    //释放
	[slider release];
	[timeSlider release];
	[mp3Player release];
	[playButton release];
}

+ (void)playButton:(UIButton *)button 
       localPlayer:(AVPlayer *)mp3Player {
    //	retain
	[button retain];
	[mp3Player retain];
	
    //	Play the audio
	if (mp3Player.rate != 0.f) {
		[mp3Player pause];
	}
	else {
		[mp3Player play];
	}
	
    //  release
	[button release];
	[mp3Player release];
	
}

@end
