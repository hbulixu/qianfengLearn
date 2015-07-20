//
//  JPLimitFreeContentView.m
//  FreeLimit
//
//  Created by qianfeng on 15-4-30.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPLimitFreeContentView.h"
#import "JPLimitFreeAppCell.h"

@interface JPLimitFreeContentView ()<UITableViewDataSource,UITableViewDelegate>//,UISearchBarDelegate>

/**用于显示限免中的所有app数据内容**/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//下标标记需要跳转的控制器
@property (assign, nonatomic)NSInteger index;

@end

@implementation JPLimitFreeContentView

- (void)setObjs:(NSArray *)objs
{
    _objs = objs;
//    self.tableView.rowHeight = 87;
    //刷新列表
    [self.tableView reloadData];
}

//1.纯代码加载
+ (id)limitFreeContentView
{
    return [[self alloc] init];
}

//2. xib加载
+ (id)limitFreeContentViewWithNib:(NSString *)name
{
    
    NSString * xibName = name == nil?@"JPLimitFreeContentView":name;
    return   [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] lastObject];
}

- (id)init
{
    if (self = [super init])
    {
        //1. 在初始化的时创建子控件对象
        [self initSubViews];
    }
    return self;
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

/**使用纯代码创建子控件**/
- (void)initSubViews
{
    //需要自己alloc内部子控件
}

#pragma mark - 数据源方法实现

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//#warning 获取模型数据并且填充到cell中去
    
//    return [JPLimitFreeAppCell limitFreeAppCellWithTableView:tableView andObject:self.objs[indexPath.row]];
    JPLimitFreeAppCell * cell = [JPLimitFreeAppCell limitFreeAppCellWithTableView:tableView];
    [cell reprotsIndex:indexPath.row];
    cell.app = self.objs[indexPath.row];
    return cell;

}

#pragma mark - 代理方法实现，功能：设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.index) {
        case 1: //跳转至限免控制器
            [_delegate cellTouchUp:indexPath.row];
            break;
        case 2://跳转至打折控制器
            [_delegate cellTouchUp:indexPath.row];
            break;
        case 3://跳转至免费控制器
            [_delegate cellTouchUp:indexPath.row];
            break;
        default:
            break;
    }
   
    return indexPath;
}

/**获取到当前控制器的tag值***/
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.index = newSuperview.tag;
}
@end
