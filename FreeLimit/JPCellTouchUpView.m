//
//  JPCellTouchUpView.m
//  FreeLimit
//
//  Created by qianfeng on 15-5-1.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPCellTouchUpView.h"
#import "JPApp.h"
#import "UIKit+AFNetworking.h"

@interface JPCellTouchUpView ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *fileSizeLab;
@property (weak, nonatomic) IBOutlet UILabel *categoryLab;
@property (weak, nonatomic) IBOutlet UILabel *starCurrentLab;
//收藏按键
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
//应用截图scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//附近应用nearbyScrollView
@property (weak, nonatomic) IBOutlet UIScrollView *nearbyScrollView;

@end

@implementation JPCellTouchUpView

+ (id)cellTouchUpView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JPCellTouchUpView" owner:nil options:nil] lastObject];
}

/**
 获取到应用截图的数据
 **/
- (void)setObjs:(NSArray *)objs
{
    _objs = objs;
    [self setImages:objs];
}

/**
 *获取到附近应用的数据填充
 **/
- (void)setNearbyObjs:(NSArray *)nearbyObjs
{
    _nearbyObjs = nearbyObjs;
    CGFloat imageViewW = 50;
    CGFloat imageViewH = 50;
    CGFloat imageViewY = (self.nearbyScrollView.frame.size.height-imageViewH)*0.5;
    [self scrollView:nearbyObjs andImageW:imageViewW andScrollView:self.nearbyScrollView];
    int i = 0;
    //照片的间隔
    CGFloat space = 5;
    [self scrollView:nearbyObjs andImageW:imageViewW andScrollView:self.scrollView];
    for (JPApp * photos in nearbyObjs) {
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:[NSURL URLWithString:photos.iconUrl]];
        CGFloat imageViewX = (imageViewW + space)* i+space;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        [self setNearAppsName:photos.name  andRect:imageView.frame];
        [self.nearbyScrollView addSubview:imageView];
        i++;
    }
}

//设置附近应用的名字name
- (void)setNearAppsName:(NSString *)name andRect:(CGRect)rect
{
    if (name != nil)
    {
        CGFloat nameLabY = CGRectGetMaxY(rect)-10;
        UILabel * nameLab = [[UILabel alloc] init];
        [self.nearbyScrollView addSubview:nameLab];
        nameLab.text = name;
        [nameLab setTextAlignment:NSTextAlignmentCenter];
        nameLab.font = [UIFont systemFontOfSize:8];
        nameLab.frame = CGRectMake(rect.origin.x, nameLabY, rect.size.width, rect.size.height);
    }

}

/**设置scrollview上的image的frame**/
- (void)setImages:(NSArray *)images
{
    int i = 0;
    CGFloat imageViewY = 0;
    CGFloat imageViewH = self.scrollView.frame.size.height;
    //设置imgae的宽度
    CGFloat imageViewW = 51;
    //照片的间隔
    CGFloat space = 5;
    [self scrollView:images andImageW:imageViewW andScrollView:self.nearbyScrollView];
    for (JPPhotos * photos in images) {
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:[NSURL URLWithString:photos.smallUrl]];
        CGFloat imageViewX = (imageViewW + space)* i + space;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        [self.scrollView addSubview:imageView];
        i++;
    }
}

/**设置scrollview的属性**/
- (void)scrollView:(NSArray *)objs andImageW:(CGFloat)imageW andScrollView:(UIScrollView *)scrollView
{
    CGFloat scrollViewW = objs.count * imageW + 250;
    scrollView.contentSize = CGSizeMake(scrollViewW, 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = @"应用详情";
    //隐藏掉标签栏
    self.tabBarController.tabBar.hidden = YES;
}

/**设置应用截图界面上的应用简介**/
- (void)setApps:(JPApp *)apps
{
    [self.iconImage setImageWithURL:[NSURL URLWithString:apps.iconUrl]];
    self.nameLab.text = apps.name;
    self.priceLab.text = [NSString stringWithFormat:@"原价$%@限免中",apps.lastPrice];
    self.fileSizeLab.text = [NSString stringWithFormat:@"%@MB",apps.fileSize];
    self.categoryLab.text = [NSString stringWithFormat:@"类型:%@",apps.categoryName];
    self.starCurrentLab.text = [NSString stringWithFormat:@"评分:%@",apps.starCurrent];
}

#pragma mark － 点击事件处理，具体处理的事件可以使用代理交给限免控制器去处理，目前先放到这后期处理
//收藏界面点击事件
- (IBAction)collectBtnTouch:(id)sender {
    [self.collectBtn.currentTitle isEqualToString:@"收藏"]?[self.collectBtn setTitle:@"取消收藏" forState:UIControlStateNormal]:[self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
}

//分享界面点击事件
#warning 分享按键点击实现，但是分享后链接至微博、微信等界面没有实现功能
- (IBAction)shareBtnTouch:(id)sender {
    //新浪微博, 微信好友, 微信圈子,邮件,短信  取消
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博",@"微信好友",@"微信圈子",@"邮件",@"短信",nil];
    [actionSheet showInView:self.view];
}
#warning 下载界面跳转至applestore界面,尚未处理
- (IBAction)downLoadBtnTouch:(id)sender {
    NSLog(@"准备下载");
}

@end
