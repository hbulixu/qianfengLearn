//
//  JPTopic.m
//  FreeLimit
//
//  Created by qianfeng on 15-5-2.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPTopic.h"
#import "JPApp.h"

@implementation JPTopic

+ (id)topicWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray * array = [NSMutableArray array];
        for (NSDictionary * dict in self.applications) {
            
            JPApp * apps = [JPApp appWithDict:dict];
            [array addObject:apps];
        }
        //将临时变量保存起来
        self.applications = array;
    }
    return self;
}

@end
