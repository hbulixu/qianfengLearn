//
//  JPApp.h
//  FreeLimit
//
//  Created by qianfeng on 15-4-30.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPPhotos : NSObject
@property (copy) NSString * smallUrl;
@property (copy) NSString * originalUrl;
@end

@interface JPApp : NSObject

@property(nonatomic,copy)NSString * applicationId;
@property(nonatomic,copy)NSString * slug;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * releaseDate;
@property(nonatomic,copy)NSString * version;
//当属性的名称为关键字，或者为系统方法名称，就会导致kvc找不到该属性
//@property(nonatomic,copy)NSString * description;
@property(nonatomic,copy)NSString * des;

@property(nonatomic,copy)NSString * categoryId;
@property(nonatomic,copy)NSString * categoryName;
@property(nonatomic,copy)NSString * iconUrl;
@property(nonatomic,copy)NSString * itunesUrl;
@property(nonatomic,copy)NSString * starCurrent;
@property(nonatomic,copy)NSString * starOverall;
@property(nonatomic,copy)NSString * ratingOverall;
@property(nonatomic,copy)NSString * downloads;
@property(nonatomic,copy)NSString * currentPrice;
@property(nonatomic,copy)NSString * lastPrice;
@property(nonatomic,copy)NSString * priceTrend;
@property(nonatomic,copy)NSString * expireDatetime;
@property(nonatomic,copy)NSString * releaseNotes;
@property(nonatomic,copy)NSString * updateDate;
@property(nonatomic,copy)NSString * fileSize;
@property(nonatomic,copy)NSString * ipa;
@property(nonatomic,copy)NSString * shares;
@property(nonatomic,copy)NSString * favorites;

@property (copy,nonatomic) NSString *comment;
@property(nonatomic,copy)NSMutableArray * photos;

+ (id)appWithDict:(NSDictionary *)dict;

- (id)initWithDict:(NSDictionary *)dict;

@end
