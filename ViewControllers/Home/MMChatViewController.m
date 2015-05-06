//
//  MMChatViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/2.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMChatViewController.h"
#import "MMGroupSettingViewController.h"


@interface MMChatViewController ()

@end

@implementation MMChatViewController
@synthesize targetName;
@synthesize isGroupChat;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:targetName];
    if (isGroupChat)
    {
        [self SetBaseNavigationRightItem:@"header_btn_list"];
    }
    
    
}

#pragma mark Override Method
-(void)BaseNavigatinRightItemClicked:(UIButton *)sender
{
    MMGroupSettingViewController *settingview = [[MMGroupSettingViewController alloc] init];
    [settingview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:settingview animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
