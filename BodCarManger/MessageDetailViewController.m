//
//  MessageDetailViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-12-4.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.subClassInputTextField.hidden = YES;
    UITextView *msgShowTextView = [[UITextView alloc]initWithFrame:CGRectMake(10.f,kMBAppTopToolBarHeight+20.f, 300.f,160.f)];
    msgShowTextView.layer.cornerRadius = 5.f;
    msgShowTextView.text = self.userEmail;
    if(self.type == 1){
        msgShowTextView.editable = YES;
    }
    else{
        msgShowTextView.editable  = NO;
        [self setHiddenRightBtn:YES];
    }
    [self.view addSubview:msgShowTextView];
    SafeRelease(msgShowTextView);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
