//
//  MMGroupSettingViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/5.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMGroupSettingViewController.h"
#import "MMFriendEntity.h"
#import "MMFriendInfoViewController.h"




@interface MMGroupSettingViewController ()
{
    NSMutableArray *_dataArr;
    NSMutableArray *_section1Arr;
    BOOL           isGroupOwner;
    BOOL           isDistube;
    BOOL           isAllowShow;
    
}
@property (nonatomic,assign) BOOL           isGroupOwner;
@end

@implementation MMGroupSettingViewController
@synthesize isGroupOwner;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"聊天信息"];
    _dataArr = [[NSMutableArray alloc] init];
    _section1Arr = [[NSMutableArray alloc] init];
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    isAllowShow = YES;
    
    [self LoadData];
    
    [self CreateFooterView];
    
    

}

-(void) LoadData
{
    for (int k = 0; k < 22; k++)
    {
        MMFriendEntity *subEntity = [[MMFriendEntity alloc] init];
        subEntity.firstNameChar = [[NSString stringWithFormat:@"%c",k] uppercaseString];
        subEntity.nickName = [NSString stringWithFormat:@"微用%d",k];
        subEntity.avterURL =  [NSString stringWithFormat:@"t_avter_%d",k%9];
        subEntity.signMessage = @"愿你一生平安";
        subEntity.isCanDelete = isGroupOwner;
        [_dataArr addObject:subEntity];
        subEntity.isShownickName = isAllowShow;
    }
    
    //添加添加
    MMFriendEntity *subEntity = [[MMFriendEntity alloc] init];
    subEntity.firstNameChar = [[NSString stringWithFormat:@"d"] uppercaseString];
    subEntity.nickName = [NSString stringWithFormat:@""];
    subEntity.avterURL =  [NSString stringWithFormat:@"add_groupadd_nor"];
    [_dataArr addObject:subEntity];
    
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"此群名称",@"leftkey",@"书友会",@"rightkey", nil];
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"地区设置",@"leftkey",@"长沙",@"rightkey", nil];
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"群二维码",@"leftkey",@"书友会",@"rightkey", nil];
    
    [_section1Arr addObject:dic1];
    [_section1Arr addObject:dic2];
    [_section1Arr addObject:dic3];
    
    
}

-(void) CreateFooterView
{
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, 100.0f)];
    
    UIButton *deletebt = [UIButton buttonWithType:UIButtonTypeCustom];
    [deletebt setBackgroundColor:kMM_ProjectColor_StandRed];
    [deletebt setFrame:CGRectMake(20.0f, 10.0f, kMM_SCREEN_W-40.0f, 40.0f)];
    [deletebt.layer setCornerRadius:4.0f];
    [deletebt addTarget:self action:@selector(IsDeleteGroup:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:deletebt];
    if (isGroupOwner)
    {
        [deletebt setTitle:@"解散本群" forState:UIControlStateNormal];
        [deletebt setTag:0];
    }
    else
    {
        [deletebt setTitle:@"删除并退出" forState:UIControlStateNormal];
        [deletebt setTag:1];
    }
    self.tableView.tableFooterView = footview;
    
}

#pragma mark tableivew delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isGroupOwner)
    {
        return 3;
    }
    return 5;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            int allcount = _dataArr.count%4==0?0:1;
            return allcount+_dataArr.count/4;
        }
            break;
        case 1:
            return _section1Arr.count;
            break;

        case 2:
            return 1;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 1;
            break;
        default:
            break;
     }
    return 0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"GroupCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    switch (indexPath.section)
    {
        case 0:
        {
            for (int i = 0; i<4; i++)
            {
                if (indexPath.row*4+i > _dataArr.count-1)
                {
                    break;
                }
                MMFriendEntity *subEntity = _dataArr[indexPath.row*4+i ];
                MMGroupListView *listview = [[MMGroupListView alloc] initWithFrame:CGRectMake(0.0f+i*(kMM_SCREEN_W/4), 5.0f, kMM_SCREEN_W/4, kMM_SCREEN_W/4)];
                [listview setDatamodel:subEntity];
                [listview setDelegate:self];
                [cell.contentView addSubview:listview];
            }

        }
            break;
        case 1:
        {
            cell.textLabel.text = _section1Arr[indexPath.row][@"leftkey"];
            cell.detailTextLabel.text = _section1Arr[indexPath.row][@"rightkey"];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 43.0f, kMM_SCREEN_W-20.0f, 1.0f)];
            [line setBackgroundColor:kMM_ProjectColor_GenerallyGreen];
            [cell.contentView addSubview:line];
            
        }
            break;
            
            case 2:
        {
            cell.textLabel.text = @"消息免打扰";
            
            UIButton *actionbt = [UIButton buttonWithType:UIButtonTypeCustom];
            [actionbt setFrame:CGRectMake(kMM_SCREEN_W-40.0f, 14.0f, 32.0f, 23.0f)];
            [actionbt addTarget:self action:@selector(IsAllowDistube:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:actionbt];
            
            if (isDistube)
            {
                [actionbt setBackgroundImage:[UIImage imageNamed:@"btn_switchon"] forState:UIControlStateNormal];
            }
            else
            {
                [actionbt setBackgroundImage:[UIImage imageNamed:@"btn_switchoff"] forState:UIControlStateNormal];
            }

        }
            break;
            case 3:
        {
            if (indexPath.row)
            {
                cell.textLabel.text = @"显示群成员昵称";
                UIButton *actionbt = [UIButton buttonWithType:UIButtonTypeCustom];
                [actionbt setFrame:CGRectMake(kMM_SCREEN_W-40.0f, 14.0f, 32.0f, 23.0f)];
                [actionbt addTarget:self action:@selector(IsShowMemberName:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:actionbt];
                
                if (isAllowShow)
                {
                    [actionbt setBackgroundImage:[UIImage imageNamed:@"btn_switchon"] forState:UIControlStateNormal];
                }
                else
                {
                    [actionbt setBackgroundImage:[UIImage imageNamed:@"btn_switchoff"] forState:UIControlStateNormal];
                }
            }
            else
            {
                cell.textLabel.text = @"我在本群的昵称";
                cell.detailTextLabel.text = @"会长";
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 43.0f, kMM_SCREEN_W-20.0f, 1.0f)];
                [line setBackgroundColor:kMM_ProjectColor_GenerallyGreen];
                [cell.contentView addSubview:line];

            }
        }
            break;
            case 4:
            cell.textLabel.text = @"清空聊天记录";
            break;
        default:
            cell.textLabel.text = @"";
            break;
    }
    
    return cell;
    
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100.0f;
    }
    else
    {
        return 44.0f;
    }
}

-(NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @" ";
}

#pragma mark MMGroupListView delegate
-(void)MMGroupListViewDidClicked:(MMFriendEntity *)_model
{
    NSLog(@"_model name =%@",_model.nickName);
    if ([_model.avterURL isEqualToString:@"add_groupadd_nor"])
    {
        NSLog(@"邀请好友");
    }
    else
    {
        MMFriendInfoViewController *infoview = [[MMFriendInfoViewController alloc] init];
        [self.navigationController pushViewController:infoview animated:YES];
    }
    
}

-(void)MMGroupListViewDelete:(MMFriendEntity *)_model
{
    NSLog(@"_model delete name == %@",_model.nickName);
    [_dataArr removeObject:_model];
    [self.tableView reloadData];
}

#pragma mark Send Method
-(void) IsDeleteGroup:(UIButton *) sender
{
    // sender tag 0 解散本群，1退出群
    NSLog(@"sender tag == %d",sender.tag);
    if (sender.tag)
    {
        
    }
    else
    {
        
    }
}

-(void) IsAllowDistube:(UIButton *) sender
{
    isDistube = !isDistube;
    if (isDistube)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"btn_switchon"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"btn_switchoff"] forState:UIControlStateNormal];
    }
}

-(void) IsShowMemberName:(UIButton *) sender
{
    isAllowShow = !isAllowShow;
    for (MMFriendEntity *subEntity in _dataArr)
    {
        subEntity.isShownickName = isAllowShow;
    }
    
    [self.tableView reloadData];

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
