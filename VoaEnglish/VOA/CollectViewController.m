//
//  CollectViewController.m
//  VOA
//
//  Created by song zhao on 12-2-2.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "CollectViewController.h"
#import "database.h"
#import "UIImageView+WebCache.h"
@implementation CollectViewController

@synthesize voasTableView;
@synthesize favArray;
@synthesize search;
@synthesize HUD;
@synthesize isiPhone;
@synthesize isSentence;
@synthesize senArray;
@synthesize nowUserId;
@synthesize segmentedControl;
@synthesize rightCharacter;
@synthesize notSelect;
@synthesize sharedSingleQueue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - My action
//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}

-(UIButton*)getSearchBarCancelButton{
    
    UIButton* btn=nil;
    
    for(UIView* v in search.subviews) {
        
        if ([v isKindOfClass:UIButton.class]) {
            
            btn=(UIButton*)v;
            
            break;
            
        }
        
    }
    
    return btn;
    
}

- (void)doSearch
{
    self.navigationController.navigationBarHidden = YES;
    
    if (isiPhone) {
        [search setFrame:CGRectMake(0, 0, 320, 44)];
        
        [voasTableView setFrame:CGRectMake(0, 44, 320, kViewHeight)];
    }else {
        [search setFrame:CGRectMake(0, 0, 768, 44)];
        
        [voasTableView setFrame:CGRectMake(0, 44, 768, kViewHeight)];
    }
    
    
    [search setHidden:NO];
    
    UIButton* btn=[self getSearchBarCancelButton];
    
    if (btn!=nil) {
        
        [btn setMultipleTouchEnabled:YES];
        
    } 
}

- (void)doSeg:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        isSentence = NO;
//        NSLog(@"1");
        UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(doSearch)];
        
        self.navigationItem.leftBarButtonItem=nil;
        self.navigationItem.leftBarButtonItem = searchButton;
        
        [searchButton release], searchButton = nil;

//        self.title = kColTwo;
        NSArray *favViews = [VOAFav findCollect];
        
        [favArray removeAllObjects];
        
        for (id fav in favViews) {
            [favArray addObject:fav];
        }
//        [favViews release], favViews = nil;
        [segmentedControl setSelectedSegmentIndex:0];
        [self.voasTableView reloadData];
    }else
    {
        isSentence = YES;
        UIBarButtonItem *synButton = [[UIBarButtonItem alloc] initWithTitle:kWordNine style:UIBarButtonItemStylePlain target:self action:@selector(doSyn:)];
        self.navigationItem.leftBarButtonItem=nil;
        self.navigationItem.leftBarButtonItem = synButton;
        [synButton release], synButton = nil;
        
        NSArray *senViews = [VOASentence findSentences:nowUserId];
        [senArray removeAllObjects];
        for (id sen in senViews) {
            [senArray addObject:sen];
        }
        [self.voasTableView reloadData];
        [sender setSelectedSegmentIndex:1];
//        [senViews release],senViews =nil;
    }
}

- (void)doSyn:(UIButton *) synBtn {
    if (nowUserId>0) {
        NSArray *senViews = [VOASentence findAlterSentences:nowUserId];
        for (VOASentence *sen in senViews) {
            [self catchSenAsFlg:sen mode:(sen.collected == 1? @"insert": @"del")];
        }
        [self catchSensByPageNumber:1];
    }else
    {
        LogController *myLog = [[LogController alloc]init];
        [myLog setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:myLog animated:YES];
        [myLog release], myLog = nil;
    }
}

#pragma mark - View lifecycle
- (void) viewWillAppear:(BOOL)animated {
    notSelect = YES;
    nowUserId = 0;
    nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    if (isSentence) {
        
        NSArray *senViews = [VOASentence findSentences:nowUserId];
        [senArray removeAllObjects];
        for (id sen in senViews){
            [senArray addObject:sen];
        }
//        [senViews release], senViews = nil;
    
    }else{
        NSArray *favViews = [VOAFav findCollect];
        
        [favArray removeAllObjects];
        
        for (id fav in favViews) {
            [favArray addObject:fav];
        }
//        [favViews release], favViews = nil;
    }
    [voasTableView reloadData];
    search.showsCancelButton = YES;
    
    [search setPlaceholder:kColOne];
    
    self.navigationController.navigationBarHidden = NO;
    
    [voasTableView setUserInteractionEnabled:YES];
    
    if (isiPhone) {
        [voasTableView setFrame:CGRectMake(0, 0, 320, kViewHeight)];
        [search setFrame:CGRectMake(0, 0, 320, 44)];
    }else {
        [voasTableView setFrame:CGRectMake(0, 0, 768, kViewHeight)];
        [search setFrame:CGRectMake(0, 0, 768, 44)];
    }
	[search setHidden:YES];
	[super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    isSentence = NO;
    
    isiPhone = ![Constants isPad];
    
    search = [[UISearchBar alloc] init];
    
    search.delegate = self;
    
    search.backgroundImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"title" ofType:@"png"]];
    
    search.backgroundColor = [UIColor clearColor];
    
    [search setTintColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];

    [self.view addSubview:search];
    
    [search release];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(doSearch)];
    
	self.navigationItem.leftBarButtonItem = searchButton;
    
    [searchButton release], searchButton = nil;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.title = kColTwo;
    
    favArray = [[NSMutableArray alloc] init];
    senArray = [[NSMutableArray alloc] init];
//    NSArray *senViews = [VOASentence findSentences];
//    for(id sen in senViews){
//        [senArray addObject: sen];
//    }
//    [self.voasTableView reloadData];
//    [senViews release], senViews = nil;
    voasTableView.delegate = self;
    
	voasTableView.dataSource = self;
	
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:kSearchTwo style:UIBarButtonItemStylePlain target:self action:@selector(doEdit)];
    
	self.navigationItem.rightBarButtonItem = editButton;
    
    [editButton release], editButton = nil;
    
//	NSLog(@"storeArray: %@",favArray);
    
    segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f) ];
    [segmentedControl insertSegmentWithTitle:kColSix atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:kColSeven atIndex:1 animated:YES];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.multipleTouchEnabled=NO;
    [segmentedControl addTarget:self action:@selector(doSeg:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setSelectedSegmentIndex:0];
    //    UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    //    [segmentedControl release], segmentedControl = nil;
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl release];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
- (void)viewDidUnload
{
    self.voasTableView = nil;
    [segmentedControl release], segmentedControl = nil;
    [favArray release], favArray = nil;
    [senArray release], senArray = nil;
    [search release], search = nil;
    [super viewDidUnload];
    
}*/

- (void)dealloc
{
    voasTableView.delegate = nil;
    voasTableView.dataSource = nil;
    [voasTableView release];
    [segmentedControl release];
    [favArray release];
    [senArray release];
    search.delegate = nil;
    [search release];
    //    [favArray release];
    //    [search release];
    //    [HUD release];
    //    [self.voasArray release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) doEdit{
    
	[voasTableView setEditing:!voasTableView.editing animated:YES];
    
	if(voasTableView.editing)
        
		self.navigationItem.rightBarButtonItem.title = kSearchOne;

	else
        
		self.navigationItem.rightBarButtonItem.title = kSearchTwo;
}



#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    if (isSentence) {
        return [senArray count];
    }else{
        return [favArray count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!isSentence) {
        
    static NSString *FirstLevelCell= @"CollectCell";
    
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
    NSUInteger row = [indexPath row];
    
    VOAFav *fav = [favArray objectAtIndex:row];
    
    VOAView *voa = [VOAView find:fav._voaid];

    cell.myTitle.text = voa._title;
    
    cell.myDate.text = voa._creatTime;
    
    cell.collectDate.text = fav._date;
        
    cell.readCount.text = [NSString stringWithFormat:@"%i人已听", voa._readCount.integerValue+11321];
    
    //--------->设置内容换行
    [cell.myTitle setLineBreakMode:UILineBreakModeClip];
    
    //--------->设置最大行数
    [cell.myTitle setNumberOfLines:3];
    
    NSURL *url = [NSURL URLWithString: voa._pic];
    
    [cell.myImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
//    if (voa._hotFlg.integerValue == 1) {
//
//        [cell.hotImg setHidden:NO];
//        
////        NSLog(@"hot:1");
//    }
//    [voa release];
  
    return cell;
    }
    else
    {
        NSInteger row =[indexPath row];
        UIFont *SenEn = [UIFont systemFontOfSize:18];
        UIFont *SenCn = [UIFont systemFontOfSize:16];
        UIFont *SenEnP = [UIFont systemFontOfSize:22];
        UIFont *SenCnP = [UIFont systemFontOfSize:20];
        //            UIFont *classFoPad = [UIFont systemFontOfSize:20];
        static NSString *SentenceCell= @"SentenceCell";
        UITableViewCell *cellThree = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:SentenceCell];
        if (!cellThree) {
            cellThree = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SentenceCell] autorelease];
            UILabel *SenLabel = [[UILabel alloc] init];
            UILabel *SenCnLabel = [[UILabel alloc] init];
            UIImageView *line = [[UIImageView alloc]init];
//            UIImageView *detail = [[UIImageView alloc]init];
            if (isiPhone) {
                [SenLabel setFrame:CGRectMake(20, 5, 250, 45)];
                [SenLabel setFont:SenEn];
                [SenCnLabel setFrame:CGRectMake(20, 53,250 , 20)];
                [SenCnLabel setFont:SenCn];
                [line setImage:[UIImage imageNamed:@"line.png"]];
                [line setFrame:CGRectMake(0, 79, 320, 1)];
//                [detail setImage:[UIImage imageNamed:@"detailRead.png"]];
//                [detail setFrame:CGRectMake(300, 32, 12, 12)];
            } else {
                [SenLabel setFrame:CGRectMake(20, 5, 698, 90)];
                [SenLabel setFont:SenEnP];
                [SenCnLabel setFrame:CGRectMake(20, 98,698 , 40)];
                [SenCnLabel setFont:SenCnP];
                [line setImage:[UIImage imageNamed:@"line@2x.png"]];
                [line setFrame:CGRectMake(0, 159, 768, 1)];
//                [detail setImage:[UIImage imageNamed:@"detailRead@2x.png"]];
//                [detail setFrame:CGRectMake(720, 64, 24, 24)];
            }
            
            [SenLabel setBackgroundColor:[UIColor clearColor]];
            [SenLabel setTag:1];
            [SenLabel setTextColor:[UIColor colorWithRed:114/255.0 green:134/255.0 blue:170/255.0 alpha:1]];
            [SenLabel setTextAlignment:NSTextAlignmentLeft];
            [SenLabel setLineBreakMode:UILineBreakModeClip];
            [SenLabel setNumberOfLines:3];
            
            [SenCnLabel setBackgroundColor:[UIColor clearColor]];
            [SenCnLabel setTag:2];
            [SenCnLabel setTextColor:[UIColor colorWithRed:114/255.0 green:134/255.0 blue:170/255.0 alpha:1]];
            [SenCnLabel setTextAlignment:NSTextAlignmentLeft];
            [SenCnLabel setLineBreakMode:UILineBreakModeClip];
            [SenCnLabel setNumberOfLines:2];

            //            [wordLabel setTextColor:[UIColor colorWithRed:0.112f green:0.112f blue:0.112f alpha:1.0f]];
            //            [wordLabel  setLineBreakMode:UILineBreakModeClip];
            //            [wordLabel setNumberOfLines:1];
            [cellThree addSubview:SenLabel];
            [cellThree addSubview:SenCnLabel];
            [cellThree addSubview:line];
//            [cellThree addSubview:detail];
            [line release];
//            [detail release];
            [SenLabel release];
            [SenCnLabel release];
        }
        VOASentence *sen = [senArray objectAtIndex:row];
        for (UIView *nLabel in [cellThree subviews]) {
            
            
            if (nLabel.tag == 1) {
                [(UILabel*)nLabel setText:sen.Sentence];
            }
            else if (nLabel.tag == 2){
                [(UILabel *)nLabel setText:sen.Sentence_cn];
            }
        
        }
        
        [cellThree setSelectionStyle:UITableViewCellSelectionStyleNone];
        cellThree.backgroundColor = [UIColor clearColor];
        //        [cellThree.textLabel setText:[classArray objectAtIndex:row]];
        //        [cellThree.textLabel setTextAlignment:NSTextAlignmentRight];
        //        [cellThree.textLabel setBackgroundColor:[UIColor clearColor]];
        //        [cellThree.textLabel setTextColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.8f]];
        return cellThree;
    }
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (isiPhone?80.0f:160.0f);
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isSentence) {
        VOASentence *sen = [senArray objectAtIndex:indexPath.row];
        [VOASentence deleteSentence:sen.SentenceId];
        [senArray removeObjectAtIndex:indexPath.row];
    }else{
        VOAFav *fav = [favArray objectAtIndex:indexPath.row];
        
        NSFileManager *deleteFile = [NSFileManager defaultManager];
        
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
        
        NSString *userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.mp3", fav._voaid]];
        
        //    NSLog(@"yunsi:%@",userPath);
        
        NSError *error = nil;
        
        if ([deleteFile removeItemAtPath:userPath error:&error]) {
            //		NSLog(@"delete succeed");
        }
        
        [VOAFav deleteCollect:[fav _voaid]];
        
        [favArray removeObjectAtIndex:indexPath.row];
    }
    
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (search.isFirstResponder) {
        
        [search resignFirstResponder];
        
        NSString *searchWords =  [search text];
        
        if (searchWords.length == 0) {
        }else
        {
            self.navigationController.navigationBarHidden = NO;
            
            if (isiPhone) {
                [voasTableView setFrame:CGRectMake(0, 0, 320, kViewHeight)];
                
                [search setFrame:CGRectMake(0, 0, 320, 44)];
            }else {
                [voasTableView setFrame:CGRectMake(0, 0, 768, kViewHeight)];
                
                [search setFrame:CGRectMake(0, 0, 768, 44)];
            }
            
            
            [search setHidden:YES];
            
            NSMutableArray *allVoaArray = favArray;
            
            NSMutableArray *contentsArray = nil;
            
            contentsArray = [VOAView findFavSimilar:allVoaArray search:searchWords];
            
//            NSLog(@"count:%d", [contentsArray count]);
            
            if ([contentsArray count] == 0) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kColFour message:[NSString stringWithFormat:@"%@%@%@",kSearchThree,searchWords,kColThree] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil ];
                
                [alert show];
                
                [alert release];
                
//                [contentsArray release];
                
            }else
            {
                search.text = @"";
                
                SearchViewController *searchController = [SearchViewController alloc];
                
                searchController.searchWords = searchWords;
                
                searchController.contentsArray = contentsArray;
                
                searchController.contentMode = 2;
                searchController.searchFlg = 11;
                
//                [contentsArray release];
                
                [self.navigationController pushViewController:searchController animated:YES];
                
                 [searchController release], searchController = nil;
            }
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
            
            if (isSentence) {
                
                NSUInteger row = [indexPath row];
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SentenceViewController *senView = [[SentenceViewController alloc]init];//新建新界面的controller实例
                        senView.row=row;
                        [senView setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
                        [self.navigationController pushViewController:senView animated:YES];
                        [senView release], senView = nil;
                        [HUD hide:YES];
                    });  
                }); 

                
            }else{
                NSUInteger row = [indexPath row];
                
                VOAFav *fav = [favArray objectAtIndex:row];
                
                //            HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
                //
                //            HUD.dimBackground = YES;
                //
                //            HUD.labelText = @"connecting!";
                
//                HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
//                [[UIApplication sharedApplication].keyWindow addSubview:HUD];
//                HUD.delegate = self;
//                HUD.labelText = @"Loading";
//                HUD.dimBackground = YES;
//                [HUD show:YES];
                
                VOAView *voa = [VOAView find:fav._voaid];
                if ([VOADetail isExist:voa._voaid] || [self isExistenceNetwork:1]) {
                    HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
                    HUD.dimBackground = YES;
                    HUD.labelText = @"Loading";
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            VOADetail *myDetail = [VOADetail find:voa._voaid];
                            if (!myDetail) {
                                //  NSLog(@"内容不全-%d",voa._voaid);
                                
                                if (kNetIsExist) {
                                    [VOADetail deleteByVoaid: voa._voaid];
                                    //                                        NSLog(@"voaid:%i",voa._voaid);
                                    [self catchDetails:voa];
                                }else {
                                    rightCharacter = NO;
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        kNetTest;
                                    });
                                }
                            }else {
//                                [myDetail release];
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
                                
                                if (play.contentMode != 2) {
                                    play.flushList = YES;
                                    play.contentMode = 2;
                                }
                                
                                [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
                                [self.navigationController pushViewController:play animated:NO];
                                [HUD hide:YES];
                                //                                }
                            }else {
                                notSelect = YES;
                                [HUD hide:YES];
//                                UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kNewFive delegate:self cancelButtonTitle:kWordFour otherButtonTitles:nil ,nil];
//                                [addAlert show];
//                                [addAlert release];
//                                [voasTableView setUserInteractionEnabled:YES];
                            }
                        });
                    });
                }
                else
                {
                    notSelect = YES;
                    UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kColEight delegate:self cancelButtonTitle:kWordFour otherButtonTitles:nil ,nil];
                    [addAlert show];
                    [addAlert release];
                    [voasTableView setUserInteractionEnabled:YES];
                }
//                [voa release];
//            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    VOAView *voa = [VOAView find:fav._voaid];
//                    PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
//                    if(play.voa._voaid == voa._voaid)
//                    {
//                        play.newFile = NO;
//                    }else
//                    {
//                        play.newFile = YES;
//                        play.voa = voa;
//                    }
//                    [voa release];
//                    [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
//                    if (play.contentMode != 2) {
//                        play.flushList = YES;
//                        play.contentMode = 2;
//                    }
//                    [self.navigationController pushViewController:play animated:NO];
//                    [HUD hide:YES];
//                });
//            });
            }
        }
    }
}

#pragma mark -
#pragma mark UISearchBar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [search resignFirstResponder];
    NSString *searchWords =  [search text];
    if (searchWords.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kColFour message:kColFive delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil, nil ];
        [alert show];
        [alert release];
    }else
    {
        self.navigationController.navigationBarHidden = NO;
        
        if (isiPhone) {
            [voasTableView setFrame:CGRectMake(0, 0, 320, kViewHeight)];
            
            [search setFrame:CGRectMake(0, 0, 320, 44)];
        }else {
            [voasTableView setFrame:CGRectMake(0, 0, 768, kViewHeight)];
            
            [search setFrame:CGRectMake(0, 0, 768, 44)];
        }
        [search setHidden:YES];
        NSMutableArray *allVoaArray = favArray;
        
//        HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
//        HUD.dimBackground = YES;
//        HUD.labelText = @"connecting!";
        HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
        [[UIApplication sharedApplication].keyWindow addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Loading";
        HUD.dimBackground = YES;
        [HUD show:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{  
                NSMutableArray *contentsArray = nil;
                contentsArray = [VOAView findFavSimilar:allVoaArray search:searchWords];
//                NSLog(@"count:%d", [contentsArray count]);
                
                if ([contentsArray count] == 0) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kColFour message:[NSString stringWithFormat:@"%@%@%@",kSearchThree,searchWords,kColThree] delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil, nil ];
                    [alert show];
                    [alert release];
//                    [contentsArray release];
                }else
                {
                    search.text = @"";
                    SearchViewController *searchController = [SearchViewController alloc];
                    searchController.searchWords = searchWords;
                    searchController.contentsArray = contentsArray;
                    searchController.contentMode = 2;
//                    [contentsArray release];
                    searchController.searchFlg = 11;
                    [self.navigationController pushViewController:searchController animated:YES];
                    [searchController release], searchController = nil;
                }
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
        [voasTableView setFrame:CGRectMake(0, 0, 320, kViewHeight)];
        
        [search setFrame:CGRectMake(0, 0, 320, 44)];
    }else {
        [voasTableView setFrame:CGRectMake(0, 0, 768, kViewHeight)];
        
        [search setFrame:CGRectMake(0, 0, 768, 44)];
    }
    [search setHidden:YES];
    search.text = @"";
}

#pragma mark - Touch
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

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

#pragma mark - Http connect
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

- (void)catchDetails:(VOAView *) voaid
{
    //    NSLog(@"获取内容-%d",voaid._voaid);
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/textApi.jsp?voaid=%d&format=xml",voaid._voaid];
    //    NSLog(@"catch:%d",voaid._voaid);
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"detail"];
    [request setTag:voaid._voaid];
    [request startSynchronous];
    //    [request release];
}

- (void)catchSensByPageNumber:(NSInteger) number
{
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/getCollect.jsp?userId=%d&groupName=Iyuba&type=voa&sentenceFlg=1&pageNumber=%d&pageCounts=10000",nowUserId,number];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setTag:number];
    NSOperationQueue *myQueue = [self sharedQueue];
    request.delegate = self;
    [request setUsername:@"allSen"];
    //        [request setDidStartSelector:@selector(requestMyStarted:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
    [myQueue addOperation:request];
}

- (void)catchSenAsFlg:(VOASentence *) sen mode:(NSString *) mode
{
    //    NSLog(@"!!!!!!!_____________!!!!!!!!!!!");
//    VOAWord *nowWord = [VOAWord findById:wordId userId:nowUserId];
    //        NSLog(@"下载");
    //        NSLog(@"Queue 预备: %d",wordId);
    NSOperationQueue *myQueue = [self sharedQueue];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://apps.iyuba.com/voa/updateCollect.jsp?userId=%d&type=%@&voaId=%d&sentenceId=%d&groupName=Iyuba&sentenceFlg=1", sen.userId, mode, sen.VoaId, sen.StartTime]];
    NSLog(@"url:%@", url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setUsername:[NSString stringWithFormat:@"%d", sen.SentenceId]];
    if ([mode isEqualToString:@"insert"]) {
        [request setTag:1];
    }else{
        [request setTag:-1];
    }
    //        [request setDidStartSelector:@selector(requestMyStarted:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    //        [request setDidFailSelector:@selector(requestWentWrong:)];
    [myQueue addOperation:request];
}

- (void)requestDone:(ASIHTTPRequest *)request{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"allSen"]) {
        NSArray *items = [doc nodesForXPath:@"response/row" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
//                lastPage = [[[obj elementForName:@"lastPage"] stringValue] integerValue];
                NSInteger voaid = [[obj elementForName:@"voaid"] stringValue].integerValue;
                NSInteger sentenceid = [[obj elementForName:@"sentenceid"] stringValue].integerValue;
                NSInteger endTime = [[obj elementForName:@"endTime"] stringValue].integerValue;
                NSString *content = [[[[[obj elementForName:@"content"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"] stringByReplacingOccurrencesOfString:@"<b>" withString:@""] stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
                NSString *contentcn = [[[[[obj elementForName:@"contentcn"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"] stringByReplacingOccurrencesOfString:@"<b>" withString:@""] stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
                VOASentence *nowSen = [[VOASentence alloc] initWithVOASentence:[VOASentence findLastId]+1 VoaId:voaid ParaId:0 IdIndex:0 StartTime:sentenceid EndTime:endTime Sentence:content Sentence_cn:contentcn userId:nowUserId collected:0 synchroFlg:1];
                //                NSLog(@"初始化");
                [nowSen alterSynchroCollect];
                [nowSen release];
            }
        }
        //            NSLog(@"%d,同步圆满完成。",request.tag);
        [VOASentence deleteSynchro:nowUserId];
        [VOASentence clearSynchro];
        NSArray *sens = [VOASentence findSentences:nowUserId];
        [senArray removeAllObjects];
        for (id fav in sens) {
            [senArray addObject:fav];
        }
        [self.voasTableView reloadData];
    } else {
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                NSInteger result= [[[obj elementForName:@"result"] stringValue] integerValue];
//                NSString *type = [[obj elementForName:@"type"] stringValue];
                //                NSLog(@"result:%d", result);
                //                NSLog(@"word:%@", word);
                if (result==1 || result==2) {
                    if (request.tag < 0) {
                        //                        NSLog(@"删除:%@",word);
                        [VOASentence deleteSenBySenId:request.username.integerValue];
                    }
                    else{
                        [VOASentence alterCollectBySenId:request.username.integerValue];
                    }
                }
//                else if(result==2) {
//                    [VOASentence deleteSenBySenId:request.username.integerValue];
//                }
            }
        }
    }
    [doc release], doc = nil;
}

- (void)requestWentWrong:(ASIHTTPRequest *)request {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
    NSArray *sens = [VOASentence findSentences:nowUserId];
    [senArray removeAllObjects];
    for (id fav in sens) {
        [senArray addObject:fav];
    }
    [self.voasTableView reloadData];
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
                newVoaDetail._timing = [[[obj elementForName:@"Timing"] stringValue]integerValue];
                newVoaDetail._sentence = [[[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"]stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
                newVoaDetail._imgWords = [[[obj elementForName:@"ImgWords"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoaDetail._imgPath = [[obj elementForName:@"ImgPath"] stringValue];
                newVoaDetail._sentence_cn = [[[[[obj elementForName:@"sentence_cn"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"] stringByReplacingOccurrencesOfString:@"<b>" withString:@""] stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
                if ([newVoaDetail insert]) {
                    //                        NSLog(@"插入%d成功",newVoaDetail._voaid);
                }
                [newVoaDetail release],newVoaDetail = nil;
                
            }
            
        }
    }
    [doc release],doc = nil;
    //    [request release], request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        kNetTest;
    });
}

- (BOOL)isExistenceNetwork:(NSInteger)choose
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

@end
