//
//  VoaViewCell.m
//  VOA
//
//  Created by song zhao on 12-2-8.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "VoaViewCell.h"

@implementation VoaViewCell

@synthesize myImage;
@synthesize myTitle;
@synthesize myDate;
@synthesize collectDate;
//@synthesize read;
//@synthesize readImg;
//@synthesize hot;
@synthesize hotImg;
@synthesize readCount;

@synthesize downloadBtn;
@synthesize progress;
@synthesize aftImage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc {
    [myImage release];
    [hotImg release];
    [myTitle release];
    [myDate release];
    [readCount release];
    [collectDate release];
    [aftImage release];
    [downloadBtn release];
    [progress release];
//    [self.readImg release], readImg = nil;
    [super dealloc];
}


@end
