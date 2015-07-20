//
//  JPHotListController.m
//  FreeLimit
//
//  Created by qianfeng on 15-5-3.
//  Copyright (c) 2015年 王阳. All rights reserved.
//

#import "JPHotListController.h"
#import "JPHotListView.h"

@interface JPHotListController ()

@end

@implementation JPHotListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JPHotListView * hotListView = [JPHotListView hotListViewWithNib:nil];
    [self.view addSubview:hotListView];
}

@end
