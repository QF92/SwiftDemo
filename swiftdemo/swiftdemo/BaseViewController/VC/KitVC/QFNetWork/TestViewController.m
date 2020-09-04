//
//  TestViewController.m
//  swiftdemo
//
//  Created by qf on 2020/9/4.
//  Copyright © 2020 qf. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/// 测试用例 1
- (void)test_get_a {
    NSString *url = @"http://game.gtimg.cn/images/lol/act/img/js/heroList/hero_list.js";
    NSDictionary *dict = @{@"v": @(33)};

    [QFNetworkingOC GET:url info:@"LOL英雄列表" parameters:dict success:^(id response) {
        NSLog(@"get --> %@", response);
    } failed:^(QFNetworkingError *error) {
        NSLog(@"xxx -> %@", error.localizedDescription);
    }];
}

/// 测试用例 2
- (void)test_post_a {
    NSString *url = @"https://api.sunpig.cn/member/myDetailsNew";
    NSDictionary *dict = @{@"userId": @"02363BC2523811E68BD95CB9018916241119"};

    [QFNetworkingOC POST:url info:@"我的页面" parameters:dict success:^(id response) {
        NSLog(@"post --> %@", response);
    } failed:^(QFNetworkingError *error) {
        NSLog(@"xxx -> %@", error.localizedDescription);
    }];
}

/// 测试用例 3
- (void)test_error_a {
    NSString *url = @"https://api.sunpig.cn/member/myDetailsNew";
    NSDictionary *dict = @{@"userId": @"123"};

    [QFNetworkingOC POST:url info:@"我的页面" parameters:dict success:^(id response) {
        NSLog(@"post --> %@", response);
} failed:^(QFNetworkingError *error) {
        NSLog(@"xxx -> %@", error.localizedDescription);
    }];
}

/// 测试用例 3
- (void)test_error_b {
    NSString *url = @"https://api.sunpig.cn/member/myDetailsw";
    NSDictionary *dict = @{@"userId": @"123"};

    [QFNetworkingOC POST:url info:@"我的页面" parameters:dict success:^(id response) {
        NSLog(@"post --> %@", response);
} failed:^(QFNetworkingError *error) {
        NSLog(@"xxx -> %@", error.localizedDescription);
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
