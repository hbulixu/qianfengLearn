//
//  JPLimitFreeAppCell.h
//  FreeLimit
//
//  Created by qianfeng on 15-4-30.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPApp.h"

@interface JPLimitFreeAppCell : UITableViewCell

@property (nonatomic,strong)JPApp * app;

+ (id)limitFreeAppCellWithTableView:(UITableView *)tableView;

+ (id)limitFreeAppCellWithTableView:(UITableView *)tableView andObject:(id)model;
/**
 *标记传进来的模型数据对象在存储所有模型数组中的位置
 *使用此方法应该在传递模型数据之前，否则将造成视图在显示标记位置之前，还没有获取到标记，导致标记一直为index＋1;
 **/
- (void)reprotsIndex:(NSInteger)index;
@end
