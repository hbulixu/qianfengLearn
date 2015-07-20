//
//  JPSpecialController.m
//  FreeLimit
//
//  Created by qianfeng on 15-5-2.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPSpecialController.h"
#import "JPSpecialView.h"
#import "MMProgressHUD.h"
#import "AFHTTPRequestOperationManager.h"
#import "JPTopic.h"

@interface JPSpecialController ()

@property (nonatomic,strong)JPSpecialView * contentView;
@end

@implementation JPSpecialController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self installLimitFreeContentView];
    
    [self startDownloadData];
}

#pragma mark - 安装视图
- (void)installLimitFreeContentView
{
    JPSpecialView * contentView = [JPSpecialView specialViewWithNib:nil];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

#pragma mark - 数据下载和解析
-(void)startDownloadData
{
    // 显示一个HUB进度表 显示....
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:nil status:@"正在加载数据"];
    
    //开始下载
    NSString *url = @"http://iappfree.candou.com:8080/free/special?page=1&limit=5";
    //NSLog(@"startDownloadData url = %@",url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //此处设置后返回的默认是NSData的数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //转化为字符串显示
        //NSString *string = [[NSString alloc] initWithData:request.downloadData encoding:NSUTF8StringEncoding];
        //NSLog(@"string = %@",string);
        
        //转换为数组数据
        NSArray *arrayJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"array = %@",array);
        
        /*
         "title": "和《星你》一起玩星星游戏",
         "date": "2014-02-26",
         "img": "http://special.candou.com/fc3b85d07e093e01da1fc5354c0fe50a.jpg",
         "desc_img": "http://special.candou.com/bc02eddd7785db5cf48087b8cac06d51.jpg",
         "desc": "小编mm推荐：追韩剧当然不能忘了玩游戏，各色星星都已在此，你准备好了啤酒和炸鸡了么？",
         "applications":
         */
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        for (NSDictionary * dict in arrayJson) {
            JPTopic * topic = [JPTopic topicWithDict:dict];
            [dataArray addObject:topic];
        }
        
//        NSLog(@"%@",tmpDataArray);
        self.contentView.arrays = dataArray;
        [MMProgressHUD dismissWithSuccess:@"成功下载了"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
