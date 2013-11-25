//
//  XLCycleScrollView.h
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLCycleScrollViewDelegate;
@protocol XLCycleScrollViewDatasource;

@interface XLCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    id<XLCycleScrollViewDelegate> _delegate;
    id<XLCycleScrollViewDatasource> _datasource;
    
    NSInteger _totalPages;
    NSInteger _curPage;
   
    BOOL isRightScroller;
    
    NSMutableArray *_curViews;
}
@property (nonatomic,assign)  NSInteger nolimitIndex;
@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDataource:) id<XLCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<XLCycleScrollViewDelegate> delegate;
- (void)setRightScroller:(BOOL)status;
- (void)reloadData;
- (void)resetInitStatus;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;
- (id)getCurrentPageView;
- (void)scrollerToNextPage;
- (void)scrollerToPrePage;
@end

@protocol XLCycleScrollViewDelegate <NSObject>

@optional
- (void)didEndScrollerView:(XLCycleScrollView*)sender;
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index;

@end

@protocol XLCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;
- (UIView *)pageAtIndex:(NSInteger)index withView:(XLCycleScrollView*)csView;
@end
