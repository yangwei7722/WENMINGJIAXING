//
//  YcSegmentView.m
//  YCSegmentDemo
//
//  Created by hz_jiajia on 16/3/22.
//  Copyright © 2016年 hz_jiajia. All rights reserved.
//


#define ItemWidth 80
#define ItemHeight 40

#define HeaderBgCorlor [UIColor whiteColor]  //顶部视图颜色
#define SelectedBlockCorlor [UIColor colorWithRed:0.99 green:0.1 blue:0.1 alpha:0.5]
//设置选择块的颜色

#define LabelNormalColor [UIColor blackColor] //未选中字体颜色
#define LabelSelectedColor [UIColor whiteColor]//选中字体颜色

#import "YcSegmentView.h"

@implementation YcSegmentView
{
    UIView *_showContentLabelView;//用于展示当前label
    
    UIScrollView *_normalBgView;//正常状态下label的背景
    UIScrollView *_selectedBgView;//选中状态label的背景
    UIView *_btnBgView;//button层的背景
    
    UIScrollView *_scrollViewMain;//展示数据的scrollView
    
    NSInteger _countItem; //item总数
}

- (void)initializeData{
    _animation = YES;//过度动画
}

-(instancetype)initWithFrame:(CGRect)frame andHeaderHeight:(CGFloat )headerHeight andTitleArray:(NSArray *)titleArray andShowControllerNameArray:(NSArray *)showControllerArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setFrame:frame];
        [self initializeData];
        
        _countItem = [titleArray count];
        
        _normalBgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, headerHeight)];
        _normalBgView.delegate = self;
        
        //顶部视图背景颜色
        [_normalBgView setBackgroundColor:HeaderBgCorlor];
        [self createLabelWith:LabelNormalColor andTitle:titleArray addToView:_normalBgView];
        [self addSubview:_normalBgView];
        
        _btnBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _normalBgView.contentSize.width, CGRectGetHeight(_normalBgView.frame))];
        [_btnBgView setBackgroundColor:[UIColor clearColor]];
        [_normalBgView addSubview:_btnBgView];

        
        for (int i = 0; i < [titleArray count]; i++) {
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i*ItemWidth, 0, ItemWidth, ItemHeight)];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:i];
            [_btnBgView addSubview:btn];
        }

      //设置选择块的高度_showContentLabelView  _selectedBgView同时设置一正一负即可
        _showContentLabelView = [[UIView alloc]initWithFrame:CGRectMake(0, 6, ItemWidth, ItemHeight)];
        [_showContentLabelView setClipsToBounds:YES];
        [_normalBgView addSubview:_showContentLabelView];
        
        _selectedBgView = [[UIScrollView alloc]initWithFrame:CGRectMake(-1, -7, SCREENW, headerHeight)];
        [_selectedBgView setUserInteractionEnabled:NO];
        
        
//      //设置选择块的圆角
//        _showContentLabelView.layer.cornerRadius=5;
//        
//       _selectedBgView.layer.cornerRadius=7;
        
       
        
        
          //选择块视图的颜色
        [_selectedBgView setBackgroundColor:SelectedBlockCorlor];
        [_showContentLabelView addSubview:_selectedBgView];
        [self createLabelWith:LabelSelectedColor andTitle:titleArray addToView:_selectedBgView];
        
        _scrollViewMain = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_normalBgView.frame), SCREENW, SCREENH - CGRectGetMaxY(_normalBgView.frame))];
        [_scrollViewMain setBackgroundColor:[UIColor clearColor]];
        _scrollViewMain.contentSize = CGSizeMake(SCREENW * [titleArray count], CGRectGetHeight(_scrollViewMain.frame));
        _scrollViewMain.pagingEnabled = YES;
        _scrollViewMain.delegate = self;
        [_scrollViewMain setBounces:NO];
        [self addSubview:_scrollViewMain];
        
        for (int i = 0; i < [showControllerArray count]; i++) {
            
//            UIViewController * obj = [[someClass alloc] init];
//            Class someClass = NSClassFromString(showControllerArray[i]);
            
            UIStoryboard*storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
          UIViewController * obj=  [storyBoard instantiateViewControllerWithIdentifier:showControllerArray[i]];
          

            [obj.view setFrame:CGRectMake(i * SCREENW, 0, SCREENW, CGRectGetHeight(_scrollViewMain.frame))];
            [_scrollViewMain addSubview:obj.view];
            
        }
        
    }
    
    return self;
}

- (void)createLabelWith:(UIColor *)color andTitle:(NSArray *)titleArray addToView:(UIScrollView *)view{
    
    [view setShowsVerticalScrollIndicator:NO];
    [view setShowsHorizontalScrollIndicator:NO];
    [view setBounces:NO];
    //更改scrollView的大小
    [view setContentSize:CGSizeMake(ItemWidth * [titleArray count], CGRectGetHeight(view.frame))];

    //添加label
    for (int i = 0; i < [titleArray count]; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(i*ItemWidth, 0, ItemWidth, ItemHeight)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:titleArray[i]];
        [label setTextColor:color];
        [view addSubview:label];
    }
    
}

- (void)btnClick:(UIButton *)sender{
    
    [_scrollViewMain setContentOffset:CGPointMake(SCREENW * sender.tag, 0) animated:_animation];
    [self.delegate didSelectIndex:sender.tag];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView == _scrollViewMain){
        [_showContentLabelView setFrame:CGRectMake(scrollView.contentOffset.x*(ItemWidth/SCREENW), _showContentLabelView.frame.origin.y, _showContentLabelView.frame.size.width, _showContentLabelView.frame.size.height)];
        [_selectedBgView setContentOffset:CGPointMake(scrollView.contentOffset.x*(ItemWidth/SCREENW), 0)];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(scrollView == _scrollViewMain){
        if (CGRectGetMaxX(_showContentLabelView.frame) - _normalBgView.contentOffset.x > SCREENW) {
            [_normalBgView setContentOffset:CGPointMake(_normalBgView.contentOffset.x + CGRectGetMaxX(_showContentLabelView.frame) - _normalBgView.contentOffset.x - SCREENW, 0) animated:YES];
        }else if (_normalBgView.contentOffset.x - CGRectGetMinX(_showContentLabelView.frame) > 0){
            [_normalBgView setContentOffset:CGPointMake(_normalBgView.contentOffset.x - _normalBgView.contentOffset.x + CGRectGetMinX(_showContentLabelView.frame), 0) animated:YES];
        }
    }
    
}

@end
