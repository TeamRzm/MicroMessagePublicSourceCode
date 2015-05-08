//
//  MMPublishViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/7.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMPublishViewController.h"

@interface MMPublishViewController ()
{
    UIButton *selectedbutton;
}
@end

@implementation MMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"发布"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableivew delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(indexPath.row)
    {
        UILabel *citylabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 7.0f, 100.0f, 30.0f)];
        [citylabel setTextColor:[UIColor blackColor]];
        [citylabel setBackgroundColor:[UIColor clearColor]];
        [citylabel setText:@"目的"];
        [cell.contentView addSubview:citylabel];
        
        //是否选择
        UIButton *selectbt = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectbt setFrame:CGRectMake(20.0f, 37.0f, 30.0f, 30.0f)];
        [selectbt setBackgroundImage:[UIImage imageNamed:@"btn_chose_pressed"] forState:UIControlStateNormal];
        [selectbt setTag:[[NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row] intValue]];
        
        [selectbt addTarget:self action:@selector(isPublishFriendInfo:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:selectbt];
        selectedbutton = selectbt;
        
        
        
        UILabel *friendlabel = [[UILabel alloc] initWithFrame:CGRectMake(selectbt.frame.origin.x+selectbt.frame.size.width+10.0f, selectbt.frame.origin.y, 100.0f, 30.0f)];
        [friendlabel setTextColor:kMM_ProjectColor_StandBlue];
        [friendlabel setBackgroundColor:[UIColor clearColor]];
        [friendlabel setText:@"发布交友"];
        [cell.contentView addSubview:friendlabel];
        
        //是否选择
        UIButton *marrybt = [UIButton buttonWithType:UIButtonTypeCustom];
        [marrybt setFrame:CGRectMake(selectbt.frame.origin.x, selectbt.frame.origin.y+selectbt.frame.size.height+10.0f, 30.0f, 30.0f)];
        [marrybt setBackgroundImage:[UIImage imageNamed:@"btn_chose_nor"] forState:UIControlStateNormal];
        [marrybt setTag:[[NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row] intValue]];
        [cell.contentView addSubview:marrybt];
        
        [marrybt addTarget:self action:@selector(isPublishFriendInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UILabel *marrylabel = [[UILabel alloc] initWithFrame:CGRectMake(marrybt.frame.origin.x+marrybt.frame.size.width+10.0f, marrybt.frame.origin.y, 100.0f, 30.0f)];
        [marrylabel setTextColor:kMM_ProjectColor_StandBlue];
        [marrylabel setBackgroundColor:[UIColor clearColor]];
        [marrylabel setText:@"发布婚恋"];
        [cell.contentView addSubview:marrylabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:kMM_ProjectColor_StandBlue];
        [button setTitleColor:kMM_ProjectColor_StandWhite forState:UIControlStateNormal];
        [button.layer setCornerRadius:4.0f];
        [button setTitle:@"确认发布" forState:UIControlStateNormal];
        [button setFrame:CGRectMake(kMM_SCREEN_W-100.0f, marrybt.frame.origin.y-20.0f, 80.0f, 40.0f)];
        [cell.contentView addSubview:button];
        
    }
    else
    {
        
        [cell.textLabel setText:@"您所在的城市是："];
        UILabel *citylabel = [[UILabel alloc] initWithFrame:CGRectMake(145.0f,15.0f, 100.0f, 30.0f)];
        [citylabel setTextColor:kMM_ProjectColor_StandBlue];
        [citylabel setBackgroundColor:[UIColor clearColor]];
        [citylabel setText:@"长沙"];
        [cell.contentView addSubview:citylabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setFrame:CGRectMake(kMM_SCREEN_W-120.0f, 15.0f, 120.0f, 30.0f)];
//        [button setBackgroundColor:kMM_ProjectColor_StandBlue];
        [button setTitleColor:kMM_ProjectColor_StandBlue forState:UIControlStateNormal];
//        [button.layer setCornerRadius:4.0f];
        [button setTitle:@"切换地址" forState:UIControlStateNormal];
        [cell.contentView addSubview:button];
        
        UIImageView *bglcview = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 6.0f, 14.0f, 17.0f)];
        [bglcview setBackgroundColor:[UIColor clearColor]];
        [bglcview setImage:[UIImage imageNamed:@"ico_address"]];
        
        [button addSubview:bglcview];
        
    }
    return cell;
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row)
    {
        return 120.0f;
    }
    else
    {
        return 60.0f;
    }
}

-(NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @" ";
}

-(void) isPublishFriendInfo:(UIButton *) sender
{
    
    
   [sender setBackgroundImage:[UIImage imageNamed:@"btn_chose_pressed"] forState:UIControlStateNormal];
    if (selectedbutton)
    {
        [selectedbutton setBackgroundImage:[UIImage imageNamed:@"btn_chose_nor"] forState:UIControlStateNormal];
    }
    selectedbutton = sender;
    
    
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
