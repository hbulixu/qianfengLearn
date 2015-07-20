//
//  JPApp.m
//  FreeLimit
//
//  Created by qianfeng on 15-4-30.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPApp.h"

@implementation JPPhotos

@end

@implementation JPApp

+ (id)appWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

//当我们模型中的属性，少于字典中传进来的key，也就是说没有完全对应上，就会调用这个方法
//并且，把缺失的属性、key值。value值,传递进来
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"])
    {
        self.des = value;
    }
//    NSLog(@"key %@ ,value %@",key,value);
}
@end
