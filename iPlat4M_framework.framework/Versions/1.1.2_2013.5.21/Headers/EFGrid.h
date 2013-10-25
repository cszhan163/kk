//
//  EFGrid.h
//  iPlat4M
//
//  Created by fuyiming on 11-11-30.
//  Copyright 2011 baosteel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFFoundation.h"
#import "EGORefreshTableHeaderView.h"
#import "EFRefreshTableFooterView.h"

@class EFForm;

typedef enum {
    ESortTypeNone,		// 不排
    ESortTypeAscend,	// 顺序
    ESortTypeDescend	// 逆序
} ESortType;   

typedef enum {
    EActionTypeAddRow,
    EActionTypeEditRow,
    EActionTypeDeleteRow,
} EActionType;

typedef enum {
    EDragModeTop,
    EDragModeButtom
}EDragMode;


@class  EFGridCell;

@interface EFGrid :  UITableView<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate> {
	
    
    NSString * eName;
    NSString * eBlockName;
    NSString * eGroupFieldName;
    NSString * eSortFieldName;
    int ePageSize;
    
    ESortType eGroupSort;
    ESortType eSort;
    
    BOOL eAddingRowEnabled;
    BOOL eDeleteRowEnabled;

    id (^initCell)(NSMutableDictionary *);
    id (^doBeginActionOnRow)(EActionType,NSMutableDictionary *);
    void (^doDeleteOnRow)(NSMutableDictionary *);
    
    void (^doBeginDragToRefreshData)(EDragMode);
    
    EiBlock * block;
    EiInfo * innerEiInfo;    
    
    UIToolbar * topBar;
    EFForm * _detailForm;
    
    //分组、排序
    NSMutableArray * _groupNameList;     //组名列表  
    NSMutableDictionary * _groupedRows;    //组及组员列表 （组名为key，列表为Value）
    NSMutableArray * _rows;
    NSString * _eFGridReuseIdentifier ;
    
    //分页、翻页
    BOOL ePagingEnabled;
    int currentPage;
    BOOL _reloading;
    int _totalRecords;
    EGORefreshTableHeaderView * _refreshHeaderView;
    EFRefreshTableFooterView * _refreshFooterView;
//    UILabel * _countInfoLabel;
//    UILabel * _footerNoticeLabel;
//    BOOL _footerLoading;
//    UIActivityIndicatorView * _footerActivityView;
    
}

@property (nonatomic,retain) NSString * eName;
@property (nonatomic,retain) NSString * eBlockName;
@property (nonatomic,retain) NSString * eGroupFieldName;
@property (nonatomic,retain) NSString * eSortFieldName;
@property (nonatomic,assign) int ePageSize;
@property (nonatomic,assign) NSInteger rowsShouldShow;
@property (nonatomic,assign) BOOL ePagingEnabled;
@property (nonatomic,assign) BOOL eAddingRowEnabled;
@property (nonatomic,assign) BOOL eDeleteRowEnabled;


@property (nonatomic,assign) ESortType eGroupSort;
@property (nonatomic,assign) ESortType eSort;

@property (nonatomic,assign) UIToolbar * topBar;

@property (nonatomic,retain) EiBlock * block;
@property (nonatomic,retain) EiInfo * innerEiInfo;

@property (nonatomic,copy) id (^initCell)(NSMutableDictionary *);//自定义Cell的初始化代码

//新增按钮被点时、一行数据被选择时触发的代码。 可用来切换显示明细页面。返回
@property (nonatomic,copy) id (^doBeginActionOnRow)(EActionType,NSMutableDictionary *);

@property (nonatomic,copy) void (^doDeleteOnRow)(NSMutableDictionary *);//默认的删除按钮被点击时触发的回调。

- (void) doEndAction:(EActionType)actionType OnRow:(NSMutableDictionary *)row;//自定义操作执行完之后，调用此函数执行页面数据(eiinfo)和界面更新。

//上下拖动刷新数据。
@property (nonatomic,copy) void (^doBeginDragToRefreshData)(EDragMode);
- (void) doEndDrag:(EDragMode)dragMode  ToRefreshData:(EiInfo *) data ;

- (EGORefreshTableHeaderView *) getRefreshHeader;
- (EFRefreshTableFooterView *) getRefreshFooter;
- (void)doneLoadingTableViewData;
-(int) currentPage;
@end

@interface EFGrid(private)
- (void) initDefaultStatus;
- (void) reOrgnizeGroupSortData;
- (void) initTopBar;
- (void) initRefreshView; 
- (NSMutableDictionary *) getRowAtIndexPath:(NSIndexPath *)indexPath;
-(void) setStatusSize:(int)size Total:(int)total;
-(void) setPositionOfFooterRefreshView;

@end


