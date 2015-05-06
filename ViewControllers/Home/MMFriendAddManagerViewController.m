//
//  MMFriendAddManagerViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/2.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMFriendAddManagerViewController.h"

@interface MMFriendAddManagerViewController ()
{
    UISearchBar *_searchbar;
    NSMutableArray *_inviteArr;
    NSMutableArray *_resultArr;
    UISearchDisplayController *_searchcontroller;
    
}

@end

@implementation MMFriendAddManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"新的朋友"];
    
    _resultArr = [[NSMutableArray alloc] init];
    
    [self InitSearchBarView];
    [_searchbar setPlaceholder:@"微用号，手机号"];
    
    [self SetBaseNavigationRightItemWithTitle:@"添加朋友"];
    
    _inviteArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++)
    {
        InviteFriendEntity *subfriend = [[InviteFriendEntity alloc] init];
        [subfriend setNickname:@"阿九"];
        [subfriend setInviteMessage:@"我是阿九，请求加为好友"];
        [subfriend setAvterURL:[NSString stringWithFormat:@"t_avter_%d",i]];
        //0表示，表示添加，1接受， 2添加
        [subfriend setInviteState:[NSString stringWithFormat:@"%d",i%3]];
        [_inviteArr addObject:subfriend];
        
    }
    [self.tableView setRowHeight:60.0f];
    
    
    
    
}

#pragma mark override  Method
-(void)BaseNavigatinRightItemClicked:(UIButton *)sender
{
    [super BaseNavigatinRightItemClicked:sender];
    //
}

#pragma mark tableivew delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView != self.tableView)
    {
        return [_resultArr count];
    }
    return [_inviteArr count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    InviteFriendEntity *subEntity = _inviteArr[indexPath.row];
    if (tableView != self.tableView)
    {
        subEntity = _resultArr[indexPath.row];
    }
    
    //头像
    EGOImageView *avterImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    avterImageView.placeholderImage = [UIImage imageNamed:subEntity.avterURL];
    avterImageView.image = [UIImage imageNamed:subEntity.avterURL];
    avterImageView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
    avterImageView.layer.borderWidth = 1.0f;
    [cell.contentView addSubview:avterImageView];
    
    //用户名
    UILabel *userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200.0f, 20)];
    userNameLable.font = [UIFont boldSystemFontOfSize:13.0f];
    userNameLable.textColor = kMM_ProjectColor_DeepGray;
    userNameLable.text = subEntity.nickname;
    [cell.contentView addSubview:userNameLable];
    
    //消息
    UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 35, kMM_SCREEN_W-80.0f, 20)];
    contentLable.font = [UIFont systemFontOfSize:12.0f];
    contentLable.textColor = [UIColor lightGrayColor];
    contentLable.text = subEntity.inviteMessage;
    [cell.contentView addSubview:contentLable];
    
    //状态
    UIButton *statebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [statebutton setFrame:CGRectMake(kMM_SCREEN_W-80.0f, 12.0f, 60.0f, 35.0f)];
    [statebutton.titleLabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:14.0f]];
    [statebutton addTarget:self action:@selector(InvitStateClicked:) forControlEvents:UIControlEventTouchUpInside];
    [statebutton setTag:indexPath.row];
    [statebutton.layer setCornerRadius:4.0f];
    switch ([subEntity.inviteState intValue])
    {
        case 0:
        {
            [statebutton setTitle:@"已添加" forState:UIControlStateNormal];
            [statebutton setTitleColor:kMM_ProjectColor_MidGray forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            [statebutton setTitle:@"接受" forState:UIControlStateNormal];
            [statebutton setTitleColor:kMM_ProjectColor_StandWhite forState:UIControlStateNormal];
            [statebutton setBackgroundColor:kMM_ProjectColor_StandGreen];
            
        }
            break;
        case 2:
        {
            [statebutton setTitle:@"添加" forState:UIControlStateNormal];
            [statebutton setTitleColor:kMM_ProjectColor_StandWhite forState:UIControlStateNormal];
            [statebutton setBackgroundColor:kMM_ProjectColor_DeepGray];
            
        }
            break;
            
        default:
            break;
    }
    [cell.contentView addSubview:statebutton];
    return cell;

}

-(void) InvitStateClicked:(UIButton *) Sender
{
    InviteFriendEntity *subEntity = [_inviteArr objectAtIndex:Sender.tag];
    if (![subEntity.inviteState isEqualToString:@"0"])
    {
        subEntity.inviteState = @"0";
    }
    [self.tableView reloadData];
}

#pragma mark searchbar delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"text == %@",searchBar.text);
    [_resultArr removeAllObjects];
    //重新添加数据
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
