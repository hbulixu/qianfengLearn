//
//  JPFreeController.m
//  FreeLimit
//
//  Created by qianfeng on 15-5-2.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPFreeController.h"
#import "MMProgressHUD.h"
#import "AFHTTPRequestOperationManager.h"
#import "JPApp.h"
#import "JPLimitFreeContentView.h"
#import "JPCellTouchUpView.h"

@interface JPFreeController ()<JPLimitFreeContentViewDelegate>

//保存应用模型数据，在应用详情view中可以根据下标从数组中取出对应的单个模型数据
@property (nonatomic,strong)NSArray * apps;
@property (nonatomic,weak)JPLimitFreeContentView * limitFreeContentView;
@property (nonatomic,weak)JPCellTouchUpView * cellTouchUpView;
@end

@implementation JPFreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self installLimitFreeContentView];
    
    [self sendRequst];
}

#pragma mark - 安装视图
- (void)installLimitFreeContentView
{
    //1.添加限免的数据列表view视图
    JPLimitFreeContentView * limitFreeContentView = [JPLimitFreeContentView limitFreeContentViewWithNib:nil];
    [self.view addSubview:limitFreeContentView];
    limitFreeContentView.delegate = self;
    self.limitFreeContentView = limitFreeContentView;
}

#pragma mark－ 获取免费模型数据
-(void)sendRequst
{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:nil status:@"正在加载数据"];
    
    NSString *urlString = @"http://iappfree.candou.com:8080/free/applications/free?currency=rmb&page=1&category_id=";
    
    //    NSLog(@"我要了urlString = %@",urlString);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //此处设置后返回的默认是NSData的数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error;
        
        //将网路上传递回来的二进制json数据转换成字典
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (error) NSLog(@"error");
        //封装模型
        NSArray * dicts = jsonDict[@"applications"];
        NSMutableArray * objs = [NSMutableArray array];
        for (NSDictionary * dic in dicts)
        {
            JPApp * app = [JPApp appWithDict:dic];
            [objs addObject:app];
        }
        //将封装好的模型保存起来
        self.limitFreeContentView.objs = objs;
        self.apps = objs;
        [MMProgressHUD dismissWithSuccess:@"成功下载了"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
#pragma mark - 下载和解析应用的截图
-(void)startDownloadSnapshootData:(JPApp *)apps
{
    // 显示一个HUB进度表 显示....
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:nil status:@"正在加载数据"];
    
    //下载数据
    NSString *s = [NSString stringWithFormat:@"http://iappfree.candou.com:8080/free/applications/%@?currency=rmb",apps.applicationId];
    //    NSString *s = @"http://iappfree.candou.com:8080/free/applications/503264290?currency=rmb";
    //        NSLog(@"s = %@",s);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //此处设置后返回的默认是NSData的数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:s parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError * error;
        //解析下载的数据为词典数据
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (error) NSLog(@"error");
        //封装模型
        NSArray * dicts = jsonDict[@"photos"];
        NSMutableArray * objs = [NSMutableArray array];
        for (NSDictionary * dic in dicts)
        {
            /**
             *JPPhotos模型和JPApp的模型在一个类中存放，由于JPPhotos的属性包括了JPApp的属性
             **/
            JPPhotos * photos = [[JPPhotos alloc] init];
            photos.smallUrl = dic[@"smallUrl"];
            photos.originalUrl = dic[@"originalUrl"];
            [objs addObject:photos];
        }
        
        self.cellTouchUpView.objs = objs;
        //显示进度提示
        [MMProgressHUD dismissWithSuccess:@"成功下载了"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - 下载和解析附近应用数据
-(void)startDownloadNearbyData:(JPApp *)apps
{
    // 显示一个HUB进度表 显示....
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:nil status:@"正在加载数据"];
    
    //下载附近使用数据 longitude=%lf&latitude=%lf
    NSString *nearbyUrl = @"http://iappfree.candou.com:8080/free/applications/recommend?longitude=116.344539&latitude=40.034346";//[NSString stringWithFormat:NEARBY_APP_URL, longitude, latitude];
    //NSLog(@"nearbyUrl = %@",nearbyUrl);
    
    
    //网络下载数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //此处设置后返回的默认是NSData的数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:nearbyUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error;
        //转换为词典数据
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"nearby dict = %@",dict);
        if (error) NSLog(@"error");
        //封装模型
        apps.des = jsonDict[@"description"];
        NSArray * dicts = jsonDict[@"applications"];
        NSMutableArray * objs = [NSMutableArray array];
        for (NSDictionary * dic in dicts)
        {
            JPApp * photos = [JPApp appWithDict:dic];
            [objs addObject:photos];
        }
        
        //        NSLog(@"%@",objs);
        self.cellTouchUpView.nearbyObjs = objs;
        //显示进度提示
        [MMProgressHUD dismissWithSuccess:@"成功下载了"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
/**在进入应用详情界面时隐藏掉tabbar之后，退出详情界面打开tabbar**/
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - limitFreeContentView代理事件
- (void)cellTouchUp:(NSInteger)row
{
    JPCellTouchUpView * cellTouchUpView = [JPCellTouchUpView cellTouchUpView];
    cellTouchUpView.apps = self.apps[row];
    self.cellTouchUpView = cellTouchUpView;
    //调用应用截图数据的方法
    [self startDownloadSnapshootData:self.apps[row]];
    //调用附近应用数据的方法
    [self startDownloadNearbyData:self.apps[row]];
    //push应用详情界面
    [self.navigationController pushViewController:cellTouchUpView animated:YES];
}


@end
