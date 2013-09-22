//
//  UIDataNetBaseViewController.m
//  DressMemo
//
//  Created by  on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIImageNetBaseViewController.h"
#import "ZCSNetClient.h"
#import "UIBaseFactory.h"
@interface UIImageNetBaseViewController ()

@end

@implementation UIImageNetBaseViewController
@synthesize reflushType;
@synthesize dataArray;
@synthesize isRefreshing;
@synthesize request;
@synthesize isVisitOther;
@synthesize userId;
@synthesize requestDict;
@synthesize data;
#ifdef LOADING_VIEW
@synthesize animationView;
#endif
@synthesize memoTimelineDataSource;
@synthesize myEmptyBgView;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
        allIconDownloaders = [[NSMutableDictionary alloc] init];
        self.dataArray =[NSMutableArray array];
        self.requestDict = [[[NSMutableDictionary alloc]init] autorelease];
        currentPageNum = 1;
        self.mainContentViewPendingY = -2.f;
    }
    return self;
}
- (void)dealloc 
{
	self.myEmptyBgView = nil;
    [tweetieTableView release];
	[allIconDownloaders release];
    self.requestDict = nil;
    self.dataArray = nil;
    self.data = nil;
	[super dealloc];
}                     
- (void)addObservers
{
#if 1
    [ZCSNotficationMgr addObserver:self call:@selector(didReloadRequest:) msgName:kZCSNetWorkReloadRequest];
    [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkOK:) msgName:kZCSNetWorkOK];
    [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkFailed:) msgName:kZCSNetWorkRespondFailed];
    [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkFailed:) msgName:kZCSNetWorkConnectionFailed];
    [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkFailed:) msgName:kZCSNetWorkRequestFailed];
    [ZCSNotficationMgr addObserver:self call:@selector(didUserLogin:) msgName:kUserDidLoginOk];
  
#endif
}
- (void)setEmptyDataUI
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.autoresizingMask = YES;
    self.view.autoresizingMask = YES;
    //if(isVisitOther)
    {
         [self setHiddenRightBtn:YES];
    }
    if(!isVisitOther)
    {
        [self setEmptyDataUI];
    }
    CGRect tweetieTableViewFrame = CGRectMake(self.mainContentViewPendingX,kMBAppTopToolBarHeight+self.mainContentViewPendingY,kMBAppRealViewWidth-self.mainContentViewPendingX,kMBAppRealViewHeight-self.mainContentViewPendingY);
	NE_LOG(@"FrameTableViewFrame:");
	NE_LOGRECT(self.view.frame);
	NE_LOGRECT(tweetieTableViewFrame);
	tweetieTableView = [[NTESMBTweetieTableView alloc] initWithFrame:tweetieTableViewFrame hasDragEffect:!noDragEffect hasSearchBar:hasSearchBar];
	//tweetieTableView = [[NTESMBTweetieTableView alloc] initWithFrame:self.view.bounds hasDragEffect:!noDragEffect hasSearchBar:hasSearchBar withStyle:UITableViewStyleGrouped];
	tweetieTableView.delegate = self;
    tweetieTableView.tweetieTableViewDelegate = self;
    tweetieTableView.backgroundColor = [UIColor clearColor];
	tweetieTableView.dataSource = self;
	tweetieTableView.autoresizingMask = YES;
    //tweetieTableView.separatorStyle = UITableViewCellSeparatorStyle;
	tweetieTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //no downdrag effect
    tweetieTableView.hasDownDragEffect = NO;
    //memoTimelineDataSource = self;
    //tweetieTableView.contentSize
    [self.view addSubview:tweetieTableView];
    [self.view bringSubviewToFront:mainView.topBarView];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.myEmptyBgView = nil;
    [tweetieTableView release];
    
	//[allIconDownloaders release];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];

	//self.view.frame = CGRectMake(0.f, -kMBAppStatusBar, kMBAppRealViewWidth, 480);
    
	
	//[self.view addSubview:tweetieTableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.dataArray && indexPath.row == [self.dataArray count] - 1)
//    {
//        
//        [tweetieTableView startToDownDragReflush];
//        /*
//        [self.loadingSignal setHidden:NO]; // <====== my UIActivityIndicatorView is called "loadingSignal"
//        [self.loadingSignal startAnimating];
//        
//        /// make web request that will take a few seconds
//        
//        [self.loadingSignal setHidden:YES];
//        [self.loadingSignal stopAnimating];
//        */
//    }
//}

- (void)loadMoreAtbottomCell
{
    NSArray *visibleRows = [tweetieTableView visibleCells];
    UITableViewCell *lastVisibleCell = [visibleRows lastObject];
    NSIndexPath *path = [tweetieTableView indexPathForCell:lastVisibleCell];
    NSLog(@"%d",path.row);
    if(path.row == [self.dataArray count] - 1)
    {
        // Do something here
        [tweetieTableView startToDownDragReflush];
    }
}
- (void)loadMoreAtBottomCellII:(NSIndexPath*)indexPath
{
   
    if(indexPath.row == [self.dataArray count] - 1)
    {
        // Do something here
        [tweetieTableView startToDownDragReflush];
    }
}
- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point
{

}
#pragma mark -
#pragma mark ImageData Download
- (void) loadImagesForOnscreenRows
{

	NSArray *indexPathArray = [tweetieTableView indexPathsForVisibleRows];
    
	for (NSIndexPath *indexPath in indexPathArray)
	{
        [self startloadVisibleCellImageData:indexPath];
	}
	
}
-(void)startloadVisibleCellImageData:(NSIndexPath*)path
{
    NE_LOG(@"warning load visibleCellImagedata not implementation");
    
}
-(void)updatesegmentTitle:(NSInteger)icount
{
	
}
- (void) cancelAllIconDownloads
{
	NE_LOG(@"warning not emplementation icon downloads cancell");
		
}
#pragma mark -
#pragma mark UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [tweetieTableView tableViewDidScroll];
    
    //[self loadMoreAtbottomCell];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	//[super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
	[tweetieTableView tableViewDidEndDragging];
	[self cancelAllIconDownloads];
	if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
		/*
         if([scrollView respondsToSelector:@selector(reloadData)]){
         [scrollView reloadData];
         }
         */
	}
  
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
     NSIndexPath *indexPath = [tweetieTableView indexPathForRowAtPoint:CGPointMake(160.f, 416.-50.f)];
    
    //[self loadMoreAtBottomCellII:indexPath];
  [self loadMoreAtbottomCell];
}
-(void)scrollViewDidScrollToTop:(UIScrollView*)scrollView
{
	//[self scrollViewDidScrollToTop:scrollView];
	NE_LOG(@"kkk");
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	
}
#pragma mark -
#pragma mark - reflush load data action
- (void) shouldLoadNewerData:(NTESMBTweetieTableView *) tweetieTableView
{
    NSLog(@"loader new data");
    /*
    if(isRefreshing)
        return;
     */
     self.reflushType = Reflush_NEW;
    [memoTimelineDataSource getNewData];
}
- (void) shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView
{
    /*
    if(isRefreshing)
        return;
    */
    NSLog(@"loader old data");
    //[self ];
    self.reflushType = Reflush_OLDE;
    [memoTimelineDataSource getOldData];
}
-(void) reloadAllData
{
    [tweetieTableView reloadData];
}
#pragma mark net work respond failed
/*
-(void)didNetDataOK:(NSNotification*)ntf
{
    //kNetEnd(self.view);
    isRefreshing = NO;
    NE_LOG(@"warning not implemetation net respond");
    //self.view.userInteractionEnabled = YES;
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    isRefreshing = NO;
    NE_LOG(@"warning not implemetation net respond");
}
*/
-(void)didNetWorkOK:(NSNotification*)ntf
{
    [self performSelectorOnMainThread:@selector(didNetDataOK:) withObject:ntf waitUntilDone:NO];
    
}
-(void)didNetWorkFailed:(NSNotification*)ntf
{
    [self performSelectorOnMainThread:@selector(didNetDataFailed:) withObject:ntf waitUntilDone:NO];
}
-(void)didNetWorkRequestFailed:(NSNotification*)ntf
{

    [self performSelectorOnMainThread:@selector(didRequestFailed:) withObject:ntf waitUntilDone:NO];

}
-(void)didReloadRequest:(NSNotification*)ntf
{
    @synchronized(self)
    {
        //we should renew the request 
        self.request = [ntf object];
    
    }
}
#ifdef LOADING_VIEW
-(void)startShowLoadingView
{
    //@synchronized(self)
    {
        isRefreshing = YES;
    }
    //[self stopShowLoadingView];
    self.animationView =[UIBaseFactory forkNetLoadingImageAnimationView];
    [self.view addSubview:animationView];
    //[animationView removeFromSuperview];
    [animationView  startShowImageAnimation:0.5];

}
-(void)stopShowLoadingView
{
   // @synchronized(self)
  
    {
        isRefreshing = NO;
    }
    [self.animationView stopShowImageAnimation:0.5];
    //[self.animationView removeFromSuperview];
    //self.animationView = nil;
}
#endif

#pragma mark -reflush 
-(void)didNetDataOK:(NSNotification*)ntf
{
    //kNetEnd(self.view);
    //NE_LOG(@"warning not implemetation net respond");
    //self.view.userInteractionEnabled = YES;
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id _data = [obj objectForKey:@"data"];
    //NSString *resKey = [respRequest resourceKey];
    if(self.request == respRequest)
    {
        self.request = nil;
        [self stopShowLoadingView];
#ifdef kParserDataThread
        [self performSelectorInBackground:@selector(processReturnData:) withObject:_data];
#else
        [self processReturnData:_data];
#endif
        if([self.dataArray count]==0&&!self.isVisitOther)
        {
            self.myEmptyBgView.hidden = NO;
            tweetieTableView.hidden = YES;
        }
        else
        {
            self.myEmptyBgView.hidden  = YES;
            tweetieTableView.hidden = NO;
        }
        
        if (self.reflushType == Reflush_OLDE)
        {
            [tweetieTableView closeBottomView];
        }
        else
        {
            [tweetieTableView closeInfoView];
        }
    }
    
}
/*{"memoid":"101","uid":"2","addtime":"1343109729","emotionid":"2","occasionid":"1","countryid":"1","location":"kkk","picid":"289","picpath":"\/memo\/2012\/07\/24\/20120724140209_6mSq_e955570c.jpg","isrecommend":"0"}
 */
-(void)processReturnData:(id)data
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSArray *addData = nil;
    if([data isKindOfClass:[NSDictionary class]])
    {
        id result = [data objectForKey:@"results"];
        if([result isKindOfClass:[NSDictionary class]])
        {
            addData = [result allValues];
        }
        if([result  isKindOfClass:[NSArray class]])
        {
            addData = result;
        }
    }
    else if([data isKindOfClass:[NSArray class]])
    {
        addData = data;
    }
    switch (self.reflushType)
    {
        case Reflush_NEW:
            if([addData count])
            {
                int newNum = [addData count];
                if(newNum>=15)
                {
                    [self.dataArray removeAllObjects];
                }
                if([self.dataArray count])
                {
                    for(int i = [addData count]-1;i>=0;i--)
                    {
                        id item = [addData objectAtIndex:i];
                        [self.dataArray insertObject:item atIndex:0];
                    }
                }
                else
                    [self.dataArray addObjectsFromArray:addData];
            }
            break;
        case Reflush_OLDE:
            [self.dataArray addObjectsFromArray:addData];
        default:
            break;
    }
#ifdef kParserDataThread
    [self performSelectorOnMainThread:@selector(didParserDataOk) withObject:nil waitUntilDone:NO];
#else
    [self didParserDataOk];
#endif
    [pool release];
}
-(void)didParserDataOk
{
    //currentPageNum++;
    [self reloadAllData];
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    id obj = [ntf object];
    ZCSNetClient *respRequest = [obj objectForKey:@"sender"];
    
     id data = [obj objectForKey:@"data"];
    if([data isKindOfClass:[NSError class]])
    {
    
    }
    /*
     NSString *resKey = [respRequest resourceKey];
     */
    
    if(respRequest.followRequest == self.request||self.request == respRequest)
    {
        [self stopShowLoadingView];
        [self reStoreNormalState];
    }
  
    //
    //NE_LOG(@"warning not implemetation net respond");
}
-(void)didRequestFailed:(NSNotification*)ntf
{
    [self stopShowLoadingView];
}
-(void)didUserLogin:(NSNotification*)ntf{

}
-(void)reStoreNormalState
{
    if (self.reflushType == Reflush_OLDE)
    {
        [tweetieTableView closeBottomView];
    }
    else
    {
        [tweetieTableView closeInfoView];
    }
}
@end
