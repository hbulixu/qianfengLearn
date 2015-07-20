//
//  JPLimitFreeAppCell.m
//  FreeLimit
//
//  Created by qianfeng on 15-4-30.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPLimitFreeAppCell.h"
#import "JPApp.h"
#import "UIKit+AFNetworking.h"

@interface JPLimitFreeAppCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sharesLab;
@property (weak, nonatomic) IBOutlet UILabel *favoritesLab;
@property (weak, nonatomic) IBOutlet UILabel *downloadsLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *categoryLab;
@property (readonly, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


//标记传进来的模型数据对象在存储所有模型数组中的位置
@property (assign, nonatomic) NSInteger indexCount;
@end

@implementation JPLimitFreeAppCell

+ (id)limitFreeAppCellWithTableView:(UITableView *)tableView
{
    JPLimitFreeAppCell * cell = [tableView dequeueReusableCellWithIdentifier:@"appcell"];
    if (cell == nil) {
        UINib * nib = [UINib nibWithNibName:@"JPLimitFreeAppCell" bundle:nil];
        //为了重用cell，必须先注册一下
        [tableView registerNib:nib forCellReuseIdentifier:@"appcell"];
        cell = [[nib instantiateWithOwner:nil options:nil] lastObject];
    }
    
    return cell;
}

+ (id)limitFreeAppCellWithTableView:(UITableView *)tableView andObject:(id)model
{
    JPLimitFreeAppCell * cell = [JPLimitFreeAppCell limitFreeAppCellWithTableView:tableView];
    cell.app = model;
    return cell;
}

- (void)reprotsIndex:(NSInteger)index
{
    self.indexCount = index;
}

- (void)setApp:(JPApp *)app
{
    _app = app;
#warning 需要根据模型数据填充内部子控件数据
    [self.iconImage setImageWithURL:[NSURL URLWithString:app.iconUrl]];
    self.nameLab.text = [NSString stringWithFormat:@"%ld.%@",self.indexCount+1,app.name];
    self.sharesLab.text = [NSString stringWithFormat:@"分享%@",app.shares];
    self.favoritesLab.text = [NSString stringWithFormat:@"收藏%@",app.favorites];
    self.downloadsLab.text = [NSString stringWithFormat:@"下载%@",app.downloads];
    self.priceLab.text = app.lastPrice;
    self.categoryLab.text = app.categoryName;
    [self setStarsNumber:app.starCurrent.intValue andUIImage:[UIImage imageNamed:@"StarsForeground"]];
}

/**裁剪星星按照接收到的数据长度**/
- (void)setStarsNumber:(int)count andUIImage:(UIImage *)image
{
    UIImageView * imageView = [[UIImageView alloc] init];
    CGRect rect = self.backgroundImageView.frame;
    CGFloat imageViewW = rect.size.width*(count*0.2);
    CGRect imageRect = CGRectMake(rect.origin.x, rect.origin.y, imageViewW, rect.size.height);
    CGImageRef newImage = CGImageCreateWithImageInRect([image CGImage], imageRect);
//    imageView.image = [UIImage imageWithCGImage:newImage];
    [imageView setImage:[UIImage imageWithCGImage:newImage]];
    imageView.frame = imageRect;
//    imageView.backgroundColor = [UIColor blueColor];
//    NSLog(@"%d",count);
    [self.contentView addSubview:imageView];
    
}
@end
