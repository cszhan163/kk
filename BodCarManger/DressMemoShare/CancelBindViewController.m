//
//  CancelBindViewController.m
//  DressMemo
//
//  Created by Pan Fengfeng on 12-8-10.
//
//

#import "CancelBindViewController.h"
#import "SharePlatformCenter.h"

@interface CancelBindViewController ()

@end

@implementation CancelBindViewController

@synthesize platformType;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setRightBtnHidden:YES];
    [self setNavgationBarTitle:@"解除绑定"];
}
- (void)shouldLoadDataFromNet{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *LabelTextFieldCell = @"LabelTextFieldCell";
	
	UITableViewCell *cell = nil;
    
	cell = [tableView dequeueReusableCellWithIdentifier:LabelTextFieldCell];
	
    
    if (cell == nil)
    {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LabelTextFieldCell];
	}
    
    cell.textLabel.text = [NSString stringWithFormat:@"解除 %@ 绑定", [[SharePlatformCenter defaultCenter] plateformNameWithKey:self.platformType]];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
	return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.platformType isKindOfClass:[NSString class]]) {
        [[SharePlatformCenter defaultCenter] cancelBindPlatformWithKey:self.platformType];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
            if ([self.platformType isKindOfClass:[NSString class]]) {
                [[SharePlatformCenter defaultCenter] cancelBindPlatformWithKey:self.platformType];
            }
            [self.navigationController popViewControllerAnimated:YES];
			break;
		}
	}
    
}


@end
