//
//  JPLimitFreeContentView.h
//  FreeLimit
//
//  Created by qianfeng on 15-4-30.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPLimitFreeContentView;

@protocol JPLimitFreeContentViewDelegate <NSObject>

- (void)cellTouchUp:(NSInteger)row;

@end

@interface JPLimitFreeContentView : UIView

/**用于存储模型数据的数组，set方法已经重写，当数据传输进来的时候，会刷新数据**/
@property (nonatomic,strong)NSArray * objs;

@property (nonatomic,assign)id<JPLimitFreeContentViewDelegate> delegate;

/**使用纯代码方式创建view对象**/
+ (id)limitFreeContentView;

/**使用加载xib方式创建view对象*，当不给定xib时，会自动加载自己创建的xib文件（JPLimitFreeContentView）*/
+ (id)limitFreeContentViewWithNib:(NSString *)name;
@end
