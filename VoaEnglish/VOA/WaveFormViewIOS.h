//
//  WaveFormView.h
//  WaveFormTest
//
//  Created by Gyetván András on 7/11/12.
//  Copyright (c) 2012 DroidZONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AVFoundation/AVFoundation.h>
#import "WaveSampleProvider.h"
#import "WaveSampleProviderDelegate.h"

/**
 *
 */
@interface WaveFormViewIOS : UIControl<WaveSampleProviderDelegate>
{
	UIActivityIndicatorView *progress;
	CGPoint* sampleData;
	int sampleLength;
	WaveSampleProvider *wsp;	
	AVPlayer *player;
	float playProgress;
	NSString *infoString;
	NSString *timeString;
	UIColor *green;
	UIColor *gray;
    UIColor *black;
	UIColor *lightgray;
	UIColor *darkgray;
	UIColor *white;
	UIColor *marker;
    
    NSInteger type;
    NSMutableArray*linepath1;
    NSMutableArray*linepath2;
    CGPoint* wfvPath;
	NSInteger wfvLength;
    CGMutablePathRef originPath;
}

//- (void) openAudio:(NSString *)path;
@property (assign) NSInteger type;
@property (nonatomic,retain)NSMutableArray *linepath1;
@property (nonatomic,retain)NSMutableArray *linepath2;
@property (assign)CGPoint* wfvPath;
@property (assign)NSInteger wfvLength;

- (void) openAudioURL:(NSURL *)url own:(NSInteger)own;
- (BOOL) isReady ;
@end
