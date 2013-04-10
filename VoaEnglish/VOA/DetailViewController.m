//
//  DetailViewController.m
//  VOA
//
//  Created by song zhao on 12-2-3.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"

@implementation DetailViewController
@synthesize voasArray;
@synthesize voasArrayNet;
@synthesize category;
@synthesize voasTableView;
@synthesize nowSection;
@synthesize datesArray;
@synthesize search;
@synthesize HUD;
@synthesize nowRow;
@synthesize pageNum;
@synthesize addNum;
@synthesize lastId;
@synthesize rightCharacter;
//@synthesize isExisitNet;
@synthesize reloading = _reloading;
@synthesize isiPhone ;
@synthesize refreshHeaderView = _refreshHeaderView;
@synthesize sharedSingleQueue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - My method
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

- (void)doSearch
{
    self.navigationController.navigationBarHidden = YES;
    if (isiPhone) {
        [search setFrame:CGRectMake(0, 0, 320, 44)];
        [voasTableView setFrame:CGRectMake(0, 44, 320, 372)];
    }else {
        [search setFrame:CGRectMake(0, 0, 768, 44)];
        [voasTableView setFrame:CGRectMake(0, 44, 768, 916)];
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

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated {
    kNetTest;
//    [self catchNetA];
    int cate= category;
    switch (cate) {
        case 1:
            [self.navigationItem setTitle:kClassTwo];
            break;
        case 2:
            [self.navigationItem setTitle:kClassThree];
            break;
        case 3:
            [self.navigationItem setTitle:kClassFour];
            break;
        case 4:
            [self.navigationItem setTitle:kClassFive];
            break;
        case 5:
            [self.navigationItem setTitle:kClassSix];
            break;
        case 6:
            [self.navigationItem setTitle:kClassSeven];
            break;
        case 7:
            [self.navigationItem setTitle:kClassEight];
            break;
        case 8:
            [self.navigationItem setTitle:kClassNine];
            break;
        case 9:
            [self.navigationItem setTitle:kClassTen];
            break;
        default:
            break;
    }
    search.showsCancelButton = YES;
    [search setPlaceholder:kClassEleven];
    [self.voasTableView reloadData];
    [voasTableView setUserInteractionEnabled:YES];
    if (isiPhone) {
        [voasTableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        [search setFrame:CGRectMake(0, 0, 320, 44)];
    }else {
        [voasTableView setFrame:CGRectMake(0, 0, 768, self.view.frame.size.height)];
        [search setFrame:CGRectMake(0, 0, 768, 44)];
    }
    
    self.navigationController.navigationBarHidden = NO;
	[search setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    isExisitNet = NO;
    
    isiPhone = ![Constants isPad];
    
//    voasTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
//    [voasTableView setBackgroundColor:[UIColor clearColor]];
//    [self.view setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:voasTableView];
    
    voasArray = [[NSMutableArray alloc]init];
    search = [[UISearchBar alloc] init];
    search.delegate = self;
    search.backgroundImage = [UIImage imageNamed:@"title.png"];
    search.backgroundColor = [UIColor clearColor];
    [search setTintColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];
    [self.view addSubview:search];
    [search release];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(doSearch)];
	self.navigationItem.rightBarButtonItem = editButton;
    [editButton release], editButton = nil;
    search.showsCancelButton = YES;
    self.title = kClassOne;
    HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
    HUD.dimBackground = YES;
    HUD.labelText = kNewFour;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{  
        dispatch_async(dispatch_get_main_queue(), ^{  
            self.lastId = [VOAView findLastId];
//            isExisitNet = [self isExistenceNetwork:0];
            addNum = 1;
            pageNum = 1;
//            if (isExisitNet) {
//                [self catchIntroduction:0 pages:pageNum pageNum:10 ];
//            }
            self.voasArray = [VOAView findNewByCategory:10*(pageNum-1) category:self.category myArray:self.voasArray]; 
            pageNum++;
            [self.voasTableView reloadData];
            [HUD hide:YES];
        });  
    }); 
    if(_refreshHeaderView ==nil){
        EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.voasTableView.bounds.size.height, self.view.frame.size.width, self.voasTableView.bounds.size.height)];
        view.delegate = self;
        [self.voasTableView addSubview:view];
        _refreshHeaderView = view;
        [view release], view  = nil;
    }
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.voasTableView = nil;
}

- (void)dealloc {
//    NSLog(@"释放了");
    [self.voasTableView release], voasTableView = nil;
    [self.voasArray release], voasArray = nil;
    [self.voasArrayNet release], voasArrayNet = nil;
//    [self.category release], category = nil;
    [self.datesArray release], datesArray = nil;
    [self.sharedSingleQueue release],sharedSingleQueue = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
-(void)reloadTableViewDataSource{
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    //    NSLog(@"开始刷新");
    kNetTest;
    if (kNetIsExist) {

        [self catchIntroduction:0 pages:1 pageNum:10 ];
        
        
//        [self catchIntroduction:0 pages:1 pageNum:10 ];
//        pageNum = 1;
//        NSArray *voas = [[NSArray alloc] init];
//        //    NSLog(@"获取生词到:%d",nowUserId);
//        voas = [VOAView findNewByCategory:10*(pageNum-1) category:category myArray:self.voasArray];
//        [voasArray removeAllObjects];
//        for (id fav in voas) {
//            [voasArray addObject:fav];
//        }
//        pageNum++;
//        addNum = 10;
//        [voas release], voas = nil;
    }
    _reloading =YES;
}
-(void)doneLoadingTableViewData{
    //  model should call this when its done loading
    _reloading =NO;
    //    NSLog(@"结束刷新");
    kNetTest;
    if (kNetIsExist) {
        [voasArray removeAllObjects];
        pageNum = 1;
        self.voasArray = [VOAView findNewByCategory:10*(pageNum-1) category:category myArray:self.voasArray];
        pageNum++;
        addNum = 10;
        [self.voasTableView reloadData];
    }
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.voasTableView];
}
//-(void)reloadTableViewDataSource{
//    
//    //  should be calling your tableviews data source model to reload
//    //  put here just for demo
////    NSLog(@"开始刷新");
//    [voasArray removeAllObjects];
////    if (isExisitNet) {
//        [self catchIntroduction:0 pages:1 pageNum:10 ];
////    }
//    pageNum = 1;
//    self.voasArray = [VOAView findNew:10*(pageNum-1) newVoas:self.voasArray];
//    pageNum++;
//    addNum = 10;
//    //            NSLog(@"lastId:%d",lastId);
////    [self.voasTableView reloadData];
//    _reloading =YES;
//}
//-(void)doneLoadingTableViewData{
//    //  model should call this when its done loading
//    _reloading =NO;
////    NSLog(@"结束刷新");
//    [self.voasTableView reloadData];
//    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.voasTableView];
//}

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
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:4.0];
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
    return [self.voasArray count]+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    VOAView *voa = nil;
    static NSString *FirstLevelCell= @"DetailCell";
    
    
//    NSLog(@"-----cell id:%d",voa._voaid);
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
        if ([indexPath row]<[voasArray count]) {
            voa = [self.voasArray objectAtIndex:row];
//            NSLog(@"count:%d",[voasArray count]);
            cell.myTitle.text = voa._title;
            cell.myDate.text = voa._creatTime;
            //--------->设置内容换行
            [cell.myTitle setLineBreakMode:UILineBreakModeClip];
            //--------->设置最大行数
            [cell.myTitle setNumberOfLines:3];
            NSURL *url = [NSURL URLWithString: voa._pic];
            [cell.myImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//            NSLog(@"readmy:%@",voa._isRead);
            if (voa._isRead.integerValue == 1) {
            }else
            {
                [cell.myTitle setTextColor:[UIColor redColor]];
                [cell.myDate setTextColor:[UIColor redColor]];
                [cell.readImg setImage:[UIImage imageNamed:@"detail-ipad.png"]];
            }
            if (voa._hotFlg.integerValue == 1) {
                [cell.hotImg setHidden:NO];
//                NSLog(@"hot:1");
            }
            return cell;
        }else
        {
            if ([indexPath row]==[voasArray count]) {
//                NSLog(@"22");
                static NSString *SecondLevelCell= @"DetailCellOne";
                UITableViewCell *cellTwo = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:SecondLevelCell];
                if (!cellTwo) {
                    if (isiPhone) {
                        cellTwo = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SecondLevelCell] autorelease];
                    }else {
                        cellTwo = (VoaViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"VoaImageCell-iPad" 
                                                                               owner:self 
                                                                             options:nil] objectAtIndex:0];
                    }
                }
                [cellTwo setSelectionStyle:UITableViewCellSelectionStyleNone];
                if (row>lastId||addNum == 0) {
                    [cellTwo setHidden:YES];
                } 
                else
                {
                    if (isiPhone) {
                        [cellTwo.imageView setImage:[UIImage imageNamed:@"load.png"]];
                    } 
                }
                return cellTwo;
            }else
            {
                if ([indexPath row]==[voasArray count]+1) {
//                    NSLog(@"enter");
                    static NSString *ThirdLevelCell= @"DetailCellTwo";
                    UITableViewCell *cellThree = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:ThirdLevelCell];
                    if (!cellThree) {
                        cellThree = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ThirdLevelCell] autorelease];
                    }
                    [cellThree setSelectionStyle:UITableViewCellSelectionStyleNone];
                    [cellThree setHidden:YES];
                    if (row>lastId||addNum == 0) {
                        
                    } else
                    {
                        kNetTest;
                        if (kNetIsExist) {
//                            NSLog(@"lastId:%d",lastId);
//                            NSLog(@"重新加载");
//                            NSLog(@"插入数据！！！！！！");
                            [self catchIntroduction:0 pages:pageNum pageNum:10];
                        }else {
                            NSMutableArray *addArray = [[NSMutableArray alloc]init]; 
                            addArray = [VOAView findNewByCategory:10*(pageNum-1) category:self.category myArray:addArray];
                            pageNum ++; 
                            addNum = 0;
                            for (VOAView *voaOne in addArray) {
                                [self.voasArray addObject:voaOne];
                                addNum++;
                            }
                            [addArray release],addArray = nil;
                            [self.voasTableView reloadData];
                        }
//                        NSLog(@"不会吧");
                        
                        
                    }
                    return cellThree;        
                }
            }
        }
    return nil;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([indexPath row]<[voasArray count])?(isiPhone?80.0f:160.0f):([indexPath row]==[voasArray count]?(isiPhone?28.0f:48.0f):1.0f);
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (search.isFirstResponder) {
        [self.search resignFirstResponder];
        NSString *searchWords =  [self.search text];
        if (searchWords.length == 0) {
        }else
        {
            self.navigationController.navigationBarHidden = NO;
            if (isiPhone) {
                [voasTableView setFrame:CGRectMake(0, 0, 320, 372)];
                [search setFrame:CGRectMake(0, 0, 320, 44)];
            }else {
                [voasTableView setFrame:CGRectMake(0, 0, 768, 372+544)];
                [search setFrame:CGRectMake(0, 0, 768, 44)];
            }
            
            [search setHidden:YES];
            
            search.text = @"";
            SearchViewController *searchController = [SearchViewController alloc];
            searchController.searchWords = searchWords;
            searchController.searchFlg = category;
            searchController.category = category;
            searchController.contentMode = 1;
            [self.navigationController pushViewController:searchController animated:YES];
            [searchController release], searchController = nil;
        }
        
    }else{
        if (!search.isHidden) {
            self.navigationController.navigationBarHidden = NO;
            if (isiPhone) {
                [voasTableView setFrame:CGRectMake(0, 0, 320, 372)];
                [search setFrame:CGRectMake(0, 0, 320, 44)];
            }else {
                [voasTableView setFrame:CGRectMake(0, 0, 768, 372+544)];
                [search setFrame:CGRectMake(0, 0, 768, 44)];
            }
            [search setHidden:YES];
            search.text = @"";
        }else{
            if ([indexPath row]<[voasArray count]) {
                [voasTableView setUserInteractionEnabled:NO];
                NSUInteger row = [indexPath row];
                VOAView *voa = nil;
                voa = [self.voasArray objectAtIndex:row];
                if ([voa._pic isEqualToString:@""] || [voa._pic isEqualToString:@"null"] || voa._pic == nil) {
                    [VOAView deleteByVoaid:voa._voaid];
                    [self.voasTableView reloadData];
                } else {
                    if ([VOADetail isExist:voa._voaid] || [self isExistenceNetwork:1]) {
                        HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
                        HUD.dimBackground = YES;
                        HUD.labelText = @"connecting!";    
                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{  
                            
                            dispatch_async(dispatch_get_main_queue(), ^{  
                                VOADetail *myDetail = [VOADetail find:voa._voaid];
                                if (!myDetail) {
                                    kNetTest;
                                    if (kNetIsExist) {
                                        [VOADetail deleteByVoaid: voa._voaid];
                                        [self catchDetails:voa._voaid];
                                    }else {
                                        rightCharacter = NO;
                                    }
                                }else {
                                    [myDetail release];
                                    rightCharacter = YES;
                                }//获取所选的cell的数据
                                if (rightCharacter) {
                                    //                                if ([VOADetail find:voa._voaid]) {
                                    //                                    NSLog(@"id:%d",voa._voaid);
                                    PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
//                                    play.isExisitNet = isExisitNet;
                                    if(play.voa._voaid == voa._voaid)
                                    {
                                        play.newFile = NO;
                                    }else
                                    {
                                        play.newFile = YES;
                                        play.voa = voa;
                                    }
                                    voa._isRead = @"1";//保证界面上显示已读
                                    play.category = category;
                                    play.contentMode = 1;
                                    [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
                                    [self.navigationController pushViewController:play animated:NO]; 
                                    [HUD hide:YES];
                                    //                                }
                                }else {
                                    [HUD hide:YES];
                                    UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kNewFive delegate:self cancelButtonTitle:kWordFour otherButtonTitles:nil ,nil];
                                    [addAlert show];
                                    [addAlert release];
                                    [voasTableView setUserInteractionEnabled:YES];
                                }
                                //                            if (![VOADetail find:voa._voaid]) {
                                //                                [self catchDetails:voa._voaid];
                                //                            }//获取所选的cell的数据
                                //                            if ([VOADetail find:voa._voaid]) {
                                //                                PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
                                //                                if(play.voa._voaid == voa._voaid)
                                //                                {
                                //                                    play.newFile = NO;
                                //                                }else
                                //                                {
                                //                                    play.newFile = YES;
                                //                                    play.voa = voa;
                                //                                }
                                //                                voa._isRead = @"1";//保证界面上显示已读
                                //                                [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
                                //                                [self.navigationController pushViewController:play animated:NO]; 
                                //                                [HUD hide:YES];
                                //                            }
                                
                            });  
                        });
                    }
                    else
                    {
                        [voasTableView setUserInteractionEnabled:YES];
                    }
                }
            }
        }
    }
}


#pragma mark -
#pragma mark UISearchBar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSString *searchWords =  [searchBar text];
    if (searchWords.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kColFour message:[NSString stringWithFormat:kColFive,searchWords] delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil, nil ];
        [alert show];
        [alert release], alert = nil;
    }else
    {
        self.navigationController.navigationBarHidden = NO;
        if (isiPhone) {
            [voasTableView setFrame:CGRectMake(0, 0, 320, 372)];
            [search setFrame:CGRectMake(0, 0, 320, 44)];
        }else {
            [voasTableView setFrame:CGRectMake(0, 0, 768, 372+544)];
            [search setFrame:CGRectMake(0, 0, 768, 44)];
        }
        [search setHidden:YES];
        HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
        HUD.dimBackground = YES;
        HUD.labelText = @"connecting!";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{  
            
            dispatch_async(dispatch_get_main_queue(), ^{  
                searchBar.text = @"";
                SearchViewController *searchController = [SearchViewController alloc];
                searchController.searchWords = searchWords;
                searchController.searchFlg = category;
                searchController.category = category;
                searchController.contentMode = 1;
                [self.navigationController pushViewController:searchController animated:YES];
                [searchController release], searchController = nil;
                [HUD hide:YES]; 
            });  
        }); 
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    self.navigationController.navigationBarHidden = NO;
    if (isiPhone) {
        [voasTableView setFrame:CGRectMake(0, 0, 320, 372)];
        [search setFrame:CGRectMake(0, 0, 320, 44)];
    }else {
        [voasTableView setFrame:CGRectMake(0, 0, 768, 372+544)];
        [search setFrame:CGRectMake(0, 0, 768, 44)];
    }
    [search setHidden:YES];
    search.text = @"";
}

#pragma mark - Http connect
-(BOOL) isExistenceNetwork:(NSInteger)choose
{
    kNetTest;
    UIAlertView *myalert = nil;
    switch (choose) {
        case 0:
            
            break;
        case 1:
            if (kNetIsExist) {
                
            }else {
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

- (void)catchDetails:(NSInteger) voaid
{
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/textApi.jsp?voaid=%d&format=xml",voaid];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"detail"];
    [request setTag:voaid];
    [request startSynchronous];
}

//- (void)catchNetA
//{
//    NSString *url = @"http://www.baidu.com";
//    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//    request.delegate = self;
//    [request setUsername:@"catchnet"];
//    [request startAsynchronous];
//}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    if ([request.username isEqualToString:@"detail"])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:kSearchEleven message:[NSString stringWithFormat:@"%@,%@",kSearchEleven,kNewSix] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else {
        //            if ([request.username isEqualToString:@"catchnet"]) {
        //                NSLog(@"无网络");
//        isExisitNet = NO;
        //            }
    }
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    //        if ([request.username isEqualToString:@"new"]) {
    NSMutableArray *addArray = [[NSMutableArray alloc]init];
    addArray = [VOAView findNewByCategory:10*(pageNum-1) category:self.category myArray:addArray];
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
    if ([request.username isEqualToString:@"catchnet"]) {
        //        NSLog(@"有网络");
//        isExisitNet = YES;
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
                VOADetail *newVoaDetail = [[VOADetail alloc] init];
                newVoaDetail._voaid = request.tag ;
                newVoaDetail._paraid = [[[obj elementForName:@"ParaId"] stringValue]integerValue];
                newVoaDetail._idIndex = [[[obj elementForName:@"IdIndex"] stringValue]integerValue];             
                newVoaDetail._timing = [[[obj elementForName:@"Timing"] stringValue]integerValue];
                newVoaDetail._sentence = [[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoaDetail._imgWords = [[[obj elementForName:@"ImgWords"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoaDetail._imgPath = [[obj elementForName:@"ImgPath"] stringValue];
                newVoaDetail._sentence_cn = [[[obj elementForName:@"sentence_cn"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                if ([newVoaDetail insert]) {
                    //                        NSLog(@"插入%d成功",newVoaDetail._voaid);
                }
                [newVoaDetail release], newVoaDetail = nil;
            }
        } 
        //            else {
        //                [VOAView deleteByVoaid:request.tag];
        //            }
    }    
    [doc release],doc = nil;
    //    [request release], request = nil;
}

- (void)requestDone:(ASIHTTPRequest *)request
{
    //    if ([request.username isEqualToString:@"catchnet"]) {
    ////        NSLog(@"有网络");
    //        isExisitNet = YES;
    ////        [request release],request = nil;
    //        return;
    //    }
    //    NSLog(@"1111");
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"new" ]) {
        
        /////解析
        NSArray *items = [doc nodesForXPath:@"data" error:nil];
        //        if (items) {
        //            for (DDXMLElement *obj in items) {
        //                NSInteger total = [[[obj elementForName:@"total"] stringValue] integerValue] ;
        //                NSLog(@"total:%d",total);
        //            }
        //        }
        items = [doc nodesForXPath:@"data/voatitle" error:nil];
        if (items) {
            BOOL flushList = NO;
            for (DDXMLElement *obj in items) {
                VOAView *newVoa = [[VOAView alloc] init];
                newVoa._voaid = [[[obj elementForName:@"voaid"] stringValue] integerValue] ;
                newVoa._title = [[obj elementForName:@"Title"] stringValue];
                newVoa._descCn = [[[obj elementForName:@"DescCn"] stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoa._title_Cn = [[[obj elementForName:@"Title_cn"] stringValue] isEqualToString: @" null"] ? nil :[[obj elementForName:@"Title_cn"] stringValue];
                newVoa._category = [[obj elementForName:@"Category"] stringValue];
                newVoa._sound = [[obj elementForName:@"Sound"] stringValue];
                newVoa._url = [[obj elementForName:@"Url"] stringValue];
                newVoa._pic = [[obj elementForName:@"Pic"] stringValue];
                newVoa._creatTime = [[obj elementForName:@"CreatTime"] stringValue];
                newVoa._publishTime = [[obj elementForName:@"PublishTime"] stringValue] == @" null" ? nil :[[obj elementForName:@"Title_cn"] stringValue];
                newVoa._readCount = [[obj elementForName:@"ReadCount"] stringValue];
                newVoa._hotFlg = [[obj elementForName:@"HotFlg"] stringValue];
                newVoa._isRead = @"0";
                if ([VOAView isExist:newVoa._voaid] == NO) {
                    [newVoa insert];
//                    [self catchDetails:newVoa._voaid];
                    flushList = YES;
                    //                    NSLog(@"插入%d成功",newVoa._voaid);
                }
                [voasArrayNet addObject:newVoa];
                [newVoa release],newVoa = nil;
                
            }
            if (flushList) {
                PlayViewController *player = [PlayViewController sharedPlayer];
                //                if (player.playMode == 3) {
                player.flushList = YES;  
                //                }
                flushList = NO;
            }
            NSMutableArray *addArray = [[NSMutableArray alloc]init];
            addArray = [VOAView findNewByCategory:10*(pageNum-1) category:self.category myArray:addArray];
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
    }
    [doc release],doc = nil;
    //    [request release], request = nil;
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!search.isHidden) {
        self.navigationController.navigationBarHidden = NO;
        if (isiPhone) {
            [voasTableView setFrame:CGRectMake(0, 0, 320, 372)];
            [search setFrame:CGRectMake(0, 0, 320, 44)];
        }else {
            [voasTableView setFrame:CGRectMake(0, 0, 768, 372+544)];
            [search setFrame:CGRectMake(0, 0, 768, 44)];
        }
        [search setHidden:YES];
        search.text = @"";
    }
}

@end
