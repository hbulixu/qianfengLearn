//
//  JPSpeciallAppCell.m
//  FreeLimit
//
//  Created by qianfeng on 15-5-2.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPSpeciallAppCell.h"
#import "JPTopic.h"
#import "JPApp.h"
#import "UIKit+AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface JPSpeciallAppCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *descImage;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
/**右边应用小图标**/
//第一组
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UILabel *downLoadLab;
//第二组
@property (weak, nonatomic) IBOutlet UIImageView *iconImage1;
@property (weak, nonatomic) IBOutlet UILabel *nameLab1;
@property (weak, nonatomic) IBOutlet UILabel *commentLab1;
@property (weak, nonatomic) IBOutlet UILabel *downLoad1;
//第三组
@property (weak, nonatomic) IBOutlet UIImageView *iconImage2;
@property (weak, nonatomic) IBOutlet UILabel *nameLab2;
@property (weak, nonatomic) IBOutlet UILabel *commentLab2;
@property (weak, nonatomic) IBOutlet UILabel *downLoad2;
//第四组
@property (weak, nonatomic) IBOutlet UIImageView *iconImage3;
@property (weak, nonatomic) IBOutlet UILabel *nameLab3;
@property (weak, nonatomic) IBOutlet UILabel *commentLab3;
@property (weak, nonatomic) IBOutlet UILabel *downLoad3;

@end

@implementation JPSpeciallAppCell


+ (id)speciallAppCellWithTableView:(UITableView *)tableView
{
    JPSpeciallAppCell * cell = [tableView dequeueReusableCellWithIdentifier:@"speciall"];
    if (cell == nil) {
        UINib * nib = [UINib nibWithNibName:@"JPSpeciallAppCell" bundle:nil];
        //为了重用cell，必须先注册一下
        [tableView registerNib:nib forCellReuseIdentifier:@"appcell"];
        cell = [[nib instantiateWithOwner:nil options:nil] lastObject];
    }
    return cell;
}

/**填充数据到视图中***/
- (void)setTopics:(JPTopic *)topics
{
    _topics = topics;
    self.titleLab.text = topics.title;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:topics.img]];
    [self.descImage setImageWithURL:[NSURL URLWithString:topics.desc_img]];
    self.descLab.text = topics.desc;
    
    [self stuffRightMessage];

}

/**填充右边模型数据到视图中去***/
- (void)stuffRightMessage
{
#warning - 如何能将取出的字符串转换成之前的对象
    /**这一块考虑优化：可以将所有关联至xib的属性保存字典的形式，通过key取出含有属性对象的数组，在通过下标取出对象的对象，加入到for循环中
     存在的问题：要以字符串的形式保存，当通过下标取出的时候是一个字符串而非原来的属性对象，在转换成相对应的对象时会创建新的对象而非原来的？
     问题：如何能将取出的字符串转换成之前的对象
     NSDictionary * dict = @{@"name":@[@"self.nameLab",@"self.nameLab1"]};
     NSArray * nameArray = dict[@"name"];
     UILabel * label = nameArray[0];
     JPApp * apps = topics.applications[0];
     [self stuffRightView:apps andName:label andDownLoad:self.downLoadLab andComment:self.commentLab andIconImage:self.iconImage];
     **/
    
    JPApp * apps = self.topics.applications[0];
    [self stuffRightView:apps andName:self.nameLab andDownLoad:self.downLoadLab andComment:self.commentLab andIconImage:self.iconImage];
    JPApp * apps1 = self.topics.applications[1];
    [self stuffRightView:apps1 andName:self.nameLab1 andDownLoad:self.downLoad1 andComment:self.commentLab1 andIconImage:self.iconImage1];
    JPApp * apps2 = self.topics.applications[2];
    [self stuffRightView:apps2 andName:self.nameLab2 andDownLoad:self.downLoad2 andComment:self.commentLab2 andIconImage:self.iconImage2];
    JPApp * apps3 = self.topics.applications[3];
    [self stuffRightView:apps3 andName:self.nameLab3 andDownLoad:self.downLoad3 andComment:self.commentLab3 andIconImage:self.iconImage3];
}

/***将右边的四个小应用的赋值封装起来***/
- (void)stuffRightView:(JPApp *)apps andName:(UILabel *)name andDownLoad:(UILabel *)download andComment:(UILabel *)comment andIconImage:(UIImageView *)iconImage
{
    [iconImage setImageWithURL:[NSURL URLWithString:apps.iconUrl]];
    name.text = apps.name;
    download.text = apps.downloads;
    comment.text = apps.downloads;
}

@end
