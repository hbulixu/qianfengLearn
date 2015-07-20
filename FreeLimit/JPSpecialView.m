//
//  JPSpecialView.m
//  FreeLimit
//
//  Created by qianfeng on 15-5-2.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPSpecialView.h"
#import "JPSpeciallAppCell.h"
//#import "JPApp.h"
#import "JPTopic.h"

@interface JPSpecialView () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JPSpecialView

+ (id)specialViewWithNib:(NSString *)name
{
        NSString * xibName = name == nil?@"JPSpecialView":name;
        return   [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] lastObject];
}

- (void)setArrays:(NSArray *)arrays
{
    _arrays = arrays;
//    NSLog(@"arrays%@",arrays);
    //刷新数据
     [self.tableView reloadData];
}

#pragma mark - 数据源方法实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JPSpeciallAppCell * cell = [JPSpeciallAppCell speciallAppCellWithTableView:tableView];
    cell.topics = self.arrays[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法实现，功能：设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 373;
}


@end
