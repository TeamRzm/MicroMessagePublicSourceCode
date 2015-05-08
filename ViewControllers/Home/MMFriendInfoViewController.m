//
//  MMFriendInfoViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/2.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMFriendInfoViewController.h"
#import "MMChatViewController.h"
#import "MMChangeRemarkViewController.h"
#import "MMFriendAccessViewController.h"
#import "MMAddGroupViewController.h"
#import "MMChangePasswordViewController.h"
#import "MMChangeTelephoneViewController.h"



@interface MMFriendInfoViewController ()
{
    BOOL isAllow;
    NSMutableArray *selectImages;
    NSMutableArray *selectTitles;
    
    UILabel *userNameLable;
}

@end

@implementation MMFriendInfoViewController
@synthesize friendId;
@synthesize isSelf;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"个人资料"];
    
    selectImages = [[NSMutableArray alloc] initWithObjects:@"dropmenu_ico_write",@"dropmenu_ico_viewoff", @"dropmenu_ico_send", @"dropmenu_ico_delete",  nil];
    selectTitles = [[NSMutableArray alloc] initWithObjects:@"设置备注",@"有圈权限",@"发送名片",@"删除此人", nil];
    
    MMFriendEntity *subFriend = [[MMFriendEntity alloc] init];
    [subFriend setNickName:@"卖萌的白熊"];
    [subFriend setMicroName:@"微用号：zhezhenc"];
    [subFriend setAvterURL:@"t_avter_1"];
    [subFriend setLocationInfo:@"湖南 长沙"];
    [subFriend setSignMessage:@"无际的黑夜需要被照耀的星辰"];
    
    
    isAllow = NO;
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    self.tableView.tableHeaderView = [self CreateInfoView:subFriend];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeRemark:) name:@"ChangeRemark_Notifiy" object:nil];
    
    if (isSelf)
    {
        [self CreateFooterView];
    }
    else
    {
        [self SetBaseNavigationRightItem:@"header_btn_list"];

    }
    
    

}

#pragma mark notify Method
-(void) ChangeRemark:(NSNotification *) _notify
{
    [userNameLable setText:_notify.object];
}

-(UIView *) CreateInfoView:(MMFriendEntity *) _entity
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, 200.0f)];
    [contentView setBackgroundColor:[UIColor clearColor]];
    
    //头像
    EGOImageView *avterImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(kMM_SCREEN_W/2-25.0f, 40, 50, 50)];
    avterImageView.placeholderImage = [UIImage imageNamed:_entity.avterURL];
    avterImageView.image = [UIImage imageNamed:_entity.avterURL];
    avterImageView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
    avterImageView.layer.borderWidth = 1.0f;
    [contentView addSubview:avterImageView];
    
    //昵称
    userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, avterImageView.frame.size.height+avterImageView.frame.origin.y, kMM_SCREEN_W, 30)];
    userNameLable.font = [UIFont boldSystemFontOfSize:16.0f];
    userNameLable.textColor = kMM_ProjectColor_DeepGray;
    userNameLable.textAlignment = NSTextAlignmentCenter;
    userNameLable.text = _entity.nickName;
    [contentView addSubview:userNameLable];
    
    //    微用号
    UILabel *MicroNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, userNameLable.frame.size.height+userNameLable.frame.origin.y, kMM_SCREEN_W, 20)];
    MicroNameLable.font = [UIFont boldSystemFontOfSize:12.0f];
    MicroNameLable.textColor = kMM_ProjectColor_MidGray;
    MicroNameLable.textAlignment = NSTextAlignmentCenter;
    MicroNameLable.text = _entity.microName;
    [contentView addSubview:MicroNameLable];
    
    //    签名
    UIImageView *linerow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_line"]];
    [linerow setFrame:CGRectMake(10.0f, MicroNameLable.frame.origin.y+MicroNameLable.frame.size.height, kMM_SCREEN_W-20.0f, 14.0f)];
    [contentView addSubview:linerow];
    
    UILabel *signNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, linerow.frame.size.height+linerow.frame.origin.y, kMM_SCREEN_W, 40)];
    signNameLable.font = [UIFont boldSystemFontOfSize:14.0f];
    signNameLable.textColor = kMM_ProjectColor_MidGray;
    signNameLable.textAlignment = NSTextAlignmentCenter;
    signNameLable.text = _entity.signMessage;
    [contentView addSubview:signNameLable];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10.0f, signNameLable.frame.origin.y+signNameLable.frame.size.height, kMM_SCREEN_W-20.0f, 0.5f)];
    [line setBackgroundColor:kMM_ProjectColor_LightGray];
    [contentView addSubview:line];
    
    //    位置信息
    
    UILabel *locationLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, line.frame.size.height+line.frame.origin.y, kMM_SCREEN_W, 40)];
    locationLable.font = [UIFont boldSystemFontOfSize:14.0f];
    locationLable.textColor = kMM_ProjectColor_MidGray;
    locationLable.textAlignment = NSTextAlignmentCenter;
    locationLable.text = _entity.locationInfo;
    [contentView addSubview:locationLable];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10.0f, locationLable.frame.origin.y+locationLable.frame.size.height, kMM_SCREEN_W-20.0f, 0.5f)];
    [line1 setBackgroundColor:kMM_ProjectColor_LightGray];
    [contentView addSubview:line1];
    
    [contentView setFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, line1.frame.origin.y+line1.frame.size.height)];
    return contentView;
}

-(void) CreateFooterView
{
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, 300.0f)];
    [footview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *changepwbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [changepwbt setBackgroundColor:kMM_ProjectColor_LightGreen];
    [changepwbt setFrame:CGRectMake(20.0f, 20.0f, kMM_SCREEN_W-40.0f, 40.0f)];
    [changepwbt.layer setCornerRadius:4.0f];
    [changepwbt setTitle:@"修改登录密码" forState:UIControlStateNormal];
    [changepwbt addTarget:self action:@selector(ChangePassWord:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:changepwbt];
    
    UIButton *changetellbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [changetellbt setBackgroundColor:kMM_ProjectColor_LightGreen];
    [changetellbt setFrame:CGRectMake(20.0f, 80.0f, kMM_SCREEN_W-40.0f, 40.0f)];
    [changetellbt.layer setCornerRadius:4.0f];
    [changetellbt setTitle:@"修改电话号码" forState:UIControlStateNormal];
    [changetellbt addTarget:self action:@selector(ChangeTell:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:changetellbt];
    
    [self.tableView setTableFooterView:footview];
    
    
}

#pragma mark tableview delegate

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSelf)
    {
        return 0;
    }
    return 4;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    switch (indexPath.row)
    {
        case 0:
        {
            for (int i = 0; i<4; i++)
            {
                //头像
                EGOImageView *avterImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(5+i*(5+(kMM_SCREEN_W-25)/4), 15, (kMM_SCREEN_W-25)/4, (kMM_SCREEN_W-25)/4)];
                avterImageView.placeholderImage = [UIImage imageNamed:[NSString stringWithFormat:@"t_avter_%d",i]];
                avterImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"t_avter_%d",i]];
                avterImageView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
                avterImageView.layer.borderWidth = 1.0f;
                [cell.contentView addSubview:avterImageView];
                [avterImageView setTag:i];
                [avterImageView setUserInteractionEnabled:YES];
                
                UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AvterImageClicked:)];
                [avterImageView addGestureRecognizer:gesture];
            }
        }
            break;
            
        case 1:
        {
            UIButton *messagebt = [UIButton buttonWithType:UIButtonTypeCustom];
            [messagebt setBackgroundColor:kMM_ProjectColor_StandBlue];
            [messagebt setFrame:CGRectMake(20.0f, 5.0f, kMM_SCREEN_W-40.0f, 40.0f)];
            [messagebt setTitle:@"消息免打扰" forState:UIControlStateNormal];
            [messagebt.layer setCornerRadius:4.0f];
            [cell.contentView addSubview:messagebt];
            
            UIButton *actionbt = [UIButton buttonWithType:UIButtonTypeCustom];
            [actionbt setBackgroundImage:[UIImage imageNamed:@"btn_switchoff"] forState:UIControlStateNormal];
            [actionbt setFrame:CGRectMake(messagebt.frame.origin.x+messagebt.frame.size.width-40.0f, 14.0f, 32.0f, 23.0f)];
            [actionbt addTarget:self action:@selector(IsAllowDistube:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:actionbt];
            
        }
            break;
        case 2:
        {
            UIButton *sendmessagebt = [UIButton buttonWithType:UIButtonTypeCustom];
            [sendmessagebt setBackgroundColor:kMM_ProjectColor_StandBlue];
            [sendmessagebt setFrame:CGRectMake(20.0f, 10.0f, kMM_SCREEN_W-40.0f, 40.0f)];
            [sendmessagebt.layer setCornerRadius:4.0f];
            [sendmessagebt setTitle:@"发送消息" forState:UIControlStateNormal];
            [sendmessagebt addTarget:self action:@selector(SendNewMessage:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:sendmessagebt];

        }
            break;
            
        case 3:
        {
            UIButton *sendmessagebt = [UIButton buttonWithType:UIButtonTypeCustom];
            [sendmessagebt setBackgroundColor:kMM_ProjectColor_StandBlue];
            [sendmessagebt setFrame:CGRectMake(20.0f, 10.0f, kMM_SCREEN_W-40.0f, 40.0f)];
            [sendmessagebt.layer setCornerRadius:4.0f];
            [sendmessagebt setTitle:@"加为好友" forState:UIControlStateNormal];
            [sendmessagebt addTarget:self action:@selector(AddToLoveFriend:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:sendmessagebt];
            
        }
            break;
            
        default:
            break;
    }
    return cell;
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return  (kMM_SCREEN_W-25)/4+30;
            break;
            
        default:
            return 50.0f;
            break;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma  mark MMTypeListView delegate
-(void)MMTypeListViewClickedWithIndex:(NSInteger)index
{
    NSLog(@"index == %d",index);
    
    [self MMTypeListViewCancel];
    
    switch (index)
    {
        case 0:
        {
            MMChangeRemarkViewController *changeview = [[MMChangeRemarkViewController alloc] init];
            [changeview setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:changeview animated:YES];
            return;
        }
            break;
        case 1:
        {
            MMFriendAccessViewController *accessview = [[MMFriendAccessViewController alloc] init];
            [accessview setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:accessview animated:YES];
            return;
        }
            break;
        case 2:
        {
            MMAddGroupViewController *accessview = [[MMAddGroupViewController alloc] init];
            [accessview setIsSendKard:YES];
            [accessview setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:accessview animated:YES];
            return;
        }
            break;
            
        case 3:
        {
            SIAlertView *alertview = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"若将Ta删除，你们将从彼此的友录中消失"];
            [alertview addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
            [alertview addButtonWithTitle:@"删除" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertview){}];
            [alertview show];
            
            
            return;
        }
            break;
            
            
        default:
            break;
    }

    
}

-(void)MMTypeListViewCancel
{
    [_listView removeFromSuperview];
    _listView = nil;
    
}



#pragma mark Sender Method


-(void) AvterImageClicked:(UITapGestureRecognizer *) _gesture
{
    
}

-(void) IsAllowDistube: (UIButton *) sender
{
    isAllow = !isAllow;
    if (isAllow)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"btn_switchon"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"btn_switchoff"] forState:UIControlStateNormal];
    }
}

-(void) SendNewMessage: (UIButton *) sender
{
    MMChatViewController *chatview = [[MMChatViewController alloc] init];
    [chatview setTargetName:@"卖萌的白熊"];
    [chatview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chatview animated:YES];
}
-(void) AddToLoveFriend: (UIButton *) sender
{
    
}

-(void) ChangePassWord: (UIButton *) sender
{
    MMChangePasswordViewController *changepwview = [[MMChangePasswordViewController alloc] init];
    [changepwview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:changepwview animated:YES];
}

-(void) ChangeTell: (UIButton *) sender
{
    MMChangeTelephoneViewController *changetellview = [[MMChangeTelephoneViewController alloc] init];
    [changetellview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:changetellview animated:YES];
}

-(void)BaseNavigatinRightItemClicked:(UIButton *)sender
{
    if (_listView)
    {
        [_listView removeFromSuperview];
        _listView = nil;
    }
    else
    {
        
        _listView = [[MMTypeListView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, kMM_SCREEN_H) withTitls:selectTitles withImages:selectImages];
        [_listView setDelegate:self];
        [self.view addSubview:_listView];
    }
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
