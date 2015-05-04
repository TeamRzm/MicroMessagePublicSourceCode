//
//  MMHomeViewController.m
//  MicroMessage
//
//  Created by Martin.Ren on 15/4/23.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMHomeViewController.h"
#import "ConversationEntity.h"
#import "MMFriendAddManagerViewController.h"
#import "MMShakeViewController.h"
#import "MMChatViewController.h"
#import "MMFriendInfoViewController.h"



#define MM_SCRREN_W [UIScreen mainScreen].bounds.size.width
#define MM_SCRREN_H [UIScreen mainScreen].bounds.size.height

@interface MMHomeViewController ()
{
    NSMutableArray  *tableViewDataSource;
    UIView *newbgview;
    
}
@end

@implementation MMHomeViewController


#pragma  mark init Method

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微用";
    // Do any additional setup after loading the view.
    tableViewDataSource = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 9; i++)
    {
        ConversationEntity *entity = [[ConversationEntity alloc] init];
        entity.avterURL = [NSString stringWithFormat:@"t_avter_%d",i];
        entity.lastMessage = @"我们明天一起去钓鱼吧？";
        entity.userName = @"阿三";
        entity.sendData = @"下午15:33";
        
        [tableViewDataSource addObject:entity];
    }
    
    [self SetBaseNavigationRightItem:@"btn_add"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark tableview delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableViewDataSource.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ConversationEntity *subEntity = tableViewDataSource[indexPath.row];
    
    //头像
    EGOImageView *avterImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    avterImageView.placeholderImage = [UIImage imageNamed:subEntity.avterURL];
    avterImageView.image = [UIImage imageNamed:subEntity.avterURL];
    avterImageView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
    avterImageView.layer.borderWidth = 1.0f;
    [cell.contentView addSubview:avterImageView];
    [avterImageView setTag:indexPath.row];
    [avterImageView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AvterImageClicked:)];
    [avterImageView addGestureRecognizer:gesture];
    
    
    
    //用户名
    UILabel *userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, MM_SCRREN_W, 20)];
    userNameLable.font = [UIFont boldSystemFontOfSize:13.0f];
    userNameLable.textColor = kMM_ProjectColor_DeepGray;
    userNameLable.text = subEntity.userName;
    [cell.contentView addSubview:userNameLable];
    
    //消息
    UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 35, MM_SCRREN_W, 20)];
    contentLable.font = [UIFont systemFontOfSize:12.0f];
    contentLable.textColor = [UIColor lightGrayColor];
    contentLable.text = subEntity.lastMessage;
    [cell.contentView addSubview:contentLable];
    
    //日期
    UILabel *datetimelabel = [[UILabel alloc] initWithFrame:CGRectMake(MM_SCRREN_W-100, 5, 80.0f, 20)];
    datetimelabel.font = [UIFont systemFontOfSize:12.0f];
    [datetimelabel setTextAlignment:NSTextAlignmentRight];
    datetimelabel.textColor = [UIColor lightGrayColor];
    datetimelabel.text = subEntity.sendData;
    [cell.contentView addSubview:datetimelabel];

    
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConversationEntity *subEntity = tableViewDataSource[indexPath.row];
    MMChatViewController *chatview = [[MMChatViewController alloc] init];
    [chatview setTargetName:subEntity.userName];
    [chatview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:chatview animated:YES];
}

#pragma  mark  add Method

-(void)BaseNavigatinRightItemClicked:(UIButton *)sender
{
    if (newbgview)
    {
        [newbgview removeFromSuperview];
        newbgview = nil;
    }
    else
    {
        newbgview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, kMM_SCREEN_H)];
        [newbgview setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:newbgview];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RemoveNewBgview)];
        [newbgview addGestureRecognizer:gesture];
        
        
        UIView *bgview = [[UIView alloc] initWithFrame:newbgview.frame];
        [bgview setBackgroundColor:[UIColor darkGrayColor]];
        [bgview setAlpha:0.7];
        [newbgview addSubview:bgview];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(kMM_SCREEN_W/2-20.0f, 0.0f, 40.0f, 20.0f)];
        [imageview setImage:[UIImage imageNamed:@"ico_dropmenu"]];
        [newbgview addSubview:imageview];
        
        //添加好友视图
        UIButton *newfriendbt = [UIButton buttonWithType:UIButtonTypeCustom];
        [newfriendbt setFrame:CGRectMake(kMM_SCREEN_W/2.0f-70.0f, 10.0f, 30.0f, 30.0f)];
        [newfriendbt setBackgroundColor:[UIColor clearColor]];
        [newfriendbt setImage:[UIImage imageNamed:@"ico_dropmenu_add"] forState:UIControlStateNormal];
        [newfriendbt addTarget:self action:@selector(NewFriendAddClicked:) forControlEvents:UIControlEventTouchUpInside];
        [newbgview addSubview:newfriendbt];
        
        UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(newfriendbt.frame.origin.x-10.0f, newfriendbt.frame.origin.y+newfriendbt.frame.size.height, 50.0f, 20.0f)];
        [titlelb setBackgroundColor:[UIColor clearColor]];
        [titlelb setText:@"加好友"];
        [titlelb setTextColor:[UIColor whiteColor]];
        [titlelb setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:14.0f]];
        [titlelb setTextAlignment:NSTextAlignmentCenter];
        [newbgview addSubview:titlelb];
        
        //扫一扫视图
        UIButton *scanfriendbt = [UIButton buttonWithType:UIButtonTypeCustom];
        [scanfriendbt setFrame:CGRectMake(kMM_SCREEN_W/2.0f-15.0f, newfriendbt.frame.origin.y+newfriendbt.frame.size.height-10.0f, 30.0f, 30.0f)];
        [scanfriendbt setBackgroundColor:[UIColor clearColor]];
        [scanfriendbt setImage:[UIImage imageNamed:@"ico_dropmenu_scan"] forState:UIControlStateNormal];
        [scanfriendbt addTarget:self action:@selector(ScanFriendAddClicked:) forControlEvents:UIControlEventTouchUpInside];
        [newbgview addSubview:scanfriendbt];
        
        UILabel *scantitlelb = [[UILabel alloc] initWithFrame:CGRectMake(scanfriendbt.frame.origin.x-10.0f, scanfriendbt.frame.origin.y+scanfriendbt.frame.size.height, 50.0f, 20.0f)];
        [scantitlelb setBackgroundColor:[UIColor clearColor]];
        [scantitlelb setText:@"扫一扫"];
        [scantitlelb setTextColor:[UIColor whiteColor]];
        [scantitlelb setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:14.0f]];
        [scantitlelb setTextAlignment:NSTextAlignmentCenter];
        [newbgview addSubview:scantitlelb];
        
        
        //摇一摇视图
        UIButton *shakefriendbt = [UIButton buttonWithType:UIButtonTypeCustom];
        [shakefriendbt setFrame:CGRectMake(kMM_SCREEN_W/2.0f+40.0f, 10.0f, 30.0f, 30.0f)];
        [shakefriendbt setBackgroundColor:[UIColor clearColor]];
        [shakefriendbt setImage:[UIImage imageNamed:@"ico_dropmenu_shake"] forState:UIControlStateNormal];
        [shakefriendbt addTarget:self action:@selector(ShakeFriendAddClicked:) forControlEvents:UIControlEventTouchUpInside];
        [newbgview addSubview:shakefriendbt];
        
        UILabel *shaketitlelb = [[UILabel alloc] initWithFrame:CGRectMake(shakefriendbt.frame.origin.x-10.0f, shakefriendbt.frame.origin.y+shakefriendbt.frame.size.height, 50.0f, 20.0f)];
        [shaketitlelb setBackgroundColor:[UIColor clearColor]];
        [shaketitlelb setText:@"摇一摇"];
        [shaketitlelb setTextColor:[UIColor whiteColor]];
        [shaketitlelb setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:14.0f]];
        [shaketitlelb setTextAlignment:NSTextAlignmentCenter];
        [newbgview addSubview:shaketitlelb];
        
    }

}

#pragma mark sender Method

-(void) AvterImageClicked:(UITapGestureRecognizer *) _gesture
{
    ConversationEntity *subEntity = tableViewDataSource[_gesture.view.tag];
    NSLog(@"goto friend info = %@",subEntity.userName);
    MMFriendInfoViewController *infoview = [[MMFriendInfoViewController alloc] init];
    [infoview setFriendId:subEntity.userName];
    [infoview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:infoview animated:YES];
    
}
-(void) NewFriendAddClicked:(UIButton *) sender
{
    [self RemoveNewBgview];
    MMFriendAddManagerViewController *friendmgview = [[MMFriendAddManagerViewController alloc] init];
    [friendmgview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:friendmgview animated:YES];
    
}
-(void) ScanFriendAddClicked:(UIButton *) sender
{
    [self RemoveNewBgview];
}
-(void) ShakeFriendAddClicked:(UIButton *) sender
{
    [self RemoveNewBgview];
    MMShakeViewController *shakeview = [[MMShakeViewController alloc] init];
    [shakeview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:shakeview animated:YES];
    
}

-(void) RemoveNewBgview
{
    if (newbgview)
    {
        [newbgview removeFromSuperview];
        newbgview = nil;
    }
}




@end
