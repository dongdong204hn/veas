//
//  NewViewController.m
//  VOA
//
//  Created by song zhao on 12-2-2.
//  Copyright (c) 2012年 buaa. All rights rese/Users/zhaosong/workplace/VOA/VOA/PlayViewController.xibrved.
//

#import "NewController.h"
#import "database.h"
#import "UIImageView+WebCache.h"

@implementation NewController

//@synthesize localArray;
@synthesize category;
@synthesize nowTitle;
@synthesize classTableView;
@synthesize classArray;
@synthesize titleBtn;
@synthesize voasArray;
@synthesize lastId;
@synthesize addNum;
@synthesize pageNum;
//@synthesize isExisitNet;
@synthesize rightCharacter;
@synthesize reloading = _reloading;
@synthesize isiPhone;
@synthesize search;
@synthesize voasTableView;
@synthesize HUD;
@synthesize refreshHeaderView;
@synthesize sharedSingleQueue;
@synthesize notSelect;
@synthesize returnButton;
@synthesize returnTimer;
@synthesize isValid;

extern NSMutableArray *downLoadList;
extern ASIHTTPRequest *nowrequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        NSLog(@"%@",nibNameOrNil);

    }

    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - My Action
/**
 *  获取下载队列
 */
- (NSOperationQueue *)sharedQueue
{
//    static NSOperationQueue *sharedSingleQueue;
    
    @synchronized(self)
    {
        if (!sharedSingleQueue){
            sharedSingleQueue = [[NSOperationQueue alloc] init];
            [sharedSingleQueue setMaxConcurrentOperationCount:1];
        }
        return sharedSingleQueue;
    }
}

/**
 *  回到播放页面
 */
- (void)doReturn
{
//    HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
//    HUD.dimBackground = YES;
//    HUD.labelText = @"connecting!";
    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    HUD.dimBackground = YES;
    [HUD show:YES];
//    [HUD release];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{  
            PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
            if(play.voa._voaid > 0 )
            {
                play.newFile = NO;
            }else
            {
                play.newFile = YES;
                NSInteger voaid = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lastPlay"] integerValue];
                if (voaid > 0) {
                    play.voa = [[VOAView find:voaid] retain];
                    play.contentMode = [[NSUserDefaults standardUserDefaults] integerForKey:@"contentMode"];
                    
                }else
                {
                    play.voa = [[VOAView find:746] retain];
                    play.voa._isRead = @"1";
                    play.contentMode =1;
                }
                play.category =0;
            }
            [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
            
            /*NSObject<EPGLTransitionViewDelegate> *transition;
            
            //                                                switch ([sender tag]) {
            //                                                    case 0:
            transition = [[[DemoTransition alloc] init] autorelease];
            //                                                        break;
            //                                                    case 1:
            //                                                        transition = [[[Demo2Transition alloc] init] autorelease];
            //                                                        break;
            //                                                    case 2:
            //                                                        transition = [[[Demo3Transition alloc] init] autorelease];
            //                                                        break;
            //                                                }
            
            EPGLTransitionView *glview = [[[EPGLTransitionView alloc]
                                           initWithView:self.view
                                           delegate:transition] autorelease];
            [glview prepareTextureTo:play.view];
            // If you are using an "IN" animation for the "next" view set appropriate
            // clear color (ie no alpha)
            
            [glview setClearColorRed:0.1
                               green:0.1
                                blue:0.1
                               alpha:0.1];
            [glview startTransition];*/
            
            [self.navigationController pushViewController:play animated:NO];
            [HUD hide:YES];
        });
    });
}

/**
 *  按关键字对标题和内容进行搜索
 */
- (void)doSearch
{
    self.navigationController.navigationBarHidden = YES;
    if (classTableView.frame.size.height!=0.0) {
        [titleBtn setSelected:NO];
        
        [Constants beginAnimationWithName:@"classAniOne" duration:0.6f];
        [self setMytitleUp];
        [titleBtn setBackgroundColor:[UIColor clearColor]];
        if (isiPhone) {
            [classTableView setFrame:CGRectMake(85, 0, 150, 0)];
        }else{
            [classTableView setFrame:CGRectMake(284, 0, 200, 0)];
        }
        [UIView commitAnimations];

    }
    if (isiPhone) {
        [search setFrame:CGRectMake(0, 0, 320, 44)];
        [voasTableView setFrame:CGRectMake(0, 44, 320, kViewHeight)];
    }else {
        [search setFrame:CGRectMake(0, 0, 768, 44)];
        [voasTableView setFrame:CGRectMake(0, 44, 768, kViewHeight)];
    }
    [search setHidden:NO];
}

//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}

/**
 *  展开收起下拉类别表视图
 */
- (void)doSwitch:(UIButton *) sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        
        [Constants beginAnimationWithName:@"classAniOne" duration:0.6f];
        [self setMytitleUp];
        [sender setBackgroundColor:[UIColor clearColor]];
        if (isiPhone) {
            [classTableView setFrame:CGRectMake(85, 0, 150, 0)];
        }else{
            [classTableView setFrame:CGRectMake(284, 0, 200, 0)];
        }
                [UIView commitAnimations];
    } else {
        [sender setSelected:YES];
        
        [Constants beginAnimationWithName:@"classAniTwo" duration:0.6f];
        [self setMytitleDown];
        [sender setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.44f]];
        if (isiPhone) {
            [classTableView setFrame:CGRectMake(85, 0, 150, 275)];

        } else {
            [classTableView setFrame:CGRectMake(284, 0, 200, 440)];

        }
                [UIView commitAnimations];
        
        //        [sender setBackgroundColor:[UIColor colorWithRed:0.44f green:0.44f blue:0.44f alpha:1.0f]];
    }
}

/**
 *  ↑展开类别列表时设置标题按钮的内容
 */
- (void)setMytitleUp{
    [titleBtn setTitle:[NSString stringWithFormat:@"%@ ∵", nowTitle] forState:UIControlStateNormal];
}

/**
 *  ↑展开类别列表时设置标题按钮的内容
 */
- (void)setMytitleDown{
    [titleBtn setTitle:[NSString stringWithFormat:@"%@ ∴", nowTitle] forState:UIControlStateNormal];
}


#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"alertShowed"]==NO) {
        downLoadList = [[VOAView findDownloading] retain];
        if ([downLoadList count]!=0) {
            UIActionSheet *downLoadSheet = [[UIActionSheet alloc] initWithTitle:kNewSeven delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:kNewEight,kNewNine,kNewTen, nil];
            [downLoadSheet showInView:self.view.window];
            
        }
    }
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"alertShowed"];
    
    
}

/**
 * 获取数据库中数据并存入voasArray，基于此数组数据建立tableView
 */
- (void) viewWillAppear:(BOOL)animated {
//    [self catchNetA];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
        
    });
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightMode"]) {
        [[UIApplication sharedApplication].keyWindow setBackgroundColor:[UIColor colorWithRed:0.196f green:0.31f blue:0.521f alpha:5.0]];
        ;
    } else {
        //        [self.view setBackgroundColor:[UIColor clearColor]];
        [[UIApplication sharedApplication].keyWindow setBackgroundColor:[UIColor whiteColor]];
        ;
    }
    
    notSelect = YES;
    isPlayPage = NO;
//    [self setTitle:@"最新"];
//    isExisitNet = [self isExistenceNetwork:0];

    
    [self.voasTableView reloadData];//reloadData只能保证tableView重读数据，但是数据的改变要靠自己手动才行。
    [search setPlaceholder:kNewOne];
    self.navigationController.navigationBarHidden = NO;
    [voasTableView setUserInteractionEnabled:YES];
    if (isiPhone) {
        [voasTableView setFrame:CGRectMake(0, 0, 320, kViewHeight)];
        [search setFrame:CGRectMake(0, 0, 320, 44)];
    }else {
        [voasTableView setFrame:CGRectMake(0, 0, 768, kViewHeight)];
        [search setFrame:CGRectMake(0, 0, 768, 44)];
    }
    [search setBackgroundColor:[UIColor clearColor]];
	[search setHidden:YES];
    
//    if (category == 10) {
//        NSArray *favViews = [VOAFav findCollect];
//        [localArray removeAllObjects];
//        for (id fav in favViews) {
//            [localArray addObject:fav];
//        }
//        [self.voasTableView reloadData];
//        [favViews release], favViews = nil;
//    }

    if ([[PlayViewController sharedPlayer] isPlaying]) {
        isValid = YES;
        returnTimer = [NSTimer scheduledTimerWithTimeInterval:0.3
                                                       target:self
                                                     selector:@selector(playAni)
                                                     userInfo:nil
                                                      repeats:YES];
    }
}

- (void) playAni {
    if (returnButton.tag == 1) {
        [returnButton setImage:[UIImage imageNamed:@"playingTwo.png"]];
        [returnButton setTag:2];
    } else if (returnButton.tag == 2) {
        [returnButton setImage:[UIImage imageNamed:@"playingThree.png"]];
        [returnButton setTag:3];
    } else {
        [returnButton setImage:[UIImage imageNamed:@"playingOne.png"]];
        [returnButton setTag:1];
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    if (isValid) {
        isValid = NO;
        [returnTimer invalidate];
        [returnButton setImage:[UIImage imageNamed:@"playingTwo.png"]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isValid = NO;
    self.title = kNewThree;
    isiPhone = ![Constants isPad];
    
    voasArray = [[NSMutableArray alloc]init];
//    localArray= [[NSMutableArray alloc]init];
//    
//    NSArray *favViews = [VOAFav findCollect];
//    for (id fav in favViews) {
//        [localArray addObject:fav];
//    }
//    [self.voasTableView reloadData];
//    [favViews release], favViews = nil;
    
    search = [[UISearchBar alloc] init];
    search.delegate = self;
    [self.view addSubview:search];
    [search release];//$$
    
    
    classArray = [[NSArray alloc] initWithObjects:kClassAll,kClassTwo,kClassThree,kClassFour,kClassFive,kClassSix,kClassSeven,kClassEight,kClassNine,kClassTen,kClassTwelve,nil];
    if (isiPhone) {
        classTableView = [[UITableView alloc] initWithFrame:CGRectMake(85, 0, 150, 0)];

    } else {
        classTableView = [[UITableView alloc] initWithFrame:CGRectMake(284, 0, 200, 0)];
    }
    [classTableView setTag:2];
    classTableView.dataSource = self;
    [classTableView setDelegate:self];
    [classTableView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.44]];
    [classTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:classTableView];
    [classTableView release];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(doSearch)];
	self.navigationItem.leftBarButtonItem = editButton;
    [editButton release], editButton = nil;
    
    returnButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"playingTwo.png"] style:UIBarButtonItemStylePlain target:self action:@selector(doReturn)];
    [returnButton setTag:1];
    self.navigationItem.rightBarButtonItem = returnButton;
//    [returnButton release], returnButton = nil;
   
    search.backgroundImage = [UIImage imageNamed:@"title.png"];
//    [search setKeyboardType:UIKeyboardAppearanceAlert];
//    search.backgroundColor = [UIColor clearColor];
//    self.title = kNewThree;
    if (isiPhone) {
        titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    } else {
        titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    }
    
    [titleBtn setBackgroundColor:[UIColor clearColor]];
    //    [[titleBtn layer] setCornerRadius:5.0f];
    //    [[titleBtn layer] setMasksToBounds:YES];
    //    [titleBtn setTitle:@"全部" forState:UIControlStateNormal];
    category = 0;
    nowTitle = kClassAll;
    [self setMytitleUp];
    [titleBtn addTarget:self action:@selector(doSwitch:) forControlEvents:UIControlEventTouchUpInside];
//    NSLog(@"titleBtn:%d", [titleBtn retainCount]);
    self.navigationItem.titleView = titleBtn;
    [titleBtn release];
//    NSLog(@"titleBtn:%d", [titleBtn retainCount]);
    //    HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
    //    HUD.dimBackground = YES;
    //    HUD.labelText = kNewFour;
    //    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    //
    //        dispatch_async(dispatch_get_main_queue(), ^{
    self.lastId = [VOAView findLastId];
    //            isExisitNet = [self isExistenceNetwork:0];
    pageNum = 1;
    //            if (isExisitNet) {
    //                [self catchIntroduction:0 pages:pageNum pageNum:10 ];
    //            }
    self.voasArray = [VOAView findNew:10*(pageNum-1) newVoas:self.voasArray];
    pageNum++;
    addNum = 10;
    //            NSLog(@"lastId:%d",lastId);
    [self.voasTableView reloadData];
    //            [HUD hide:YES];
    //        });
    //    });
    
    if(_refreshHeaderView == nil){
        EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.voasTableView.bounds.size.height, self.voasTableView.bounds.size.width, self.voasTableView.bounds.size.height)];
        view.delegate = self;
        [self.voasTableView addSubview:view];
         [view release];
        _refreshHeaderView = view;
    }
    //  update the last update date
//    [_refreshHeaderView refreshLastUpdatedDate];

}

- (void)viewDidUnload
{
    self.voasTableView = nil;
    [voasArray release], voasArray = nil;
    [sharedSingleQueue release], sharedSingleQueue = nil;
    [classArray release], classArray = nil;
    [titleBtn release], titleBtn = nil;
//    [search release], search = nil;
//    [classTableView release], classTableView = nil;
    [refreshHeaderView release], refreshHeaderView = nil;
    [nowTitle release], nowTitle = nil;
    [returnButton release], returnButton = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    voasTableView.delegate = nil;
    voasTableView.dataSource = nil;
    [voasTableView release];
    [voasArray release];
    [sharedSingleQueue release];
    [classArray release];
    [titleBtn release];
    search.delegate = nil;
    [search release];
    classTableView.delegate = nil;
    classTableView.dataSource = nil;
    [classTableView release];
    [nowTitle release];
    [refreshHeaderView release];
    [returnButton release];
    
    
//    [self.voasTableView release], voasTableView = nil;
//    [voasArray release], voasArray = nil;
//    [self.sharedSingleQueue release], sharedSingleQueue = nil;
//    
//    [self.classArray release], classArray = nil;
//    [self.titleBtn release], titleBtn = nil;
//    [self.search release], search = nil;
//    [self.classTableView release], classTableView = nil;
//    [self.nowTitle release], nowTitle = nil;
//    [self.refreshHeaderView release], refreshHeaderView = nil;
//    [self.returnButton release], returnButton = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
-(void)reloadTableViewDataSource{
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    
//    NSLog(@"isExisitNet:%d",isExisitNet);
    if (kNetIsExist) {
//        NSLog(@"开始刷新");
        
        [self catchIntroduction:0 pages:1 pageNum:10 ]; //下拉刷新向服务器请求最新的第一页十条数据
        
//        pageNum = 1;
//        NSArray *voas = [[NSArray alloc] init];
//        //    NSLog(@"获取生词到:%d",nowUserId);
//        voas = [VOAView findNew:10*(pageNum-1) newVoas:self.voasArray];;
//        [voasArray removeAllObjects];
//        for (id fav in voas) {
//            [voasArray addObject:fav];
//        }
//        pageNum++;
//        addNum = 10;
//        [voas release], voas = nil;
        
//        [self.voasArray removeAllObjects];
//        [self catchIntroduction:0 pages:1 pageNum:10 ];
//        pageNum = 1;
//        self.voasArray = [VOAView findNew:10*(pageNum-1) newVoas:self.voasArray];
//        pageNum++;
//        addNum = 10;
        
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            kNetTest;
        });
    }
    _reloading =YES;
//    [self doneLoadingTableViewData];
}

/**
 *  下拉刷新之前加载最新的一页十篇新闻
 */
-(void)doneLoadingTableViewData{
    //  model should call this when its done loading
    if (_reloading) {
        _reloading =NO;
//        kNetTest;
        if (kNetIsExist) {
            [self.voasArray removeAllObjects];
            self.lastId = [VOAView findLastId];
            pageNum = 1;
            addNum = 1;
            if (category == 0) {
                self.voasArray = [VOAView findNew:10*(pageNum-1) newVoas:self.voasArray];
            } else if (category<11) {
                self.voasArray = [VOAView findNewByCategory:10*(pageNum-1) category:category myArray:self.voasArray];
            } else {
                
            }
            pageNum++;
            addNum = 10;
            [self.voasTableView reloadData];
            
        }
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.voasTableView];    
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
/**
 *  启动下拉刷新
 */
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
//    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(reloadTableViewDataSource) object:nil];
//    [thread start];
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:6.0];
}
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
}
-(NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return[NSDate date]; // should return date data source was last changed
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    //    NSLog(@"table:%d",tableView.tag);
//    return (tableView.tag == 1? (category == 10? [localArray count]: [voasArray count]+2): [classArray count]);
    return (tableView.tag == 1? [voasArray count]+2: [classArray count]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        NSUInteger row = [indexPath row];
        if ([indexPath row]<[voasArray count]) {
            static NSString *FirstLevelCell= @"NewCell";
            VOAView *voa = [self.voasArray objectAtIndex:row];
            //        NSLog(@"-----cell id:%d",voa._voaid);
            VoaViewCell *cell = (VoaViewCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
            
            if (!cell) {
                if (isiPhone) {
                    cell = (VoaViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"VoaViewCell"
                                                                        owner:self
                                                                      options:nil] objectAtIndex:0];
                }else {
                    cell = (VoaViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"VoaViewCell-iPad"
                                                                        owner:self
                                                                      options:nil] objectAtIndex:0];
                }
            }
            cell.myTitle.text = ([voa._title_Cn isEqualToString:@"(null)"]? voa._title: voa._title_Cn);
            NSLog(@"voaid:%d %@", voa._voaid, voa._creatTime);
            cell.myDate.text = voa._creatTime;
            cell.readCount.text = [NSString stringWithFormat:@"%i%@", [VOAView findReadCount:voa._voaid]+11321, kSearchThirte];
            //--------->设置内容换行
            [cell.myTitle setLineBreakMode:UILineBreakModeClip];
            //--------->设置最大行数
            [cell.myTitle setNumberOfLines:3];
            NSURL *url = [NSURL URLWithString: voa._pic];
            [cell.myImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            //        NSLog(@"readmy:%@",voa._isRead);
            if ([VOAView isRead:voa._voaid]) {
//                [cell.readImg setImage:[UIImage imageNamed:@"detailRead-ipad.png"]];
                [cell.hotImg setHidden:YES];
            }else
            {
                //                    [cell.myTitle setTextColor:[UIColor redColor]];
                //                    [cell.myDate setTextColor:[UIColor redColor]];
                //                    [cell.readImg setImage:[UIImage imageNamed:@"detail-ipad.png"]];
                [cell.hotImg setHidden:NO];
                
            }
            if (voa._hotFlg.integerValue == 1) {
                //            NSLog(@"hot:1");
            }
            if (isiPhone) {
                cell.downloadBtn = [[[UIButton alloc] initWithFrame:CGRectMake(280, 45, 33, 33)] autorelease];
            } else {
                cell.downloadBtn = [[[UIButton alloc] initWithFrame:CGRectMake(670, 44, 63, 63)] autorelease];
            }
            if ([VOAFav isCollected:voa._voaid]) {
                [cell.downloadBtn setHidden:YES];
                [cell.aftImage setHidden:NO];
            }else {
                [cell.aftImage setHidden:YES];
                [cell.downloadBtn setTag:voa._voaid];
                int i=0;
                for (; i<[downLoadList count]; i++) {
                    int downloadid = [[downLoadList objectAtIndex:i]intValue];
                    if (downloadid ==voa._voaid) {
                        break;
                    }
                }
                if (i<[downLoadList count]) {
                    if (voa._voaid == nowrequest.tag){
                        [cell.downloadBtn addTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                        
                        if (isiPhone) {
                            DACircularProgressView *test = [[DACircularProgressView alloc]initWithFrame:CGRectMake(278, 43, 37, 37)];
                            cell.progress = test;
//                            NSLog(@"progress1:%d", [cell.progress retainCount]);
//                            NSLog(@"test1:%d",   test.retainCount);
                            [cell.progress retain];
//                            NSLog(@"progress1:%d", [cell.progress retainCount]);
                            [test release], test = nil;
                            
//                            cell.progress=[[[DACircularProgressView alloc]initWithFrame:CGRectMake(278, 43, 37, 37)] autorelease];
                            [cell.downloadBtn setImage:[UIImage imageNamed:@"stopdl.png"] forState:UIControlStateNormal];
                        } else {
                            DACircularProgressView *test = [[DACircularProgressView alloc]initWithFrame:CGRectMake(666, 40, 71, 71)];
                            cell.progress = test;
                            [cell.progress retain];
                            [test release], test = nil;
                            
                            [cell.downloadBtn setImage:[UIImage imageNamed:@"stopdl@2x.png"] forState:UIControlStateNormal];
                        }
                        
                        nowrequest.downloadProgressDelegate = cell.progress;
                        [nowrequest updateDownloadProgress];
                        [cell addSubview:cell.progress];
//                        [cell.progress release];
                        
                    }else{
                        [cell.downloadBtn addTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                        if (isiPhone) {
                            [cell.downloadBtn setImage:[UIImage imageNamed:@"waiting.png"] forState:UIControlStateNormal];
                        } else {
                            [cell.downloadBtn setImage:[UIImage imageNamed:@"waiting@2x.png"] forState:UIControlStateNormal];
                        }
                    }
                }else{
                    if (isiPhone) {
                        [cell.downloadBtn setImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];
                    } else {
                        [cell.downloadBtn setImage:[UIImage imageNamed:@"dl@2x.png"] forState:UIControlStateNormal];
                    }
                    
                    [cell.downloadBtn addTarget:self action:@selector(QueueDownloadMusicBtn:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
            [cell addSubview:cell.downloadBtn];
            //    cell.downloadBtn addTarget:self action: forControlEvents:
            cell.tag = voa._voaid;
            
            return cell;
        }else
        {
            if ([indexPath row]==[voasArray count]) {
                static NSString *SecondLevelCell= @"NewCellOne";
                UITableViewCell *cellTwo = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:SecondLevelCell];
                //            if (addNum > 0) {
                //                if (!cellTwo) {
                //                    //                cellTwo = [[UITableViewCell alloc]init];
                //                    //                cellTwo = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SecondLevelCell] autorelease];
                //                    if (isiPhone) {
                //                        cellTwo = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SecondLevelCell] autorelease];
                //                    }else {
                //                        cellTwo = (VoaViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"VoaImageCell-iPad"
                //                                                                               owner:self
                //                                                                             options:nil] objectAtIndex:0];
                //                    }
                //                }
                //                [cellTwo setSelectionStyle:UITableViewCellSelectionStyleNone];
                //                //                cellTwo.imageView.contentMode = UIViewContentModeScaleToFill;
                //                //                if (isiPhone) {
                //                [cellTwo.imageView setImage:[UIImage imageNamed:@"load.png"]];
                //                //                } else {
                //                //                    [cellTwo.imageView setImage:[UIImage imageNamed:@"load-ipad.png"]];
                //                //                }
                //            } else {
                //                [cellTwo setHidden:YES];
                //            }
                if (!cellTwo) {
                    //                cellTwo = [[UITableViewCell alloc]init];
                    //                cellTwo = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SecondLevelCell] autorelease];
                    if (isiPhone) {
                        cellTwo = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SecondLevelCell] autorelease];
                    }else {
                        cellTwo = (VoaViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"VoaImageCell-iPad"
                                                                               owner:self
                                                                             options:nil] objectAtIndex:0];
                    }
                }
                [cellTwo setSelectionStyle:UITableViewCellSelectionStyleNone];
                //            NSLog(@"cell width:%f",cellTwo.frame.size.width);
                //            if (isiPhone) {
                //                [cellTwo setFrame:CGRectMake(0, 0, 320, 28)];
                //                [cellTwo.imageView setFrame:CGRectMake(0, 0, 320, 28)];
                //            } else {
                //                [cellTwo setFrame:CGRectMake(0, 0, 768, 28)];
                //                [cellTwo.imageView setFrame:CGRectMake(0, 0, 768, 28)];
                //            }
                //            NSLog(@"cell width after:%f",cellTwo.frame.size.width);
                if (addNum > 0) {
                    //                cellTwo.imageView.contentMode = UIViewContentModeScaleToFill;
                    if (isiPhone) {
                        [cellTwo.imageView setImage:[UIImage imageNamed:@"load.png"]];
                    }
                } else {
                    [cellTwo setHidden:YES];
                }
                //            NSLog(@"width:%f",cellTwo.imageView.frame.size.width);
                return cellTwo;
            }else
            {
                if ([indexPath row]==[voasArray count]+1) {
                    //                NSLog(@"enter");
                    static NSString *ThirdLevelCell= @"NewCellTwo";
                    UITableViewCell *cellThree = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:ThirdLevelCell];
                    if (!cellThree) {
                        cellThree = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ThirdLevelCell] autorelease];
                        //                    cellThree = [[UITableViewCell alloc]init];
                    }
                    //                UITableViewCell *cellThree = [[UITableViewCell alloc]init];
                    [cellThree setSelectionStyle:UITableViewCellSelectionStyleNone];
                    [cellThree setHidden:YES];
                    if (row>lastId) {
                    } else
                    {
                        //                    NSLog(@"重新加载");
                        
                        if (kNetIsExist) {
                            //                        NSLog(@"lastId:%d",lastId);
                            if (addNum>0) {
                                //                            NSLog(@"联网重新加载");
                                [self catchIntroduction:(0) pages:pageNum pageNum:10];
                            }
                        }else {
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                kNetTest;
                            });
                            NSMutableArray *addArray = [[NSMutableArray alloc]init];
                            if (category == 0) {
                                addArray = [VOAView findNew:10*(pageNum-1) newVoas:addArray];
                            } else if (category<11) {
                                addArray = [VOAView findNewByCategory:10*(pageNum-1) category:category myArray:addArray];
                            } else {
                                
                            }
                            
                            //                            addArray = [VOAView findNew:10*(pageNum-1) newVoas:addArray];
                            pageNum ++;
                            addNum = 0;
                            for (VOAView *voaOne in addArray) {
                                [self.voasArray addObject:voaOne];
                                addNum++;
                            }
                            [addArray release],addArray = nil;
                            
                            [self.voasTableView reloadData];
                            
                        }
                        //                    NSLog(@"lastId2:%d",lastId);
                        
                        //                    NSMutableArray *addArray = [[NSMutableArray alloc]init];
                        //                    addArray = [VOAView findNew:10*(pageNum-1) newVoas:addArray];
                        //                    pageNum ++;
                        //                    addNum = 0;
                        //                    for (VOAView *voaOne in addArray) {
                        //                        [self.voasArray addObject:voaOne];
                        //                        addNum++;
                        //                    }
                        //                    [addArray release],addArray = nil;
                        //
                        //                    [self.voasTableView reloadData];
                    }
                    return cellThree;
                }
            }
        }
    } else {
        NSUInteger row = [indexPath row];
        UIFont *classFo;
        if (isiPhone) {
            classFo = [UIFont systemFontOfSize:16];
        } else {
            classFo = [UIFont systemFontOfSize:18];
        }
       
        //            UIFont *classFoPad = [UIFont systemFontOfSize:20];
        static NSString *ClsssCell= @"ClsssCell";
        UITableViewCell *cellThree = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:ClsssCell];
        if (!cellThree) {
            cellThree = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ClsssCell] autorelease];
            UILabel *classLabel = [[UILabel alloc] init];
            if (isiPhone) {
                [classLabel setFrame:CGRectMake(40, 0, 80, 25)];
                [classLabel setFont:classFo];
            } else {
                [classLabel setFrame:CGRectMake(60, 0, 100, 40)];
                [classLabel setFont:classFo];
            }
            
            [classLabel setBackgroundColor:[UIColor clearColor]];
            [classLabel setTag:1];
            [classLabel setTextColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8f]];
            [classLabel setTextAlignment:NSTextAlignmentCenter];
            //            [wordLabel setTextColor:[UIColor colorWithRed:0.112f green:0.112f blue:0.112f alpha:1.0f]];
            //            [wordLabel  setLineBreakMode:UILineBreakModeClip];
            //            [wordLabel setNumberOfLines:1];
            [cellThree addSubview:classLabel];
            [classLabel release];
        }
        
        for (UIView *nLabel in [cellThree subviews]) {
            
            if (nLabel.tag == 1) {
                [(UILabel*)nLabel setText:[NSString stringWithFormat:@"%@   ", [classArray objectAtIndex:row]]];
            }
            
        }
        
        [cellThree setSelectionStyle:UITableViewCellSelectionStyleGray];
        cellThree.backgroundColor = [UIColor clearColor];
        //        [cellThree.textLabel setText:[classArray objectAtIndex:row]];
        //        [cellThree.textLabel setTextAlignment:NSTextAlignmentRight];
        //        [cellThree.textLabel setBackgroundColor:[UIColor clearColor]];
        //        [cellThree.textLabel setTextColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.8f]];
        return cellThree;
    
    }
    
    return nil;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((tableView.tag == 1)? ( category == 11? (isiPhone?80.0f:160.0f):(([indexPath row]<[voasArray count])?(isiPhone?80.0f:160.0f):(([indexPath row]==[voasArray count]+1)?1.0f:(isiPhone?28.0f:48.0f)))): (isiPhone?25.0f:40.0f));
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self catchNetA];
//    kNetTest;
    NSInteger row = [indexPath row];
    if (tableView.tag == 1) {
        if (classTableView.frame.size.height < 200.f) {
            if (search.isFirstResponder) {
                [self.search resignFirstResponder];
                NSString *searchWords =  [self.search text];
                if (searchWords.length == 0) {
                }else
                {
                    self.navigationController.navigationBarHidden = NO;
                    
//                    if (category == 10) {
//                        NSMutableArray *allVoaArray = localArray;
//                        NSMutableArray *contentsArray = nil;
//                        contentsArray = [VOAView findFavSimilar:allVoaArray search:searchWords];
//                        //                NSLog(@"count:%d", [contentsArray count]);
//                        
//                        if ([contentsArray count] == 0) {
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kColFour message:[NSString stringWithFormat:@"%@ %@ %@",kSearchThree,searchWords,kColThree] delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil, nil ];
//                            [alert show];
//                            [alert release];
//                            [contentsArray release];
//                        }else
//                        {
//                            search.text = @"";
//                            SearchViewController *searchController = [SearchViewController alloc];
//                            searchController.searchWords = searchWords;
//                            searchController.contentsArray = contentsArray;
//                            searchController.contentMode = 2;
//                            [contentsArray release];
//                            searchController.searchFlg = 11;
//                            [self.navigationController pushViewController:searchController animated:YES];
//                            [searchController release], searchController = nil;
//                        }
//                    } else {
                        if (isiPhone) {
                            [voasTableView setFrame:CGRectMake(0, 0, 320, kViewHeight)];
                            [search setFrame:CGRectMake(0, 0, 320, 44)];
                        }else {
                            [voasTableView setFrame:CGRectMake(0, 0, 768, kViewHeight)];
                            [search setFrame:CGRectMake(0, 0, 768, 44)];
                        }
                        
                        [search setHidden:YES];
                        search.text = @"";
                        SearchViewController *searchController = [SearchViewController alloc];
                        searchController.searchWords = searchWords;
                        searchController.searchFlg = category;
                        searchController.contentMode = 1;
                        searchController.category = category;
                        [self.navigationController pushViewController:searchController animated:YES];
                        [searchController release], searchController = nil;
//                    }
                    
                }
            }else{
                if (!search.isHidden) {
                    self.navigationController.navigationBarHidden = NO;
                    if (isiPhone) {
                        [voasTableView setFrame:CGRectMake(0, 0, 320, kViewHeight)];
                        [search setFrame:CGRectMake(0, 0, 320, 44)];
                                            }else {
                        [voasTableView setFrame:CGRectMake(0, 0, 768, kViewHeight)];
                        [search setFrame:CGRectMake(0, 0, 768, 44)];
                    }
                    [search setHidden:YES];
                    search.text = @"";
                }else{
                    /*if (category == 10) {
                        NSUInteger row = [indexPath row];
                        
                        VOAFav *fav = [localArray objectAtIndex:row];
                        
//                        HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
//                        
//                        HUD.dimBackground = YES;
//                        
//                        HUD.labelText = @"connecting!";
                        
                        HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
                        [[UIApplication sharedApplication].keyWindow addSubview:HUD];
                        HUD.delegate = self;
                        HUD.labelText = @"Loading";
                        [HUD show:YES];
                        
                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                VOAView *voa = [VOAView find:fav._voaid];
                                PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
                                if(play.voa._voaid == voa._voaid)
                                {
                                    play.newFile = NO;
                                }else
                                {
                                    play.newFile = YES;
                                    play.voa = voa;
                                }
                                [voa release];
                                [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
                                if (play.contentMode != 2) {
                                    play.flushList = YES;
                                    play.contentMode = 2;
                                }
                                [self.navigationController pushViewController:play animated:NO];
                                [HUD hide:YES];
                            });
                        });
                    } else {*/
                    if ([indexPath row]<[voasArray count]) {
                        if (notSelect) {
                            notSelect = NO;
                            [voasTableView setUserInteractionEnabled:NO];
                            NSUInteger row = [indexPath row];
                            VOAView *voa = [self.voasArray objectAtIndex:row];
                            //                NSLog(@"PIC:%@,MP3:%@",voa._pic,voa._sound);
                            if ([voa._pic isEqualToString:@""] || [voa._pic isEqualToString:@"null"] || voa._pic == nil) {
                                [VOAView deleteByVoaid:voa._voaid];
                                [self.voasTableView reloadData];
                            } else {
                                if ([VOADetail isExist:voa._voaid] || [self isExistenceNetwork:1]) {
                                    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
                                    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
                                    HUD.delegate = self;
                                    HUD.labelText = @"Loading";
                                    HUD.dimBackground = YES;
                                    [HUD show:YES];
//                                    [HUD release];
                                    //                                        HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
                                    //                                        HUD.dimBackground = YES;
                                    //                                        HUD.labelText = @"connecting!";
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            VOADetail *myDetail = [VOADetail find:voa._voaid];
                                            if (!myDetail) {
                                                //  NSLog(@"内容不全-%d",voa._voaid);
                                                
                                                if (kNetIsExist) {
                                                    [VOADetail deleteByVoaid: voa._voaid];
                                                    //                                        NSLog(@"voaid:%i",voa._voaid);
                                                    [self catchDetails:voa];
                                                }else {
                                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                        kNetTest;
                                                    });
                                                    rightCharacter = NO;
                                                }
                                            }else {
//                                                [myDetail release];
                                                rightCharacter = YES;
                                            }//获取所选的cell的数据
                                            if (rightCharacter) {
                                                //                                NSLog(@"内容完整-%d",voa._voaid);
                                                //                                if ([VOADetail find:voa._voaid]) {
                                                PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
                                                //                                                    play.isExisitNet = isExisitNet;
                                                if(play.voa._voaid == voa._voaid)
                                                {
                                                    play.newFile = NO;
                                                }else
                                                {
                                                    play.newFile = YES;
                                                    play.voa = voa;
                                                }
                                                voa._isRead = @"1";//保证界面上显示已读
                                                if (!(play.contentMode == 1 && play.category == category)) {
                                                    play.flushList = YES;
                                                    play.contentMode = 1;
                                                    play.category = category;
                                                }
                                                
                                                [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
                                                
                                                /*
                                                NSObject<EPGLTransitionViewDelegate> *transition;
                                                
//                                                switch ([sender tag]) {
//                                                    case 0:
                                                        transition = [[[DemoTransition alloc] init] autorelease];
//                                                        break;
//                                                    case 1:
//                                                        transition = [[[Demo2Transition alloc] init] autorelease];
//                                                        break;
//                                                    case 2:
//                                                        transition = [[[Demo3Transition alloc] init] autorelease];
//                                                        break;
//                                                }
                                                
                                                EPGLTransitionView *glview = [[[EPGLTransitionView alloc] 
                                                                               initWithView:self.view
                                                                               delegate:transition] autorelease];
                                                [glview prepareTextureTo:play.view];
                                                // If you are using an "IN" animation for the "next" view set appropriate
                                                // clear color (ie no alpha)
                                                
                                                [glview setClearColorRed:0.1
                                                                   green:0.1
                                                                    blue:0.1
                                                                   alpha:0.1];
                                                [glview startTransition];
//                                                [intro setTextColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];
                                                */
                                                
                                                [self.navigationController pushViewController:play animated:NO];
                                                [HUD hide:YES];
                                                //                                }
                                            }else {
                                                notSelect = YES;
                                                [HUD hide:YES];
                                                UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kNewFive delegate:self cancelButtonTitle:kWordFour otherButtonTitles:nil ,nil];
                                                [addAlert show];
                                                [addAlert release];
                                                [voasTableView setUserInteractionEnabled:YES];
                                            }
//                                            [HUD hide:YES];
                                        });
                                    });
                                }
                                else
                                {
                                    notSelect = YES;
                                    [voasTableView setUserInteractionEnabled:YES];
                                }
                            }
                        }
                        
                    }
//                    }
                }
            }
        } else {
            [self doSwitch:titleBtn];
        }
        
    } else {
        //        [titleBtn setTitle:[classArray objectAtIndex:row] forState:UIControlStateNormal];
        category = row ;
        nowTitle = [classArray objectAtIndex:row];
        [self doSwitch:titleBtn];
        
        [self.voasArray removeAllObjects];
        self.lastId = [VOAView findLastId];
        pageNum = 1;
        //        addNum = 1;
        if (category == 0) {
            self.voasArray = [VOAView findNew:10*(pageNum-1) newVoas:self.voasArray];
        } else if (category<11) {
            self.voasArray = [VOAView findNewByCategory:10*(pageNum-1) category:category myArray:self.voasArray];
        } else {
            
        }
        pageNum++;
        addNum = 10;
        [self.voasTableView reloadData];
        [self.voasTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark -
#pragma mark UISearchBar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSString *searchWords =  [searchBar text];
    if (searchWords.length == 0) {
    }else
    {
        self.navigationController.navigationBarHidden = NO;
        
//        if (category == 10) {
//            NSMutableArray *allVoaArray = localArray;
//            NSMutableArray *contentsArray = nil;
//            contentsArray = [VOAView findFavSimilar:allVoaArray search:searchWords];
//            //                NSLog(@"count:%d", [contentsArray count]);
//            
//            if ([contentsArray count] == 0) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kColFour message:[NSString stringWithFormat:@"%@ %@ %@",kSearchThree,searchWords,kColThree] delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil, nil ];
//                [alert show];
//                [alert release];
//                [contentsArray release];
//            }else
//            {
//                search.text = @"";
//                SearchViewController *searchController = [SearchViewController alloc];
//                searchController.searchWords = searchWords;
//                searchController.contentsArray = contentsArray;
//                searchController.contentMode = 2;
//                [contentsArray release];
//                searchController.searchFlg = 11;
//                [self.navigationController pushViewController:searchController animated:YES];
//                [searchController release], searchController = nil;
//            }
//        } else {
            if (isiPhone) {
                [voasTableView setFrame:CGRectMake(0, 0, 320, kViewHeight)];
                
                [search setFrame:CGRectMake(0, 0, 320, 44)];
            }else {
                [voasTableView setFrame:CGRectMake(0, 0, 768, kViewHeight)];
                [search setFrame:CGRectMake(0, 0, 768, 44)];
            }
            
            [search setHidden:YES];
            search.text = @"";
            SearchViewController *searchController = [SearchViewController alloc];
            searchController.searchWords = searchWords;
            searchController.searchFlg = category;
            searchController.contentMode = 1;
            searchController.category = category;
            [self.navigationController pushViewController:searchController animated:YES];
            [searchController release], searchController = nil;
//        }
//        if (isiPhone) {
//            [voasTableView setFrame:CGRectMake(0, 0, 320, 372)];
//            [search setFrame:CGRectMake(0, 0, 320, 44)];
//        }else {
//            [voasTableView setFrame:CGRectMake(0, 0, 768, 372+544)];
//            [search setFrame:CGRectMake(0, 0, 768, 44)];
//        }
//        [search setHidden:YES];
//        HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
//        HUD.dimBackground = YES;
//        HUD.labelText = @"connecting!";
//        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{  
//            dispatch_async(dispatch_get_main_queue(), ^{  
//                searchBar.text = @"";
//                SearchViewController *searchController = [[SearchViewController alloc]init];
//                searchController.searchWords = searchWords;
//                searchController.searchFlg = 0;
//                searchController.contentMode = 1;
//                searchController.category  = [NSString stringWithFormat:@"0"];
//                [self.navigationController pushViewController:searchController animated:YES];
//                [searchController release], searchController = nil;
//                [HUD hide:YES];
//            });  
//        });
    }

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    self.navigationController.navigationBarHidden = NO;
    if (isiPhone) {
        [voasTableView setFrame:CGRectMake(0, 0, 320, kViewHeight)];
        [search setFrame:CGRectMake(0, 0, 320, 44)];
    }else {
        [voasTableView setFrame:CGRectMake(0, 0, 768, kViewHeight)];
        [search setFrame:CGRectMake(0, 0, 768, 44)];
    }
    [search setHidden:YES];
    search.text = @"";
    
}

#pragma mark - Http connect
- (void)catchIntroduction:(NSInteger)maxid pages:(NSInteger)pages pageNum:(NSInteger)pageNumOne{
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/titleApi.jsp?maxid=%d&type=iOS&format=xml&pages=%d&pageNum=%d&parentID=%d",maxid,pages,pageNumOne,category];
    NSOperationQueue *myQueue = [self sharedQueue];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setDelegate:self];
    [request setUsername:@"new"];
//    [request setDidStartSelector:@selector(requestMyStarted:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
    [myQueue addOperation:request];
}

//- (void)catchNetA
//{
//    NSString *url = @"http://www.baidu.com";
////    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//    request.delegate = self;
//    [request setUsername:@"catchnet"];
//    [request startAsynchronous];
//}

- (void)catchDetails:(VOAView *) voaid
{
//    NSLog(@"获取内容-%d",voaid._voaid);
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/textNewApi.jsp?voaid=%d&format=xml",voaid._voaid];
//    NSLog(@"catch:%d",voaid._voaid);
//    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"detail"];
    [request setTag:voaid._voaid];
    [request setTimeOutSeconds:10];
    [request startSynchronous];
//    [request release];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
//    isExisitNet = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    if ([request.username isEqualToString:@"detail"])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:kColFour message:kNewSix delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        [HUD hide:YES];
        [self.voasTableView setUserInteractionEnabled:YES];
    }
//    else {
////            if ([request.username isEqualToString:@"catchnet"]) {
//                //                NSLog(@"无网络");
//        
////            }
//    }
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
//        if ([request.username isEqualToString:@"new"]) {
    NSMutableArray *addArray = [[NSMutableArray alloc]init];
//    addArray = [VOAView findNew:10*(pageNum-1) newVoas:addArray];
    if (category == 0) {
        addArray = [VOAView findNew:10*(pageNum-1) newVoas:addArray];
    } else if (category<11) {
        addArray = [VOAView findNewByCategory:10*(pageNum-1) category:category myArray:addArray];
    } else {
        
    }

    
    pageNum ++; 
    addNum = 0;
    for (VOAView *voaOne in addArray) {
        [self.voasArray addObject:voaOne];
        addNum++;
    }
    [addArray release],addArray = nil;
    
    [self.voasTableView reloadData];
//        }
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    kNetEnable;
    if ([request.username isEqualToString:@"catchnet"]) {
        //        NSLog(@"有网络");
//        isExisitNet = YES;
        notSelect = YES;
        [voasTableView setUserInteractionEnabled:YES];
        return;
    }
    rightCharacter = NO;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"detail"]) {
        NSArray *items = [doc nodesForXPath:@"data/voatext" error:nil];
        if (items) {
            
            for (DDXMLElement *obj in items) {
                rightCharacter = YES;
                //                    NSLog(@"222");
                VOADetail *newVoaDetail = [[VOADetail alloc] init];
                newVoaDetail._voaid = request.tag ;
                //                    NSLog(@"id:%d",newVoaDetail._voaid);
                newVoaDetail._paraid = [[[obj elementForName:@"ParaId"] stringValue]integerValue];
                newVoaDetail._idIndex = [[[obj elementForName:@"IdIndex"] stringValue]integerValue];             
                newVoaDetail._startTiming = [[[obj elementForName:@"Timing"] stringValue] floatValue];
                newVoaDetail._endTiming = [[[obj elementForName:@"EndTiming"] stringValue] floatValue];
                newVoaDetail._sentence = [[[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"]stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
                newVoaDetail._imgWords = [[[obj elementForName:@"ImgWords"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoaDetail._imgPath = [[obj elementForName:@"ImgPath"] stringValue];
                newVoaDetail._sentence_cn = [[[[[obj elementForName:@"sentence_cn"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"] stringByReplacingOccurrencesOfString:@"<b>" withString:@""] stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
                if ([newVoaDetail insertNew]) {
                    //                        NSLog(@"插入%d成功",newVoaDetail._voaid);
                }
                [newVoaDetail release],newVoaDetail = nil;
                
            }
            
        } 
    }
    [doc release],doc = nil;
//    [request release], request = nil;
}

- (void)requestDone:(ASIHTTPRequest *)request
{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"new" ]) {
        /////解析
//        NSArray *items = [doc nodesForXPath:@"data" error:nil];
//        if (items) {
//            for (DDXMLElement *obj in items) {
//                NSInteger total = [[[obj elementForName:@"total"] stringValue] integerValue] ;
//                NSLog(@"total:%d",total);
//            }
//        }
        NSArray *items = [doc nodesForXPath:@"data/voatitle" error:nil];
        if (items) {
            BOOL flushList = NO;
            for (DDXMLElement *obj in items) {
                VOAView *newVoa = [[VOAView alloc] init];
                newVoa._voaid = [[[obj elementForName:@"voaid"] stringValue] integerValue] ;
                if (lastId<newVoa._voaid) {
                    lastId = newVoa._voaid;
                }
                newVoa._title = [[[obj elementForName:@"Title"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoa._descCn = [[[obj elementForName:@"DescCn"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoa._title_Cn = [[[obj elementForName:@"Title_cn"] stringValue] isEqualToString: @" null"] ? nil :[[obj elementForName:@"Title_cn"] stringValue];
                newVoa._category = [[obj elementForName:@"Category"] stringValue];
                newVoa._sound = [[obj elementForName:@"Sound"] stringValue];
                newVoa._url = [[obj elementForName:@"Url"] stringValue];
                newVoa._pic = [[obj elementForName:@"Pic"] stringValue];
                newVoa._creatTime = [[obj elementForName:@"CreatTime"] stringValue];
                newVoa._publishTime = [[[obj elementForName:@"PublishTime"] stringValue] isEqualToString:@" null"] ? nil :[[obj elementForName:@"PublishTime"] stringValue];
                newVoa._readCount = [[obj elementForName:@"ReadCount"] stringValue];
                newVoa._hotFlg = [[obj elementForName:@"HotFlg"] stringValue];
                newVoa._isRead = @"0";
                if ([VOAView isExist:newVoa._voaid] == NO) {
                    [newVoa insert];
//                    [self catchDetails:newVoa];
                    flushList = YES;
//                    NSLog(@"插入%d成功",newVoa._voaid);
                }else {
                    if (newVoa._readCount.integerValue > [[VOAView find:newVoa._voaid] _readCount].integerValue) {
                        [VOAView alterReadCount:newVoa._voaid count:newVoa._readCount.integerValue];
                    }
//                    NSLog(@"已有");
                }
                [newVoa release],newVoa = nil;
            }
            if (flushList) {
                PlayViewController *player = [PlayViewController sharedPlayer];
                //                if (player.playMode == 3) {
                player.flushList = YES;  
                //                }
//                flushList = NO;
            }
            NSMutableArray *addArray = [[NSMutableArray alloc]init];
            if (category == 0) {
                addArray = [VOAView findNew:10*(pageNum-1) newVoas:addArray];
            } else if (category<11) {
                addArray = [VOAView findNewByCategory:10*(pageNum-1) category:category myArray:addArray];
            } else {
                
            }
            //            addArray = [VOAView findNew:10*(pageNum-1) newVoas:addArray];
            pageNum ++;
            addNum = 0;
            for (VOAView *voaOne in addArray) {
                [self.voasArray addObject:voaOne];
                addNum++;
            }
            [addArray release],addArray = nil;
            [self.voasTableView reloadData];
        }
        else{
        }
        [self doneLoadingTableViewData];//下拉刷新获取数据后立即结束刷新
    }
    [doc release],doc = nil;
//    [request release], request = nil;
}

/**
 *  队列下载音频
 */
- (void)QueueDownloadMusic
{
    // NSLog(@"Queue 预备: %d",music._iid);
    NSOperationQueue *myQueue = [PlayViewController sharedQueue];
    //    int downLoadNum = [[NSUserDefaults standardUserDefaults]integerForKey:@"downLoadNum"];
    //    [myQueue setMaxConcurrentOperationCount:downLoadNum];
    [myQueue setMaxConcurrentOperationCount:1];
    
    for (int i=0; i<[downLoadList count]; i++) {
        VOAView *voa = [VOAView find:[[downLoadList objectAtIndex:i]intValue]];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", voa._sound]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [request setTag:voa._voaid];
        [request setDidStartSelector:@selector(requestSoundStarted:)];
        [request setDidFinishSelector:@selector(requestSoundDone:)];
        [request setDidFailSelector:@selector(requestSoundWentWrong:)];
        [myQueue addOperation:request]; //queue is an NSOperationQueue
        if (![VOADetail isExist:voa._voaid]) {
            [self catchDetails:voa];
        }
    }
    [self.voasTableView reloadData];
    
}

//下载按钮按下之后
- (void)QueueDownloadMusicBtn:(UIButton *)sender
{
    // NSLog(@"Queue 预备: %d",music._iid);
    if(kNetIsExist) {
        //数据库中加入下载
        [VOAView alterDownload:sender.tag];
        //数组中标记加入正在下载
        [downLoadList addObject:[NSNumber numberWithInt:sender.tag]];
        //修改button功能为等待
        [sender removeTarget:self action:@selector(QueueDownloadMusicBtn:) forControlEvents:UIControlEventTouchUpInside];
        [sender addTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        //修改button图片为等待
        if (isiPhone) {
            [sender setImage:[UIImage imageNamed:@"waiting.png"] forState:UIControlStateNormal];
            
        } else {
            [sender setImage:[UIImage imageNamed:@"waiting@2x.png"] forState:UIControlStateNormal];
            
        }
        
        //加入下载队列
        NSOperationQueue *myQueue = [PlayViewController sharedQueue];
        [myQueue setMaxConcurrentOperationCount:1];
        VOAView *voa=[VOAView find:sender.tag];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", voa._sound]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [request setTag:voa._voaid];
        [request setDidStartSelector:@selector(requestSoundStarted:)];
        [request setDidFinishSelector:@selector(requestSoundDone:)];
        [request setDidFailSelector:@selector(requestSoundWentWrong:)];
        [request setTimeOutSeconds:10];
        [myQueue addOperation:request]; //queue is an NSOperationQueue
        //    NSLog(@"status new:%d", request.);
        if (![VOADetail isExist:voa._voaid]) {
            [self catchDetails:voa];
        }
    
    }
    else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            kNetTest;
        });
    }

    
    
}

//取消下载
-(void)WaitingBtnPressed:(UIButton *)sender{
    //数据库中标记去掉
    [VOAView clearDownload:sender.tag];
    
    //数组中去掉
    for (int i =0; i<[downLoadList count]; i++) {
        if ([[downLoadList objectAtIndex:i]intValue]==sender.tag) {
            [downLoadList removeObjectAtIndex:i];
            break;
        }
    }
    //下载队列中去掉
    NSOperationQueue *myQueue = [PlayViewController sharedQueue];
    for (ASIHTTPRequest *request in [myQueue operations]) {
        if ([request isKindOfClass:[ASIHTTPRequest class]]&&request.tag==sender.tag) {
            [request clearDelegatesAndCancel];
            //            [request cancel];
        }
    }
    //修改按钮功能 图片
    [sender removeTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(QueueDownloadMusicBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [sender setImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];
        
    } else {
        [sender setImage:[UIImage imageNamed:@"dl@2x.png"] forState:UIControlStateNormal];
        
    }
    //如果是正在下载的，去掉进度条
    if (nowrequest.tag ==sender.tag) {
        
        VOAView *voa;
        NSInteger index = 0;
        for (int i= 0; i<[voasArray count]; i++) {
            voa = [voasArray objectAtIndex:i];
            if (voa._voaid==sender.tag) {
                index = i;
                break;
            }
        }
        VoaViewCell *cell = (VoaViewCell *)[self.voasTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [cell.progress setHidden:YES];
        [cell.progress release];
    }
}

- (void)requestSoundStarted:(ASIHTTPRequest *)request
{
    nowrequest = request;//把开始下载的赋值给全局变量
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //创建audio份目录在Documents文件夹下，not to back up
	NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
    NSString  *userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.mp3", request.tag]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:userPath]) {
        [request cancel];
    }
    VOAView *voa;
    NSInteger index = 0;
    for (int i= 0; i<[voasArray count]; i++) {
        voa = [voasArray objectAtIndex:i];
        if (voa._voaid==request.tag) {
            index = i;
            break;
        }
    }
    VoaViewCell *cell = (VoaViewCell *)[self.voasTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    if (isiPhone) {
        [cell.downloadBtn setImage:[UIImage imageNamed:@"stopdl.png"] forState:UIControlStateNormal];
        DACircularProgressView *test = [[DACircularProgressView alloc]initWithFrame:CGRectMake(278, 43, 37, 37)];
        cell.progress = test;
//        NSLog(@"progress:%d", [cell.progress retainCount]);
//        NSLog(@"test:%d",   test.retainCount);
        [cell.progress retain];
//        NSLog(@"progress:%d", [cell.progress retainCount]);
        [test release], test = nil;
    } else {
        [cell.downloadBtn setImage:[UIImage imageNamed:@"stopdl@2x.png"] forState:UIControlStateNormal];
        DACircularProgressView *test = [[DACircularProgressView alloc]initWithFrame:CGRectMake(666, 40, 71, 71)];
        cell.progress = test;
        [cell.progress retain];
        [test release], test = nil;
    }
    
    //    [cell.progress setTrackTintColor:[UIColor yellowColor]];
    request.downloadProgressDelegate = cell.progress;
    [request updateDownloadProgress];
    [cell insertSubview:cell.progress belowSubview:cell.downloadBtn];
//    [cell.progress release];
//    NSLog(@"progress release:%d", [cell.progress retainCount]);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        if (![VOADetail isExist:voa._voaid]) {
            NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/textApi.jsp?voaid=%d&format=xml",request.tag];
            //    NSLog(@"catch:%d",voaid._voaid);
            //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
            ASIHTTPRequest * detailRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
            detailRequest.delegate = self;
            [detailRequest setUsername:@"detailQueue"];
            [detailRequest setTag:request.tag];
            [detailRequest startAsynchronous];
        }
        
//    });
    
    
    //[MusicView alterDownload:request.tag];
    // NSLog(@"Queue 开始: %d",request.tag);
}

- (void)requestSoundDone:(ASIHTTPRequest *)request{
    kNetEnable;
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //创建audio份目录在Documents文件夹下，not to back up
	NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
	NSFileManager *fm = [NSFileManager defaultManager];
    NSString  *userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.mp3", request.tag]];
    NSData *responseData = [request responseData];
    //    NSLog(@"length New:%d", responseData.length);
    if(responseData.length < 2000){
        //数据库中标记去掉
        [VOAView clearDownload:request.tag];
        //数组中标记去掉
        for (int i =0; i<[downLoadList count]; i++) {
            if ([[downLoadList objectAtIndex:i]intValue]==request.tag) {
                [downLoadList removeObjectAtIndex:i];
                break;
            }
        }
        
        //    if (request.tag == music._iid) {
        //        [collectButton setHidden:NO];
        //        [downloadingFlg setHidden:YES];
        //    }
        VOAView *voa;
        NSInteger index = 0;
        for (int i= 0; i<[voasArray count]; i++) {
            voa = [voasArray objectAtIndex:i];
            if (voa._voaid==request.tag) {
                index = i;
                break;
            }
        }
        //去掉进度条
        VoaViewCell *cell = (VoaViewCell *)[self.voasTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [cell.progress setHidden:YES];
        [cell.progress release];
        UIAlertView *netAlert = [[UIAlertView alloc] initWithTitle:kPlayFive message:[NSString stringWithFormat:@"%@%@, %@",kNewEleven, kPlayFive, kNewTwelve] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [netAlert show];
        [netAlert release];
        //修改按钮功能 图片
        [cell.downloadBtn removeTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.downloadBtn addTarget:self action:@selector(QueueDownloadMusicBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (isiPhone) {
            [cell.downloadBtn setImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];
        } else {
            [cell.downloadBtn setImage:[UIImage imageNamed:@"dl@2x.png"] forState:UIControlStateNormal];
        }
    } else {
        if ([fm createFileAtPath:userPath contents:responseData attributes:nil]) {
        }
        //    if (request.tag == music._iid) {
        //        localFileExist = YES;
        //        downloaded = YES;
        //        [downloadFlg setHidden:NO];
        //        [collectButton setHidden:YES];
        //        [downloadingFlg setHidden:YES];
        //    }
        // MusicView *nowmusic=[MusicView find:request.tag];
        VOAView *voa;
        NSInteger index = 0;
        for (int i= 0; i<[voasArray count]; i++) {
            voa = [voasArray objectAtIndex:i];
            if (voa._voaid==request.tag) {
                index = i;
                break;
            }
        }
        
        VoaViewCell *cell = (VoaViewCell *)[self.voasTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [cell.downloadBtn setHidden:YES];
        [cell.progress setHidden:YES];
        [cell.downloadBtn release];
        [cell.progress release];
        [cell.aftImage setHidden:NO];
        //数据库中标记去掉
        [VOAView clearDownload:request.tag];
        
        //数组中去掉
        for (int i =0; i<[downLoadList count]; i++) {
            if ([[downLoadList objectAtIndex:i]intValue]==request.tag) {
                [downLoadList removeObjectAtIndex:i];
                break;
            }
        }
        [VOAFav alterCollect:request.tag];
//        [fm release];
        //[MusicView clearDownload:request.tag];
    }
    //    NSLog(@"requestFinished。大小：%d", [responseData length]);
	
}

- (void)requestSoundWentWrong:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    //数据库中标记去掉
    [VOAView clearDownload:request.tag];
    //数组中标记去掉
    for (int i =0; i<[downLoadList count]; i++) {
        if ([[downLoadList objectAtIndex:i]intValue]==request.tag) {
            [downLoadList removeObjectAtIndex:i];
            break;
        }
    }
    
    //    if (request.tag == music._iid) {
    //        [collectButton setHidden:NO];
    //        [downloadingFlg setHidden:YES];
    //    }
    VOAView *voa;
    NSInteger index = 0;
    for (int i= 0; i<[voasArray count]; i++) {
        voa = [voasArray objectAtIndex:i];
        if (voa._voaid==request.tag) {
            index = i;
            break;
        }
    }
    //去掉进度条
    VoaViewCell *cell = (VoaViewCell *)[self.voasTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell.progress setHidden:YES];
    [cell.progress release];
    UIAlertView *netAlert = [[UIAlertView alloc] initWithTitle:kPlayFive message:[NSString stringWithFormat:@"%@%@", kNewEleven, kPlayFive] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [netAlert show];
    [netAlert release];
    //修改按钮功能 图片
    [cell.downloadBtn removeTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.downloadBtn addTarget:self action:@selector(QueueDownloadMusicBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [cell.downloadBtn setImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];
    } else {
        [cell.downloadBtn setImage:[UIImage imageNamed:@"dl@2x.png"] forState:UIControlStateNormal];
    }
    
    
}

-(BOOL) isExistenceNetwork:(NSInteger)choose
{
    UIAlertView *myalert = nil;
    
    switch (choose) {
        case 0:
            
            break;
        case 1:
            if (kNetIsExist) {
                
            }else {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    kNetTest;
                });
                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kRegNine delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
                [myalert show];
                [myalert release];
            }
            break;
        default:
            break;
    }    
	return kNetIsExist;
}

//-(BOOL) isExistenceNetwork:(NSInteger)choose
//{
//	BOOL isExistenceNetwork;
//	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
//    switch ([r currentReachabilityStatus]) {
//        case NotReachable:
//			isExistenceNetwork=FALSE;
//            break;
//        case ReachableViaWWAN:
//			isExistenceNetwork=TRUE;
//            break;
//        case ReachableViaWiFi:
//			isExistenceNetwork=TRUE;     
//            break;
//    }
//	if (!isExistenceNetwork) {
//        UIAlertView *myalert = nil;
//        switch (choose) {
//            case 0:
//                
//                break;
//            case 1:
//                myalert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您还没有网络连接,请收听本地中新闻" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//                [myalert show];
//                [myalert release];
//                break;
//            default:
//                break;
//        }
//	}
//	return isExistenceNetwork;
//}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods
/**
 *  MBProgressHUDDelegate需要实现的函数
 */
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

#pragma mark - Touch
/**
 *  点击屏幕响应函数
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!search.isHidden) {
        self.navigationController.navigationBarHidden = NO;
        if (isiPhone) {
            [voasTableView setFrame:CGRectMake(0, 0, 320, kViewHeight)];
            [search setFrame:CGRectMake(0, 0, 320, 44)];
        }else {
            [voasTableView setFrame:CGRectMake(0, 0, 768, kViewHeight)];
            [search setFrame:CGRectMake(0, 0, 768, 44)];
        }
        [search setHidden:YES];
        search.text = @"";
    }
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:// 继续下载 取出存在数组中
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                kNetTest;
            });
            [self QueueDownloadMusic];
            break;
        case 1://下次再说 数据库不动，不保存在数组中
            [downLoadList removeAllObjects];
            break;
        case 2://拒绝 数据库中删除
            [VOAView clearAllDownload];
            [downLoadList removeAllObjects];
            break;
        default:
            break;
    }
}

@end
