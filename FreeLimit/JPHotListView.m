//
//  JPHotListView.m
//  FreeLimit
//
//  Created by qianfeng on 15-5-3.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPHotListView.h"

@interface JPHotListView ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JPHotListView

+ (id)hotListViewWithNib:(NSString *)name
{
    
    NSString * xibName = name == nil?@"JPHotListView":name;
    return   [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] lastObject];
}

/***加载xib的同时添加搜索框***/
#warning 还没有实现对搜索的功能实现，只是放置了一个UISearchBar
- (void)awakeFromNib
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.frame= CGRectMake(0, 0, 320, 40);
    //    searchBar.delegate = self;
    searchBar.placeholder = @"60万款应用搜搜看";
    self.tableView.tableHeaderView = searchBar;
}

@end
