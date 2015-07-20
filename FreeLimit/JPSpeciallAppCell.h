//
//  JPSpeciallAppCell.h
//  FreeLimit
//
//  Created by qianfeng on 15-5-2.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPTopic;


@interface JPSpeciallAppCell : UITableViewCell

@property (nonatomic,strong)JPTopic * topics;

+ (id)speciallAppCellWithTableView:(UITableView *)tableView;
@end
