//
//  JPTopic.h
//  FreeLimit
//
//  Created by qianfeng on 15-5-2.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPTopic : NSObject

@property (copy) NSString *title;
@property (copy) NSString *date;
@property (copy) NSString *img;
@property (copy) NSString *desc_img;
@property (copy) NSString *desc;
@property (retain) NSMutableArray *applications;

+ (id)topicWithDict:(NSDictionary *)dict;

- (id)initWithDict:(NSDictionary *)dict;
@end
