//
//  CarSelectedViewController.m
//  BodCarManger
//
//  Created by cszhan on 13-11-27.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "CarSelectedViewController.h"

@interface CarSelectedViewController ()

@end

@implementation CarSelectedViewController

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
    self.view.backgroundColor = HexRGB(202, 202, 204);
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self shouldLoadNewerData:tweetieTableView];
    NSString *title = @"";
     if(self.type  == 0){
         title = @"品牌选择";
     }
    else if(self.type ==1){
        title = @"车系选择";
    }
    else if(self.type ==2){
        title = @"车型选择";
    }
    [self setNavgationBarTitle:title];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return  5;
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *LabelTextFieldCell = @"LabelTextFieldCell";
	
	UITableViewCell *cell = nil;
    
    
    
	cell = [tableView dequeueReusableCellWithIdentifier:LabelTextFieldCell];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LabelTextFieldCell];
        cell.backgroundColor = [UIColor whiteColor];
        
        //cell.clipsToBounds = YES;
        //cell.contentView.clipsToBounds = YES;
        
        //cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.textLabel.textColor = HexRGB(64, 64, 64);
   
    }
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [item objectForKey:@"name"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self.navigationController pushViewController:vc animated:YES];
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    if(self.type  == 0){
        CarSelectedViewController *carSelectedVc = [[CarSelectedViewController alloc] init];
        
        //carSelectedVc.brandSeq = self.brandSeq;
        //carSelectedVc.brandSeq = [item]
        carSelectedVc.brandName = [item objectForKey:@"name"];
        carSelectedVc.brandSeq = [item objectForKey:@"seq"];
        carSelectedVc.type = 1;
        [self.navigationController pushViewController:carSelectedVc animated:YES];
        SafeRelease(carSelectedVc);

    }
    else{
        if(self.type == 1){
         //ok get branseq and seriesSeq;
            CarSelectedViewController *carSelectedVc = [[CarSelectedViewController alloc] init];
            
            //carSelectedVc.brandSeq = self.brandSeq;
            carSelectedVc.brandName = self.brandName;
            carSelectedVc.seriesName = [item objectForKey:@"name"];
            carSelectedVc.seriesSeq = [item objectForKey:@"seq"];
            carSelectedVc.type = 2;
            //carSelectedVc.barTitle =
            [self.navigationController pushViewController:carSelectedVc animated:YES];
            SafeRelease(carSelectedVc);
        }
        else{
            
            
            NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                               [item objectForKey:@"name"],@"modelName",
                                self.seriesName,@"seriesName",
                                self.brandName,@"brandName",
                                [item objectForKey:@"seq"],@"modelSeq",
                                   nil];
            
            [ZCSNotficationMgr postMSG:kCarModelSelectedMSG obj:data];
            
            UIViewController *topViewcontroller =  [self.navigationController.viewControllers objectAtIndex:1];
            
            [self.navigationController popToViewController:topViewcontroller animated:YES];
            
        
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark -
#pragma mark net work
- (void)shouldLoadNewerData:(UITableView*)tableView{
    
    CarServiceNetDataMgr *cardShopMgr = [CarServiceNetDataMgr getSingleTone];
    
    //[self startShowLoadingView];
    kNetStartShow(@"数据加载...", self.view);
    if(self.type == 0)
    {
        [cardShopMgr getCarBand];
    }
    if(self.type ==1)
    {
        [cardShopMgr getCarSeries:self.brandSeq];
    }
    //    if(isNeedHeaderView)
    //    {
    //        self.adRequest = [cardShopMgr getHomePageAd:nil];
    //    }
    if(self.type == 2){
        [cardShopMgr getCarModel:self.seriesSeq];
    }
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];//[respRequest resourceKey];
    //NSString *resKey = [respRequest resourceKey];
    NSString *targetKey = @"";
    if(self.type == 0){
        targetKey = kCarBrandQuery;
    }
    if(self.type == 1){
        targetKey = kCarSeriesQuery;
    }
    if(self.type == 2){
        targetKey = kCarModelQuery;
    }
    if(self.request ==respRequest && [resKey isEqualToString:targetKey])
    {
        //        if ([self.externDelegate respondsToSelector:@selector(commentDidSendOK:)]) {
        //            [self.externDelegate commentDidSendOK:self];
        //        }
        //        kNetEndSuccStr(@"评论成功",self.view);
        //        [self dismissModalViewControllerAnimated:YES];
        kNetEnd(self.view);
        self.dataArray = [data objectForKey:@"data"];
        for(id item in self.dataArray){
            /*
             NSString *latLogStr = [item objectForKey:@"startadr2"];
             NSArray *latLogArr  = [latLogStr componentsSeparatedByString:@","];
             
             double lat = [latLogArr[1]floatValue]/kGPSMaxScale;
             double  lng = [latLogArr[0]floatValue]/kGPSMaxScale;
             
             [[DBManage getSingletone] getLocationDataFromVendorWithLatitude:lat withLotitude:lng];
             
             latLogStr = [item objectForKey:@"endadr2"];
             latLogArr  = [latLogStr componentsSeparatedByString:@","];
             
             lat = [latLogArr[1]floatValue]/kGPSMaxScale;
             lng = [latLogArr[0]floatValue]/kGPSMaxScale;
             [[DBManage getSingletone] getLocationDataFromVendorWithLatitude:lat withLotitude:lng];
             */
            //[self getPlaceNameByPositionwithLatitue:lat withLongitude:lng];
        }
        [tweetieTableView reloadData];
        
        //[self performSelectorOnMainThread:@selector(updateUIData:) withObject:data waitUntilDone:NO];
        
    }
   
}

-(void)didNetDataFailed:(NSNotification*)ntf
{
    //kNetEndWithErrorAutoDismiss(@"", 2.f);
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
    NSString *resKey = [obj objectForKey:@"key"];
    if(self.request ==respRequest && [resKey isEqualToString:kCarBrandQuery])
    {
        kNetEnd(self.view);
    }
    //NE_LOG(@"warning not implemetation net respond");
}
-(void)didRequestFailed:(NSNotification*)ntf
{
    //[self stopShowLoadingView];
    kNetEnd(self.view);
}
-(void)didSelectorTopNavigationBarItem:(id)sender{
    
    switch ([sender tag]) {
        case  0:
            //[self.navigationController popViewControllerAnimated:YES];// animated:<#(BOOL)animated#>
			break;
        case 2:
        case 1:{
            /*
             [ZCSNotficationMgr postMSG:kPopAllViewController obj:nil];
             [self.navigationController popToRootViewControllerAnimated:YES];
             */
            
        }
    }
    
}

@end
