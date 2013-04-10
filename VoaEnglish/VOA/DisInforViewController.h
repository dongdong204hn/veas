//
//  DisInforViewController.h
//  VOA
//  “信息”版块容器
//  Created by zhao song on 13-1-22.
//  Copyright (c) 2013年 buaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTweetLabel.h"
#import "UIImageView+WebCache.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "PlayViewController.h"
#import "VOAView.h"
#import "MBProgressHUD.h"
#import "JMWhenTapped.h"
#import "StudyTime.h"

@interface DisInforViewController : UIViewController <STLinkProtocol,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (nonatomic, retain) IBOutlet TextScrollView *inforScroll; //三屏滑动视图
@property (nonatomic, retain) IBOutlet TextScrollView *appScroll; //应用的滑动视图
@property (nonatomic, retain) IBOutlet UIView       *recordView; //展示用户学习记录
@property (nonatomic, retain) IBOutlet UIView       *appView; //展示应用
@property (nonatomic, retain) IBOutlet UILabel      *avgOfDayStudyTLab;
//用户记录页的各个标签
@property (nonatomic, retain) IBOutlet UILabel      *todayStudyTLab;
@property (nonatomic, retain) IBOutlet UILabel      *countOfReadedLab;
@property (nonatomic, retain) IBOutlet UILabel      *loveClassLab;
@property (nonatomic, retain) IBOutlet UILabel      *countOfCollectVoaLab;
@property (nonatomic, retain) IBOutlet UILabel      *countOfCollectSenLab;
@property (nonatomic, retain) IBOutlet UILabel      *countOfCollectWordLab;
@property (nonatomic, retain) IBOutlet UILabel      *avgOfRemWordLab;
@property (nonatomic, retain) IBOutlet UILabel      *remWorstWord;
//应用展示页的各个图标
@property (nonatomic, retain) IBOutlet UIImageView  *img1;
@property (nonatomic, retain) IBOutlet UIImageView  *img2;
@property (nonatomic, retain) IBOutlet UIImageView  *img3;
@property (nonatomic, retain) IBOutlet UIImageView  *img4;
@property (nonatomic, retain) IBOutlet UIImageView  *img5;
@property (nonatomic, retain) IBOutlet UIImageView  *img6;
@property (nonatomic, retain) IBOutlet UIImageView  *img7;
@property (nonatomic, retain) IBOutlet UIImageView  *img8;
@property (nonatomic, retain) IBOutlet UIImageView  *img9;
@property (nonatomic, retain) IBOutlet UIImageView  *img10;
@property (nonatomic, retain) IBOutlet UIImageView  *img11;
@property (nonatomic, retain) IBOutlet UIImageView  *img12;
@property (nonatomic, retain) IBOutlet UIImageView  *img13;
@property (nonatomic, retain) IBOutlet UIImageView  *img14;
@property (nonatomic, retain) IBOutlet UIImageView  *img15;
@property (nonatomic, retain) IBOutlet UIImageView  *img16;
@property (nonatomic, retain) IBOutlet UIImageView  *img17;
@property (nonatomic, retain) IBOutlet UIImageView  *img18;
@property (nonatomic, retain) IBOutlet UIImageView  *img19;
@property (nonatomic, retain) IBOutlet UIImageView  *img20;
@property (nonatomic, retain) IBOutlet UIImageView  *img21;
@property (nonatomic, retain) IBOutlet UIImageView  *img22;
@property (nonatomic, retain) IBOutlet UIImageView  *img23;
@property (nonatomic, retain) IBOutlet UIImageView  *img24;
@property (nonatomic, retain) IBOutlet UIImageView  *img25;
@property (nonatomic, retain) IBOutlet UIImageView  *img26;
@property (nonatomic, retain) IBOutlet UIImageView  *img27;

@property (nonatomic, retain) UIAlertView       *alert; 
@property (nonatomic, retain) UISegmentedControl    *segmentedControl; 
@property (nonatomic, retain) UITableView           *msgTv; //消息列表
@property (nonatomic, retain) STTweetLabel          *disMsgLab; //展示消息内容的标签
@property (nonatomic, retain) UILabel          *alertLab;
@property (nonatomic, retain) NSMutableArray *inforArray; //存放消息
@property (nonatomic, retain) UIButton *logBtn; //登录按钮
@property (nonatomic, retain) UIButton *editBtn; //删除按钮
@property (nonatomic, retain) MBProgressHUD *HUD; //加载组件
@property (nonatomic) BOOL isiPhone;
@property (nonatomic) BOOL rightCharacter;
@property (nonatomic) NSInteger toVoaid; //消息相关的新闻id
//@property (nonatomic) NSInteger nowPage;
//@property (nonatomic) NSInteger totalPage;
@end
