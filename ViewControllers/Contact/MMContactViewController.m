//
//  MMContactViewController.m
//  MicroMessage
//
//  Created by Martin.Ren on 15/4/23.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMContactViewController.h"
#import "MMFriendEntity.h"
#import "EGOImageView.h"
#import "MMChatViewController.h"
#import "MMFriendAddManagerViewController.h"
#import "MMGroupViewController.h"




@interface MMContactViewController ()

@end

@implementation MMContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"友录"];
    _dataArray = [[NSMutableArray alloc] init];
    _resultData = [[NSMutableArray alloc] init];
    _searchKeyArr = [[NSMutableArray alloc] init];
    [_searchKeyArr addObject:UITableViewIndexSearch];
    //组织数据源
    for(int i=97;i<123;i++)
    {
        NSMutableArray*subArray=[[NSMutableArray alloc]init];
        for(int j=0;j<10;j++)
        {
            MMFriendEntity *subfriend = [[MMFriendEntity alloc] init];
            subfriend.firstNameChar = [[NSString stringWithFormat:@"%c",i] uppercaseString];
            subfriend.nickName = [NSString stringWithFormat:@"%c%d",i,j];
            subfriend.avterURL =  [NSString stringWithFormat:@"t_avter_%d",i%9];
            subfriend.signMessage = @"愿你一生平安";
            [subArray addObject:subfriend];
            
            if (![_searchKeyArr containsObject:subfriend.firstNameChar])
            {
                [_searchKeyArr addObject:subfriend.firstNameChar];
            }
        }
        [_dataArray addObject:subArray];
    }
    
    [self CreateHeaderView];
    
    [self SetBaseNavigationLeftItem:@"btn_add"];
}

-(void) CreateHeaderView
{
    [self InitSearchBarView];
    [_searchBar setPlaceholder:@"搜索全部好友"];
}

#pragma mark tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if(tableView!=self.tableView)
        return 1;
    return [_dataArray count]+1;
}
//设置rows的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView!=self.tableView)
    {
        //先清空数组里的内容。每次搜索显示的不能一样吧。
        [_resultData removeAllObjects];
        //把输入的内容与原有数据源比较，有相似的就加到_resultArray数组里
        for(NSMutableArray*mArray in _dataArray)
        {
            for(MMFriendEntity *str in mArray)
            {
                NSRange range=[str.firstNameChar rangeOfString:_searchBar.text];
                if(range.location!=NSNotFound){
                    [_resultData addObject:str];
                }
            }
            
        }
        
        return [_resultData count];
    }
    else
    {
        if (section == 0)
        {
            return 1;
        }
        return [[_dataArray objectAtIndex:section-1] count];
    }
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
//设置section的title
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView!=self.tableView)
    {
        return @"搜索结果";
    }
    else
    {
        if (section == 0)
        {
            return @"";
        }
    
        return [_searchKeyArr objectAtIndex:section];
    }
}

//Cell的相关设置
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellName=@"cell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    MMFriendEntity *subfriend = nil;
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
    }
    
    for (UIView *subview in cell.contentView.subviews)
    {
        [subview removeFromSuperview];
    }
    if (indexPath.section == 0 && tableView == self.tableView)
    {
        UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W/2.0f, 60.0f)];
        [headerview setTag:0];
        [headerview setBackgroundColor:[UIColor clearColor]];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(IsToNewFriendOrGroup:)];
        [headerview addGestureRecognizer:gesture];
        
        [cell.contentView addSubview:headerview];
        
        
        UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbutton setFrame:CGRectMake(headerview.frame.size.width/2.0f-115.0f/2.0f, 15.0f, 30.0f, 30.0f)];
        [leftbutton setUserInteractionEnabled:NO];
        [leftbutton setBackgroundImage:[UIImage imageNamed:@"ico_newfriend"] forState:UIControlStateNormal];
        [leftbutton setBackgroundColor:kMM_ProjectColor_BackGroundGray];
        [headerview addSubview:leftbutton];
        
        UILabel *leftLable = [[UILabel alloc] initWithFrame:CGRectMake(leftbutton.frame.size.width+leftbutton.frame.origin.x+5.0f, leftbutton.frame.origin.y, 80.0f, 30.0f)];
        [leftLable setBackgroundColor:[UIColor clearColor]];
        [leftLable setText:@"新的好友"];
        [leftLable setTextColor:kMM_ProjectColor_LightGreen];
        [leftLable setTextAlignment:NSTextAlignmentLeft];
        [leftLable setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:16.0f]];
        [headerview addSubview:leftLable];
        
        
        
        UIView *rightview = [[UIView alloc] initWithFrame:CGRectMake(headerview.frame.size.width, 0.0f, kMM_SCREEN_W/2.0f, 50.0f)];
        [rightview setBackgroundColor:[UIColor clearColor]];
        [rightview setTag:1];
        UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(IsToNewFriendOrGroup:)];
        [rightview addGestureRecognizer:gesture1];
        [cell.contentView addSubview:rightview];
        
        UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightbutton setFrame:CGRectMake(leftbutton.frame.origin.x, 15.0f, 30.0f, 30.0f)];
        [rightbutton setUserInteractionEnabled:NO];
        [rightbutton setBackgroundColor:[UIColor clearColor]];
        [rightbutton setBackgroundImage:[UIImage imageNamed:@"ico_newgroup"] forState:UIControlStateNormal];
        [rightview addSubview:rightbutton];
        
        UILabel *rightLable = [[UILabel alloc] initWithFrame:CGRectMake(rightbutton.frame.size.width+rightbutton.frame.origin.x+5.0f, rightbutton.frame.origin.y, 80.0f, 30.0f)];
        [rightLable setBackgroundColor:[UIColor clearColor]];
        [rightLable setText:@"我的群聊"];
        [rightLable setTextColor:kMM_ProjectColor_StandYellow];
        [rightLable setTextAlignment:NSTextAlignmentLeft];
        [rightLable setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:16.0f]];
        [rightview addSubview:rightLable];

    }
    else
    {
        if(tableView!=self.tableView)
        {
            subfriend = [_resultData objectAtIndex:indexPath.row];
            
        }else{
            
            subfriend = [[_dataArray objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
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

    }
    
    
    
    return cell;
}
//设置索引条
-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _searchKeyArr;
}
//设置索引条对应关系
//如果不加放大镜。这个方法就不需要。
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index==0)
    {
        //index是索引条的序号。从0开始，所以第0 个是放大镜。如果是放大镜坐标就移动到搜索框处
        [tableView scrollRectToVisible:_searchBar.frame animated:NO];
        return -1;
    }else{
        //因为返回的值是section的值。所以减1就是与section对应的值了
        return index-1;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMFriendEntity *subfriend = nil;
    if (tableView == self.tableView && indexPath.section == 0)
    {
        return;
    }
    else
    {
        if(tableView!=self.tableView)
        {
            subfriend = [_resultData objectAtIndex:indexPath.row];
            
        }else{
            
            subfriend = [[_dataArray objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
        }
        MMChatViewController *chatview = [[MMChatViewController alloc] init];
        [chatview setTargetName:subfriend.nickName];
        [chatview setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chatview animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark gesture Method
-(void) IsToNewFriendOrGroup:(UITapGestureRecognizer *) _gesture
{
    NSLog(@"view tag == %d",_gesture.view.tag);
    if (_gesture.view.tag)
    {
        MMGroupViewController *groupview =[[MMGroupViewController alloc] init];
        [groupview setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:groupview animated:YES];
    }
    else
    {
        MMFriendAddManagerViewController *friendview =[[MMFriendAddManagerViewController alloc] init];
        [friendview setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:friendview animated:YES];
    }
}

#pragma mark Override
-(void)BaseNavigatinLeftItemClicked:(UIButton *)sender
{
    MMFriendAddManagerViewController *friendview =[[MMFriendAddManagerViewController alloc] init];
    [friendview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:friendview animated:YES];
}

#pragma mark searchbar delegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
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
