//
//  JPCellTouchUpView.h
//  FreeLimit
//
//  Created by qianfeng on 15-5-1.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPApp;
@class JPPhotos;

@interface JPCellTouchUpView : UIViewController

@property (nonatomic,strong)JPApp * apps;
//保存应用截图的数据
@property (nonatomic,strong)NSArray * objs;
//保存附近应用数据
@property (nonatomic,strong)NSArray * nearbyObjs;

+ (id)cellTouchUpView;

@end
