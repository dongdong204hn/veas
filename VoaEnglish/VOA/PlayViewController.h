//
//  PlayViewControl.h
//  VOA
//  “播放”容器
//  Created by song zhao on 12-2-6.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "VOAView.h"
#import "VOAFav.h"
#import "VOADetail.h"
#import "UIImageView+WebCache.h" //联网图片缓存
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h> 
#import "timeSwitchClass.h"
#import "DataBaseClass.h"
#import "LyricSynClass.h"
#import "MP3PlayerClass.h"
#import "VOAContent.h"
#import "ASIFormDataRequest.h"
#import "TextScrollView.h"
#import "MyLabel.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "VOAWord.h"
#import "MBProgressHUD.h"
//#import "AudioStreamer.h"
#import "Reachability.h"//isExistenceNetwork
#import "LogController.h"
#import "MyPageControl.h" //自定义页面控制组件
#import "GADBannerView.h" //内置广告
#import "SevenProgressBar.h" //自定义缓冲进度条
#import "ShareToCNBox.h"
#import "SVShareTool.h"
#include <AudioToolbox/AudioToolbox.h>
//#import "CommentViewController.h"
#import "HPGrowingTextView.h"   //评论的自动放大的输入框
#import "NSString+URLEncoding.h" //字符串的URL编解码
#import "CL_AudioRecorder.h"
#import "LocalWord.h"
#import "VOASentence.h"
#import "HSCButton.h" //可拖动的按钮
//#import "MyPickerView.h"
//#import "MyTextView.h"
#import "JMWhenTapped.h"    //给视图添加事件
#import "UserMessage.h"
#import "SendMessageController.h"
#import "InnerBuyController.h" 
//#include <sys/xattr.h>
//#import <AssetsLibrary/AssetsLibrary.h>
#import "DemoTransition.h"
#import "Demo2Transition.h"
#import "Demo3Transition.h"


@class timeSwitchClass;
//@class SpeakHereController;
@class CL_AudioRecorder;

//pickerView的三个编号
#define kHourComponent 0 
#define kMinComponent 1
#define kSecComponent 2
#define kCommTableHeightPh 60.0
#define kRecorderDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]  stringByAppendingPathComponent:@"Recorders"]
#define kBufferSize 8192

#define kRecordFile @"recordAudio.aac"
//#define kRecordFile @"recordAudio.wav"

@interface PlayViewController : UIViewController <UIAlertViewDelegate, AVAudioPlayerDelegate, ASIHTTPRequestDelegate,MyLabelDelegate,MBProgressHUDDelegate, AVAudioSessionDelegate, UIScrollViewDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,HPGrowingTextViewDelegate,HSCButtonDelegate, UITextViewDelegate>
{
    CL_AudioRecorder* audioRecoder;
    BOOL              m_isRecording;
    AVAsset *avSet;
    CMTime nowTime;
    
    VOAView *voa;
    
    UIImageView     *myImageView;
//    UIImageView     *wordFrame;
    
    UITableView *commTableView;
    
    HPGrowingTextView *textView;
    
//    UIPickerView *myPick;
    UIPickerView *myPick;
    
//    UIView     *viewOne;
//    UIView     *viewTwo;
    UIView     *myView;
    UIView *containerView;
    UIView *fixTimeView;
    UIView *bottomView;
    UIImageView *senImage;
    UIImageView *starImage;
    
    UIImage     *playImage;
    UIImage     *pauseImage;
    UIImage     *loadingImage;
    
    UIButton		*collectButton;
    UIButton		*playButton;
    UIButton        *preButton;
    UIButton        *nextButton;
    UIButton        *fixButton;
    UIButton        *clockButton;
    UIButton		*btn_record;
    UIButton		*btn_play;
    UIButton		*downloadFlg;
    UIButton        *downloadingFlg;
    UIButton        *modeBtn;
    UIButton        *displayModeBtn;
    UIButton        *shareSenBtn;
    UIButton        *colSenBtn;
    
//    UILabel      *downloadFlg;
//    UILabel      *downloadingFlg;
    UILabel			*totalTimeLabel;//总时间
	UILabel			*currentTimeLabel;//当前时间
    UILabel     *myHighLightWord;
    UILabel *recordLabel;
    MyLabel *explainView;
    MyLabel *lyricLabel;
    UILabel *lyricCnLabel; 
    
    TextScrollView	*textScroll;
    TextScrollView	*myScroll;
    
//    timeSwitchClass *timeSwitch;
    
	UISlider		*timeSlider;//时间滑块
    SevenProgressBar  *loadProgress;//缓冲进度
    
    NSTimer			*sliderTimer;
	NSTimer			*lyricSynTimer;
    NSTimer         *fixTimer;
    NSTimer         *recordTimer;
    NSTimer         *playRecordTimer;
    
//    NSTimer         *loadTimer;
    
    NSMutableArray	*lyricArray;
    NSMutableArray	*lyricCnArray;
	NSMutableArray	*timeArray;
	NSMutableArray	*indexArray;
	NSMutableArray	*lyricLabelArray;
    NSMutableArray	*lyricCnLabelArray;
    NSMutableArray    *listArray;
    NSMutableArray *commArray;
//    NSMutableData* mp3Data;
    NSArray         *hoursArray;
    NSArray         *minsArray;
    NSArray         *secsArray;
    
//	int				engLines;
//    int				cnLines;
    int             playerFlag;
    int             fixSeconds;
    int             recordSeconds;
    int             nowRecordSeconds;
    int             recordTime;
    
    NSInteger nowPage;
    NSInteger nowUserId;
    NSInteger totalPage;
//    NSInteger commNumber;
    
    AVPlayer	*player;
//    AVPlayer	*localPlayer;
    AVPlayer	*wordPlayer;
    
	NSURL			*mp3Url;
    
    BOOL localFileExist;
    BOOL downloaded;
    BOOL newFile;
//    BOOL switchFlg;
    BOOL needFlush;
    BOOL needFlushAdv;
//    BOOL isExisitNet;
    BOOL noBuffering;
    BOOL isiPhone;
    BOOL readRecord;
    BOOL isNewComm;
//    BOOL afterRecord;
    BOOL isFixing;
    BOOL flushList;
    BOOL isFree;
    BOOL notValid;
    BOOL isShareSen;
    
    NSString *userPath;
    
    VOAWord *myWord;
    
    MBProgressHUD *HUD;
    
    UITextView *imgWords;
    UITextView *titleWords;
    
//    double myStop;
    double seekTo;
    
    UIAlertView *alert;
    
//    NSNotificationCenter *myCenter;
    
    MyPageControl *pageControl;
    
    GADBannerView *bannerView_;
    
//    SpeakHereController *controller;
    
    NSInteger sen_num;
    NSInteger contentMode;
    NSInteger playMode;
    NSInteger playIndex;
    NSInteger category;
    
    NSString *lyEn;
    NSString *lyCn;
//    NSString *category;
    NSString *shareStr;
    
    UIFont *CourierOne;
    UIFont *CourierTwo;
    
    VOASentence *mySentence;
//    CFURLRef		soundFileURLRef;
//	SystemSoundID	soundFileObject;
//    
//    float time_total;
}
//@property (nonatomic, retain) IBOutlet SpeakHereController *controller;
@property (nonatomic, retain) UIButton		*collectButton; //下载按钮
@property (nonatomic, retain) IBOutlet UIButton        *preButton;  //上一句按钮
@property (nonatomic, retain) IBOutlet UIButton        *nextButton; //下一句按钮
//四个页面按钮
@property (nonatomic, retain) IBOutlet UIButton        *btnOne; 
@property (nonatomic, retain) IBOutlet UIButton        *btnTwo;
@property (nonatomic, retain) IBOutlet UIButton        *btnThree;
@property (nonatomic, retain) IBOutlet UIButton        *btnFour;
@property (nonatomic, retain) IBOutlet UIButton		*btn_record;    //录音按钮
@property (nonatomic, retain) IBOutlet UIButton		*btn_play;  //播放录音按钮

@property (nonatomic, retain) IBOutlet UIButton        *toolBtn;    //工具按钮
@property (nonatomic, retain) IBOutlet UIButton        *abBtn;  //复读按钮
@property (nonatomic, retain) IBOutlet HSCButton        *aBtn;  //复读a按钮
@property (nonatomic, retain) IBOutlet HSCButton        *bBtn;  //复读b按钮
@property (nonatomic, retain) IBOutlet UISlider		*lightSlider;   //屏幕亮度调节
@property (nonatomic, retain) IBOutlet UISlider		*speedSlider;   //播放速度调节
@property (nonatomic, retain) IBOutlet UIView       *toolView;  //工具栏视图

@property (nonatomic, retain) IBOutlet TextScrollView	*myScroll;
@property (nonatomic, retain) IBOutlet MyPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UILabel			*totalTimeLabel;//总时间
@property (nonatomic, retain) IBOutlet UILabel			*currentTimeLabel;//当前时间
@property (nonatomic, retain) IBOutlet UILabel *recordLabel;
@property (nonatomic, retain) IBOutlet UISlider		*timeSlider;//时间滑块

@property (nonatomic, retain) IBOutlet UIButton		*playButton;    //播放按钮
//@property (nonatomic, retain) IBOutlet UILabel      *downloadFlg;
//@property (nonatomic, retain) IBOutlet UILabel      *downloadingFlg;
@property (nonatomic, retain) IBOutlet UITextView *titleWords;  //新闻标题
@property (nonatomic, retain) IBOutlet UIImageView *RoundBack;  //四个页面按钮的标识图片
@property (nonatomic, retain) IBOutlet UIView *fixTimeView; //定时视图
@property (nonatomic, retain) IBOutlet UIView *bottomView;  //界面底栏
@property (nonatomic, retain) IBOutlet UIPickerView *myPick;    //设置定时的滑轮
@property (nonatomic, retain) IBOutlet UIButton  *fixButton;    //开启定时按钮
@property (nonatomic, retain) IBOutlet UIButton    *modeBtn;    //播放模式选择按钮
@property (nonatomic, retain) IBOutlet UIButton  *displayModeBtn;   //播放模式展示

@property (nonatomic, retain) UITextView        *nowTextView; //
@property (nonatomic, retain) UIMenuController	*speedMenu; //拖动语速栏时显示语速的控件
@property (nonatomic, retain) NSString	*selectWord;    //选择的字符串
@property (nonatomic) float	aValue; //复读区间a点值
@property (nonatomic) float	bValue; //幅度区间b点值
@property (nonatomic) BOOL isSpeedMenu; //标识当前UIMenuController显示的是否语速值
@property (nonatomic) BOOL isAbMenu; //标识当前UIMenuController显示的是否复读区间ab值
@property (nonatomic) BOOL isResponse; //标识当前评论是否是回复
@property (nonatomic) BOOL isInforComm; //标识当前的播放界面是否从消息内容处点击进来的

@property (nonatomic, retain) TextScrollView	*lyricScroll; //跟读界面显示英文的滚动文本框
@property (nonatomic, retain) TextScrollView	*lyricCnScroll; //跟读界面显示中文的滚动文本框

@property (nonatomic, retain) CL_AudioRecorder* audioRecoder;   //录音实例
@property (nonatomic) BOOL              m_isRecording; //标识是否正在录音
@property (nonatomic) CMTime nowTime;   //当前播放到的时间点
@property (nonatomic, retain) AVAsset *avSet; //保存当前播放的文件路径信息的对象
@property (nonatomic, retain) NSURL			*mp3Url; //保存当前播放的文件的URL路径
//@property (readwrite)	CFURLRef		soundFileURLRef;
//@property (readonly)	SystemSoundID	soundFileObject;
@property (nonatomic, retain) SevenProgressBar  *loadProgress;//缓冲进度条
@property (nonatomic, retain) GADBannerView *bannerView_; //广告条
@property (nonatomic, retain) VOAView *voa; //正在播放的voa
@property (nonatomic, retain) UIImageView     *myImageView; //显示新闻图片的视图
@property (nonatomic, retain) UIImageView *senImage;    //点击句子时截屏的句子图片
@property (nonatomic, retain) UIImageView *starImage;   //星星图片,暂未用
//@property (nonatomic, retain) UIImageView     *wordFrame;
@property (nonatomic, retain) UIButton        *shareSenBtn; //分享句子按钮
@property (nonatomic, retain) UIButton        *colSenBtn; //收藏句子按钮
@property (nonatomic, retain) UIButton        *sendBtn; //发表评论按钮
//@property (nonatomic, retain) timeSwitchClass *timeSwitch;
@property (nonatomic, retain) NSTimer			*sliderTimer; //播放时主定时器
@property (nonatomic, retain) NSTimer			*lyricSynTimer; //歌词同步定时器
@property (nonatomic, retain) NSTimer         *fixTimer; //定时播放定时器
@property (nonatomic, retain) NSTimer         *recordTimer; //录音定时器
//@property (nonatomic, retain) NSTimer			*updateTimer;
@property (nonatomic, retain) NSMutableArray	*lyricArray;    //英文歌词数组
@property (nonatomic, retain) NSMutableArray	*lyricCnArray;  //中文歌词数组
@property (nonatomic, retain) NSMutableArray	*timeArray; //歌词播放时长数组
@property (nonatomic, retain) NSMutableArray	*indexArray;    //歌词序列号数组
@property (nonatomic, retain) NSMutableArray	*lyricLabelArray;   //英文歌词标签数组
@property (nonatomic, retain) NSMutableArray	*lyricCnLabelArray; //中文歌词标签数组
@property (nonatomic, retain) NSMutableArray    *listArray; //播放列表
@property (nonatomic, retain) NSArray         *hoursArray; //定时播放小时数
@property (nonatomic, retain) NSArray         *minsArray;   //定时播放分钟数
@property (nonatomic, retain) NSArray         *secsArray;   //定时播放秒数
//@property int				engLines;
//@property int				cnLines;
@property int				playerFlag; //0:local 1:net
@property (nonatomic) int             recordSeconds;    //记录实际录音时长
@property (nonatomic) int             nowRecordSeconds; //实际录音时长的备份
@property (nonatomic) int             recordTime;   //根据歌词播放时长得到的自动录音时的最长时长
@property (nonatomic) int             fixSeconds;   //记录定时播放时秒数
//@property (nonatomic, retain) NSString *category;
@property (nonatomic) NSInteger category;   //记录当前播放的新闻的分类
@property (nonatomic) NSInteger nowPage;    //记录当前获取的评论的页数
@property (nonatomic) NSInteger totalPage;  //记录评论总页数
//@property (nonatomic) NSInteger commNumber;
@property (nonatomic) NSInteger contentMode;    //记录当前时联网播放（1）还是本地播放（2）
@property (nonatomic) NSInteger playMode;   //播放顺序 1：单曲 2：顺序 3：随机
@property (nonatomic) NSInteger playIndex;  //记录当前播放新闻在播放列表中的次序
//@property (nonatomic) NSInteger audioRouteFlg;  //记录当前播放新闻在播放列表中的次序
//@property (nonatomic, retain) AVPlayer	*localPlayer;
@property (nonatomic, retain) AVPlayer	*player;    //VOA新闻音频播放器，主播放器
@property (nonatomic, retain) AVPlayer	*wordPlayer;    //单词发音播放器
@property (nonatomic, retain) UILabel     *myHighLightWord; //旧取词标记所取单词的标签，暂未用
@property (nonatomic, retain) UIView      *myView;  //评论页面主视图
//@property (nonatomic, retain) NSMutableData* mp3Data;   
@property (nonatomic, retain) NSString *userPath;   //当前播放的音频在用户本地的理论存储路径
@property (nonatomic, retain) UIButton        *clockButton; //定时按钮
@property (nonatomic, retain) UIButton      *downloadFlg;   //已下载标记
@property (nonatomic, retain) UIButton      *downloadingFlg;    //下载中标记
@property BOOL localFileExist;  //标记当前新闻是否在本地存在
@property BOOL downloaded;  //标记是否刚刚下载音频到本地，方便点击播放按钮时切换在线播放为本地播放
@property BOOL newFile; //标记当前新闻是否是新的一篇新闻，便于区别回到播放
//@property BOOL switchFlg;
@property (nonatomic) BOOL isNewComm;   //标记当前用户是否有发表新评论，方便滚动评论界面到最新的评论
//@property (nonatomic) BOOL afterRecord;
@property (nonatomic) BOOL isFixing;    //标记是否正在定时播放中
@property (nonatomic) BOOL flushList;   //标记是否需要刷新播放列表
@property (nonatomic) BOOL isFree;  //标记是否是免费应用或未曾内购
@property (nonatomic) BOOL isFive;  //标记是否iPhone5
@property (nonatomic) BOOL isUpAlertShow;   //标记提示升级专业版的alert是否已弹出
@property (nonatomic) BOOL isInterupted;   //标记是否有外部打断事件

@property (nonatomic, retain) MyLabel *explainView; //取词翻译结果展示标签
@property (nonatomic, retain) VOAWord *myWord;  //存放取词取到的单词基本信息
@property (nonatomic, retain) MBProgressHUD *HUD;   //加载组件
//@property (nonatomic, retain) UIView *viewOne;  
//@property (nonatomic, retain) UIView *viewTwo;
@property (nonatomic, retain) TextScrollView	*textScroll;    //展示歌词的滚动文本视图
@property (nonatomic, retain) UITextView *imgWords; //展示新闻简介的文本框
//@property double myStop;    
@property (nonatomic, retain) UIImage *playImage;   //播放按钮的播放图片
@property (nonatomic, retain) UIImage *pauseImage;  //播放按钮的暂停图片
@property (nonatomic, retain) UIImage *loadingImage;    //播放按钮的加载图片
@property (nonatomic, retain) UIAlertView *alert;   //全局提示alert
//@property (nonatomic, retain) NSNotificationCenter *myCenter;   
@property (nonatomic, retain) NSString *lyEn;   //跟读页面的英文歌词
@property (nonatomic, retain) NSString *lyCn;   //跟读页面的中文歌词
@property (nonatomic, retain) NSString *shareStr;   //准备进行分享的句子内容
@property (nonatomic, retain) UITableView *commTableView;   //评论表视图
@property (nonatomic, retain) NSMutableArray *commArray;    //存放评论内容的数组
@property (nonatomic, retain) UIView *containerView;    //评论页面的底部视图，包含输入框及发表按钮
@property (nonatomic, retain) HPGrowingTextView *textView; //可换行的输入框控件
@property (nonatomic, retain) NSSet *wordTouches;
@property NSInteger nowUserId;  //记录当前用户ID
//@property BOOL isExisitNet;
@property (nonatomic, retain) VOASentence *mySentence;  //记录要收藏的句子的基本信息

void RouteChangeListener(	void *                  inClientData,
                         AudioSessionPropertyID	inID,
                         UInt32                  inDataSize,
                         const void *            inData);
- (IBAction) playButtonPressed:(UIButton *)sender;
- (void) collectButtonPressed:(UIButton *)sender;
- (IBAction) sliderChanged:(UISlider *)sender;
- (IBAction) goBack:(UIButton *)sender;
- (IBAction) prePlay:(id)sender;
- (IBAction) aftPlay:(id)sender;
- (void) shareTo;
- (IBAction)shareNew:(id)sender;
- (void)shareSen:(id)sender;
- (IBAction)changeView:(id)sender;
- (void)collectSentence:(id)sender;

//- (IBAction) shareText;
//- (void) shareAll;
//- (IBAction) showComments:(id)sender;
- (void) QueueDownloadVoa;
- (void)catchWords:(NSString *) word;
+ (PlayViewController *)sharedPlayer;
+ (NSOperationQueue *)sharedQueue;
-(BOOL) isExistenceNetwork:(NSInteger)choose;
//-(void)updateCurrentTimeForPlayer:(AVPlayer *)p;
- (void)setButtonImage:(UIImage *)image;
- (void)spinButton;
- (IBAction)changePage:(UIPageControl *)sender;
- (CMTime)playerItemDuration;
- (void) stopRecord;
- (void) aniToPlay:(UITextView *) myTextView ;
- (BOOL)isPlaying;

//- (void) stopRecordPlay;
//- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
//- (IBAction) recordButtonPressed:(UIButton *)sender;
@end
