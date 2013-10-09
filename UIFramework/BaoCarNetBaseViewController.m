//
//  CardShopNetBaseViewController.m
//  CardShop
//
//  Created by cszhan on 12-9-15.
//  Copyright (c) 2012年 cszhan. All rights reserved.
//

#import "BaoCarNetBaseViewController.h"

@interface CardShopNetBaseViewController ()

@end

@implementation CardShopNetBaseViewController
@synthesize request;
@synthesize allIconDownloaders;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addObservers];
        self.allIconDownloaders = [NSMutableDictionary dictionary];
    }
    return self;
}
- (void)addObservers
{
    [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkOK:) msgName:kZCSNetWorkOK];
    [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkFailed:) msgName:
     kZCSNetWorkRespondFailed];
    [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkFailed:) msgName:kZCSNetWorkConnectionFailed];
    [ZCSNotficationMgr addObserver:self call:@selector(didNetWorkFailed:) msgName:kZCSNetWorkRequestFailed];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
-(void)didNetWorkOK:(NSNotification*)ntf
{
    [self performSelectorOnMainThread:@selector(didNetDataOK:) withObject:ntf waitUntilDone:NO];
    
}
-(void)didNetWorkFailed:(NSNotification*)ntf
{
    [self performSelectorOnMainThread:@selector(didNetDataFailed:) withObject:ntf waitUntilDone:NO];
}
#pragma mark net work respond failed

-(void)didNetDataOK:(NSNotification*)ntf
{
    //kNetEnd(self.view);
    NE_LOG(@"warning not implemetation net respond");
    //self.view.userInteractionEnabled = YES;
}
-(void)didNetDataFailed:(NSNotification*)ntf
{
    NE_LOG(@"warning not implemetation net respond");
}
#pragma mark -
#pragma mark RequestDelegate
-(void)dealloc
{
    [ZCSNotficationMgr removeObserver:self];
    [super dealloc];
}
@end
