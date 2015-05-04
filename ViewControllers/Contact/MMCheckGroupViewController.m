//
//  MMCheckGroupViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/4.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMCheckGroupViewController.h"
#import "MMGroupEntity.h"
#import "MMSearchGroupResultViewController.h"


@interface MMCheckGroupViewController ()

@end

@implementation MMCheckGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"查找群聊"];
    _dataArr = [[NSMutableArray alloc] init];
    
    [self initView];
    [self LoadData];
    [self.tableView setRowHeight:60.0f];
    
}

#pragma mark init Method

-(void) initView
{
    _searchBar=[[UISearchBar alloc] init];
    [_searchBar setFrame:CGRectMake(0.0, 0.0f, kMM_SCREEN_W, 44.0f)];
    [_searchBar setPlaceholder:@"搜索"];
    [_searchBar setTintColor:kMM_ProjectColor_DeepBlack];
    UIView *searchbarview = [[UIView alloc] initWithFrame:_searchBar.frame];
    [searchbarview setBackgroundColor:kMM_ProjectColor_StandBlue];
    [searchbarview setBackgroundColor:kMM_ProjectColor_BackGroundGray];
    [_searchBar insertSubview:searchbarview atIndex:1];
    [_searchBar setDelegate:self];
    self.tableView.tableHeaderView = _searchBar;
    
    
}

-(void) LoadData
{
    MMGroupEntity *group1 = [[MMGroupEntity alloc] init];
    [group1 setNickName:@"a长沙老乡会"];
    [group1 setSignMessage:@"藏在我背包角落里的你"];
    [group1 setAvterURL:@"t_avter_0"];
    [_dataArr addObject:group1];
    
    MMGroupEntity *group2 = [[MMGroupEntity alloc] init];
    [group2 setNickName:@"b书友荟萃"];
    //    [group2 setSignMessage:@""];
    [group2 setAvterURL:@"t_avter_1"];
    [_dataArr addObject:group2];
    
    
    MMGroupEntity *group3 = [[MMGroupEntity alloc] init];
    [group3 setNickName:@"c爱狗者大"];
    [group3 setSignMessage:@"哈哈哈哈哈哈哈哈"];
    [group3 setAvterURL:@"t_avter_2"];
    [_dataArr addObject:group3];

}

#pragma mark tableivew delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}

//Cell的相关设置
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellName=@"cell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    MMGroupEntity *subfriend = _dataArr[indexPath.row];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
    }
    
    for (UIView *subview in cell.contentView.subviews)
    {
        [subview removeFromSuperview];
    }
    
    
    //头像
    EGOImageView *avterImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    avterImageView.placeholderImage = [UIImage imageNamed:subfriend.avterURL];
    avterImageView.image = [UIImage imageNamed:subfriend.avterURL];
    avterImageView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
    avterImageView.layer.borderWidth = 1.0f;
    [cell.contentView addSubview:avterImageView];
    
    //用户名
    UILabel *userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, kMM_SCREEN_W-80.0f, 20)];
    userNameLable.font = [UIFont boldSystemFontOfSize:13.0f];
    userNameLable.textColor = kMM_ProjectColor_DeepGray;
    userNameLable.text = subfriend.nickName;
    [cell.contentView addSubview:userNameLable];
    
    //消息
    UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 35, kMM_SCREEN_W-80.0f, 20)];
    contentLable.font = [UIFont systemFontOfSize:12.0f];
    contentLable.textColor = [UIColor lightGrayColor];
    contentLable.text = subfriend.signMessage;
    [cell.contentView addSubview:contentLable];
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"附近的群";
}

#pragma mark UISearchBar delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    MMSearchGroupResultViewController *resultview = [[MMSearchGroupResultViewController alloc] init];
    [resultview setSearchKey:searchBar.text];
    [resultview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:resultview animated:YES];
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
