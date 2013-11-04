//
//  DressMemoRetweetController.m
//  DressMemo
//
//  Created by Fengfeng Pan on 12-8-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DressMemoRetweetController.h"
#import "UIRetweetView.h"
#import "SharePlatformCenter.h"
#import "DressMemoPhotoCache.h"
#import "MemoPhotoDownloader.h"

@interface DressMemoRetweetController ()

@end

@implementation DressMemoRetweetController

@synthesize imgPath;
@synthesize image = _image;

- (void)loadView{
    [super loadView];
    
    UIImage *bgImage = nil;
    UIImageWithFileName(bgImage,@"BG-user.png");
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    _retweetView = [[UIRetweetView alloc] initWithFrame:CGRectMake(0, 44, 320, 460-44-50)];
    [self.view addSubview:_retweetView];
    _retweetView.tableView.delegate = self;
    _retweetView.tableView.dataSource = self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) 
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisappear:) 
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    if ([self.imgPath length]) {
        UIImage *photo = [[DressMemoPhotoCache getInstance] getImageWithSmallImagePath:self.imgPath];
        if (photo != nil) {
            self.image = photo;
        }else{
            self.image = nil;
            
            _downloader = [[MemoPhotoDownloader alloc]initWithSmallImageUrl:self.imgPath
                                                                  indexPath:nil];
            _downloader.delegate = self;
            [[NTESMBServer getInstance] addRequest:_downloader];
            [_downloader release];
        }
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    Safe_Release(_retweetView)
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.imgPath = nil;
    self.image = nil;
    
    Safe_Release(_retweetView)
    
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_retweetView.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setImage:(UIImage *)image{
    Safe_Release(_image)
    _image = [image retain];
    
    [_retweetView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}
     
#pragma mark -
#pragma mark Public API
-(void)didSelectorTopNavItem:(id)navObj
{
	NE_LOG(@"select item:%d",[navObj tag]);
    
	switch ([navObj tag])
	{
		case 0:
        {
            [super didSelectorTopNavItem:navObj];
        }
			break;
		case 1: //发送按钮
		{
            NSString *string = [[(UIRetweetInputCell *)[_retweetView.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] inputView] text];
            NSData *data = nil;
            if (self.image) {
                data = UIImageJPEGRepresentation(self.image, 0.8);
            }
            [[SharePlatformCenter defaultCenter] sendStatus:string
                                                  ImageData:data];
			break;
		}
	}
    
}

#pragma mark -
#pragma mark Private API
- (void)keyboardAppear:(NSNotification *)n{
    _retweetView.tableView.contentOffset = CGPointZero;
    _retweetView.tableView.scrollEnabled = NO;
}

- (void)keyboardDisappear:(NSNotification *)n{
    _retweetView.tableView.scrollEnabled = YES;
}

#pragma mark -
#pragma mark UITableView Datasource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        static NSString *retweetCell = @"retweetCell";
        UIRetweetInputCell *cell = [tableView dequeueReusableCellWithIdentifier:retweetCell];
        
        if(![cell isKindOfClass:[UIRetweetInputCell class]]) {
            cell = [[[UIRetweetInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:retweetCell] autorelease];
        }
        
        cell.image.image = self.image;
        
        return cell;
        
    }else {
        static NSString *bindCell = @"bindCell";
        UIRetweetBindCell *cell = [tableView dequeueReusableCellWithIdentifier:bindCell];
        
        if (![cell isKindOfClass:[UIRetweetBindCell class]]) {
            cell = [[[UIRetweetBindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bindCell] autorelease];
        }

        NSString *type = nil;
        NSString *platformName = nil;
        if (indexPath.row == 1) {
            type = K_PLATFORM_Sina;
            platformName = @"新浪微博";
        }else {
            type = K_PLATFORM_Tencent;
            platformName = @"腾讯微波";
        }
        
        NSDictionary *data = [[SharePlatformCenter defaultCenter] modelDataWithType:type];
        cell.weiboType = type;

        [cell reloadData:data withWeiBo:platformName];

        
        return cell;
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0) {
        return [UIRetweetInputCell cellHeight];
    }else {
        return [UIRetweetBindCell cellHeight];
    }

    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *type;
    
    switch (indexPath.row) {
        case 1:
            type = K_PLATFORM_Sina;
            break;
        case 2:
            type = K_PLATFORM_Tencent;
            break;
        default:
            type = nil;
            break;
    }
    
    [[SharePlatformCenter defaultCenter] bindPlatformWithKey:type WithController:self];
}

- (void) requestCompleted:(NTESMBRequest *) request{
    if (request == _downloader) {
        if(request.receiveData){
			[[NTESMBLocalImageStorage getInstance] saveImageDataToSmallDir:request.receiveData
                                                                 urlString:request.urlString];
		}
        UIImage *image = [UIImage imageWithData:request.receiveData];
        self.image = image;
        
        _downloader = nil;
    }
}

- (void) requestFailed:(NTESMBRequest *) request{
    if (request == _downloader) {
        _downloader = nil;
    }
}


@end
