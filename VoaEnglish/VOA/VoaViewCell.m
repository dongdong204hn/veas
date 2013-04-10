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
@synthesize readImg;
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
    [self.myImage release], myImage = nil;
    [self.myDate release], myDate = nil;
    [self.myTitle release], myTitle = nil;
    [self.collectDate release], collectDate = nil;
    [self.readImg release], readImg = nil;
    [self.hotImg release], hotImg = nil;
    [self.readCount release], readCount = nil;
    [aftImage release],aftImage =nil;
    [super dealloc];
}


@end
