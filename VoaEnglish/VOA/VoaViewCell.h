//
//  VoaViewCell.h
//  VOA
//  新闻列表单元项
//  Created by song zhao on 12-2-8.
//  Copyright (c) 2012年 buaa. All rights reserved.
//
#import "DACircularProgress/DACircularProgressView.h"

@interface VoaViewCell : UITableViewCell
{
    UIImageView *myImage;
    UILabel *myTitle;
    UILabel *myDate;
    UILabel *collectDate;
//    UILabel *hot;
//    UILabel *read;
    UIImageView *hotImg;
//    UIImageView *readImg;
    UIImageView *aftImage;
    UIButton *downloadBtn;
    DACircularProgressView *progress;
}

@property (nonatomic,retain) IBOutlet UIImageView *myImage;
@property (nonatomic,retain) IBOutlet UIImageView *hotImg;
@property (nonatomic,retain) IBOutlet UILabel *myTitle;
@property (nonatomic,retain) IBOutlet UILabel *myDate;
@property (nonatomic,retain) IBOutlet UILabel *readCount;
@property (nonatomic,retain) IBOutlet UILabel *collectDate;
@property (nonatomic,retain) IBOutlet UIImageView *aftImage;
@property (nonatomic,retain) UIButton *downloadBtn;
@property (nonatomic,retain) DACircularProgressView *progress;
//@property (nonatomic,retain) IBOutlet UILabel *hot;
//@property (nonatomic,retain) IBOutlet UILabel *read;
//@property (nonatomic,retain) IBOutlet UIImageView *readImg;



@end
