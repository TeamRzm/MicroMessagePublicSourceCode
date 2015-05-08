//
//  MMLoveFriendViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/7.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMLoveFriendViewController.h"
#import "MMContactCell.h"
#import "MMFriendEntity.h"
#import "MMFriendInfoViewController.h"


@interface MMLoveFriendViewController ()

@end

@implementation MMLoveFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"当前搜索地区为长沙"];
    _friendArr = [[NSMutableArray alloc] init];
    _loactionArr = [[NSMutableArray alloc] init];
    [self LoadData];
    [self.tableView setRowHeight:70];
    [self SetBaseNavigationRightItem:@"header_btn_list"];
    
}

-(void) LoadData
{
    for(int i=0;i<5;i++)
    {
        NSMutableArray*subArray=[[NSMutableArray alloc]init];
        for(int j=0;j<10;j++)
        {
            MMFriendEntity *subfriend = [[MMFriendEntity alloc] init];
            subfriend.firstNameChar = [[NSString stringWithFormat:@"%c",i*j] uppercaseString];
            subfriend.nickName = [NSString stringWithFormat:@"阿九"];
            subfriend.avterURL =  [NSString stringWithFormat:@"t_avter_%d",i];
            subfriend.signMessage = @"愿你一生平安";
            [subArray addObject:subfriend];
            
        }
        [_loactionArr addObject:[NSString stringWithFormat:@"%i米以内",(i+1)*100]];
        [_friendArr addObject:subArray];
    }

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
       
        _listView = [[MMTypeListView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, kMM_SCREEN_H) withTitls:[[NSMutableArray alloc] initWithObjects:@"只看男生",@"只看女生", @"切换城市",nil] withImages: [[NSMutableArray alloc] initWithObjects:@"ico_boy",@"ico_girl", @"ico_change_address",nil]];
        [_listView setDelegate:self];
        [self.view addSubview:_listView];
    }
}

#pragma mark tableivew delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _friendArr.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_friendArr[section] count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoveFriendCell"];
    if (!cell)
    {
        cell = [[MMContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoveFriendCell"];
    }
    [cell setDataModel:_friendArr[indexPath.section][indexPath.row]];
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _loactionArr[section];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMFriendInfoViewController *infoview = [[MMFriendInfoViewController alloc] init];
    [infoview setIsSelf:YES];
    [infoview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:infoview animated:YES];
}

#pragma  mark MMTypeListView delegate
-(void)MMTypeListViewClickedWithIndex:(NSInteger)index
{
    NSLog(@"index == %d",index);
    
    [self MMTypeListViewCancel];
    
}

-(void)MMTypeListViewCancel
{
    [_listView removeFromSuperview];
    _listView = nil;
    
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
