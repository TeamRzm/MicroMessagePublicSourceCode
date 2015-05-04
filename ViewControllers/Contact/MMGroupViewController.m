//
//  MMGroupViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/3.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMGroupViewController.h"
#import "MMAddGroupViewController.h"
#import "MMCheckGroupViewController.h"


@interface MMGroupViewController ()

@end

@implementation MMGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"群聊"];
    [self InitSearchBarView];
    [_searchBar setPlaceholder:@"搜索"];
    
    [self.tableView setRowHeight:60.0f];
    _dataArray = [[NSMutableArray alloc] init];
    _resultData = [[NSMutableArray alloc] init];
    [self InitSubData];
    
    [self CreateFooterView];
    
}

-(void) InitSubData
{
    
    NSMutableArray *temdata = [[NSMutableArray alloc] init];
    MMGroupEntity *group1 = [[MMGroupEntity alloc] init];
    [group1 setNickName:@"a长沙老乡会"];
    [group1 setSignMessage:@"藏在我背包角落里的你"];
    [group1 setAvterURL:@"t_avter_0"];
    [_dataArray addObject:group1];
    
    MMGroupEntity *group2 = [[MMGroupEntity alloc] init];
    [group2 setNickName:@"b书友荟萃"];
//    [group2 setSignMessage:@""];
    [group2 setAvterURL:@"t_avter_1"];
    [_dataArray addObject:group2];

    
    MMGroupEntity *group3 = [[MMGroupEntity alloc] init];
    [group3 setNickName:@"c爱狗者大"];
    [group3 setSignMessage:@"哈哈哈哈哈哈哈哈"];
    [group3 setAvterURL:@"t_avter_2"];
    [_dataArray addObject:group3];
}

-(void) CreateFooterView
{
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, 80.0f)];
    [footview setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableFooterView = footview;
    
    //
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setFrame:CGRectMake(25.0f, 30.0f, (kMM_SCREEN_W-75)/2.0, 40.0f)];
    [leftbutton setTag:0];
    [leftbutton setTitle:@"新建群聊" forState:UIControlStateNormal];
    [leftbutton setTitleColor:kMM_ProjectColor_StandWhite forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(IsToCreateGroup:) forControlEvents:UIControlEventTouchUpInside];
    [leftbutton setBackgroundColor:kMM_ProjectColor_StandYellow];
    [leftbutton.layer setCornerRadius:4.0f];
    [footview addSubview:leftbutton];
    
    //
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setFrame:CGRectMake(leftbutton.frame.origin.x+leftbutton.frame.size.width+ 25.0f, 30.0f, (kMM_SCREEN_W-75)/2.0, 40.0f)];
    [rightbutton setTag:1];
    [rightbutton setTitle:@"查找群聊" forState:UIControlStateNormal];
    [rightbutton setTitleColor:kMM_ProjectColor_StandWhite forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(IsToCreateGroup:) forControlEvents:UIControlEventTouchUpInside];
    [rightbutton setBackgroundColor:kMM_ProjectColor_StandYellow];
    [rightbutton.layer setCornerRadius:4.0f];
    [footview addSubview:rightbutton];

    
}

#pragma mark tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView != self.tableView)
    {
        [_resultData removeAllObjects];
        for (MMGroupEntity *subEntity in _dataArray)
        {
            if ([subEntity.nickName rangeOfString:[_searchBar.text lowercaseString]].length > 0)
            {
                [_resultData addObject:subEntity];
            }
        }
        return _resultData.count;
    }
    return _dataArray.count;
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MMGroupEntity *subEntity = nil;
    if (tableView != self.tableView)
    {
        subEntity = _resultData[indexPath.row];
    }
    else
    {
        subEntity = _dataArray[indexPath.row];
    }
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
    
    
    
    //群昵称
    UILabel *userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, kMM_SCREEN_W-70.0f, 20)];
    userNameLable.font = [UIFont boldSystemFontOfSize:13.0f];
    userNameLable.textColor = kMM_ProjectColor_DeepGray;
    userNameLable.text = subEntity.nickName;
    [cell.contentView addSubview:userNameLable];
    
    //群签名
    UILabel *messageLable = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 35, kMM_SCREEN_W-70.0f, 20)];
    messageLable.font = [UIFont systemFontOfSize:12.0f];
    messageLable.textColor = [UIColor lightGrayColor];
    messageLable.text = subEntity.signMessage;
    [cell.contentView addSubview:messageLable];
    
    return cell;
    
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView != self.tableView)
    {
        return @"搜索结果";
    }
    return @"群聊";
}

#pragma  mark Gesture Method
-(void) AvterImageClicked:(UITapGestureRecognizer *) _gesture
{
    
}

#pragma mark Action Method
-(void) IsToCreateGroup:(UIButton *) sender
{
    NSLog(@"sender tag == %d",sender.tag);
    if (sender.tag)
    {
        MMCheckGroupViewController *checkview = [[MMCheckGroupViewController alloc] init];
        [checkview setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:checkview animated:YES];
        
    }
    else
    {
        MMAddGroupViewController *addview = [[MMAddGroupViewController alloc] init];
        [addview setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:addview animated:YES];
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
