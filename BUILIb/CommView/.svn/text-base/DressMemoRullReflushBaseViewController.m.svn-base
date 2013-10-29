//
//  DresMemoRullReflushBaseViewController.m
//  DressMemo
//
//  Created by cszhan on 12-8-10.
//
//

#import "DressMemoRullReflushBaseViewController.h"

@interface DressMemoRullReflushBaseViewController ()
@property(nonatomic,assign)NSInteger currentDirection;
@end

@implementation DressMemoRullReflushBaseViewController
@synthesize navigationController;
@synthesize currentDirection;
@synthesize scollerDelegate;
@synthesize isNeedRefulsh;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.reflushType = 0;
        self.currentDirection=-1;
        self.memoCellType = MemoImage_NoTime;
        self.isVisitOther = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //tweetieTableView.frame  = CGRectOffset(tweetieTableView.frame,0,6.f);
    tweetieTableView.contentInset = UIEdgeInsetsMake(45.f,0.f,0.f,0.f);
    tweetieTableView.normalEdgeInset =  UIEdgeInsetsMake(45.f,0.f,30.f,0.f);
    tweetieTableView.bottomEdgeInset =  UIEdgeInsetsMake(0.f,0.f,40.f,0.f);
    tweetieTableView.topEdgeInset = UIEdgeInsetsMake(45+40.f,0.f,0.f,0.f);
    tweetieTableView.dragDownOffset = 168.f/2.f-9.f+45.f;
    tweetieTableView.hasDownDragEffect = YES;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark scroller action
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[tweetieTableView tableViewDidScroll];
    [super scrollViewDidScroll:scrollView];
    /*
    if(tweetieTableView.contentOffset.y<=0)//scroll up
    {
        tweetieTableView.contentOffset = CGPointMake(0.f,-44.f);
    }
    */
#if 1
    //NSLog(@"%d",tweetieTableView.scrollDirection);
    if(tweetieTableView.scrollDirection == 0)//scroll down
    {
        //tweetieTableView.contentOffset = CGPointMake(0.f,-44.f);
        if(currentDirection == 0)
        {
            return;
        }
        if(scollerDelegate&&[scollerDelegate respondsToSelector:@selector(didScrollerViewDown:)])
        {
            [scollerDelegate didScrollerViewDown:tweetieTableView];
            currentDirection =0;
        }
    }
    NSLog(@"tweetTableView contentoffset:%lf",tweetieTableView.contentOffset.y);
    if(tweetieTableView.scrollDirection ==1)//scoller up
    {
        //NSLog(@"%lf",tweetieTableView.contentOffset.y);
        if(currentDirection==1)
            return;
        if(scollerDelegate&&[scollerDelegate respondsToSelector:@selector(didScrollerViewUp:)])
        {
            [scollerDelegate didScrollerViewUp:tweetieTableView];
            currentDirection=1;
        }
       
        // tweetieTableView.contentOffset = CGPointMake(0.f,0.f);
        return ;
    }
#endif
}
/*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"did endDecelerating.....");

}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"moving.....");
}
*/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
        [tweetieTableView  tableViewBeginDragging];
#if 0
    if(tweetieTableView.scrollDirection == 0)//scroll down
    {
        //tweetieTableView.contentOffset = CGPointMake(0.f,-44.f);
        if(currentDirection == 0)
        {
            return;
        }
        if(scollerDelegate&&[scollerDelegate respondsToSelector:@selector(didScrollerViewDown:)])
        {
            [scollerDelegate didScrollerViewDown:tweetieTableView];
            currentDirection =0;
        }
    }
    NSLog(@"tweetTableView contentoffset:%lf",tweetieTableView.contentOffset.y);
    if(tweetieTableView.scrollDirection ==1)//scoller up
    {
        //NSLog(@"%lf",tweetieTableView.contentOffset.y);
        if(currentDirection==1)
            return;
        if(scollerDelegate&&[scollerDelegate respondsToSelector:@selector(didScrollerViewUp:)])
        {
            [scollerDelegate didScrollerViewUp:tweetieTableView];
            currentDirection=1;
        }
        // tweetieTableView.contentOffset = CGPointMake(0.f,0.f);
        return ;
    }
#endif
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if(!delegate)
    {
        /*
        NSLog(@"kkkkff:%lf",scrollView.contentOffset.y);
        if(scrollView.contentOffset.y<=0)
        {
            scrollView.contentOffset = CGPointMake(0.f,40.f);
        }
        */
    }
#if 0
    if(tweetieTableView.scrollDirection == 0)//scroll down
    {
        //tweetieTableView.contentOffset = CGPointMake(0.f,-44.f);
        if(currentDirection == 0)
        {
            return;
        }
        if(scollerDelegate&&[scollerDelegate respondsToSelector:@selector(didScrollerViewDown:)])
        {
            [scollerDelegate didScrollerViewDown:tweetieTableView];
            currentDirection =0;
        }
    }
    NSLog(@"scrollViewDidEndDragging contentoffset:%lf",tweetieTableView.contentOffset.y);
    if(tweetieTableView.scrollDirection ==1)//scoller up
    {
        //NSLog(@"%lf",tweetieTableView.contentOffset.y);
        if(currentDirection==1)
            return;
        if(scollerDelegate&&[scollerDelegate respondsToSelector:@selector(didScrollerViewUp:)])
        {
            [scollerDelegate didScrollerViewUp:tweetieTableView];
            currentDirection=1;
        }
        
        // tweetieTableView.contentOffset = CGPointMake(0.f,0.f);
        return ;
    }
#endif
}
#pragma mark -
#pragma mark pull net work start get data
- (void) shouldLoadNewerData:(NTESMBTweetieTableView *) tweetieTableView
{
    NSLog(@"loader new data");
    //    if(isRefreshing)
    //        return;
    self.reflushType = Reflush_NEW;
    [self startShowLoadingView];
    //NSDictionary  *currentData = nil;
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    int dataCount = [self.dataArray count];
    
    if(dataCount == 0)
    {
        [paramDict setValue:@"new" forKey:@"type"];
    }
    else
    {
        NSDictionary *reqData = [self.dataArray objectAtIndex:0];
        [paramDict setValue:@"after" forKey:@"type"];
        [paramDict setValue:[reqData objectForKey:@"memoid"] forKey:@"memoid"];
        [paramDict setValue:[reqData objectForKey:@"addtime"] forKey:@"timestamp"];
    }
    [paramDict setValue:@"15" forKey:@"num"];
    //[tweetieTableView closeInfoView];
    [self startLoadNetData:paramDict];
}
- (void)shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView
{
#if 1
    if(isRefreshing)
        return;
#endif
    NSLog(@"loader old data");
    self.reflushType = Reflush_OLDE;
    [self startShowLoadingView];
    
    //NSDictionary  *currentData = nil;
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    int dataCount = [self.dataArray count];
    
    if(dataCount == 0)
    {
        [paramDict setValue:@"new" forKey:@"type"];
    }
    else
    {
        NSDictionary *reqData = [self.dataArray objectAtIndex:dataCount-1];
        [paramDict setValue:@"before" forKey:@"type"];
        [paramDict setValue:[reqData objectForKey:@"memoid"] forKey:@"memoid"];
        [paramDict setValue:[reqData objectForKey:@"addtime"] forKey:@"timestamp"];
    }
    [paramDict setValue:@"15" forKey:@"num"];
    //[tweetieTableView closeInfoView];
    [self startLoadNetData:paramDict];
}

@end
