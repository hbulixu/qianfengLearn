//
//  JPSpecialView.h
//  FreeLimit
//
//  Created by qianfeng on 15-5-2.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPSpecialView : UIView

@property (nonatomic,strong)NSArray * arrays;

+ (id)specialViewWithNib:(NSString *)name;
@end
