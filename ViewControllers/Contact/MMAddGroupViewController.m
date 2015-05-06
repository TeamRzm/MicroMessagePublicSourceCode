//
//  MMAddGroupViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/4.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMAddGroupViewController.h"
#import "MMGroupEntity.h"
#import "MMChatViewController.h"


@interface MMAddGroupViewController ()
{
    NSIndexPath *currentindex;
    BOOL isSearch;
    
}
@end

@implementation MMAddGroupViewController
@synthesize isSendKard;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (isSendKard)
    {
        [self setTitle:@"选择联系人"];
    }
    else
    {
        [self setTitle:@"新建群聊"];

    }
    _dataArr = [[NSMutableArray alloc] init];
    _resultArr = [[NSMutableArray alloc] init];
    _searchKeyArr = [[NSMutableArray alloc] init];
    
    [self InitSearchBarView];
    
    [self LoadData];
    
    [self SetBaseNavigationRightItemWithTitle:@"确定"];
    
    
}

-(void) LoadData
{
    //组织数据源
    [_searchKeyArr addObject:UITableViewIndexSearch];

    for(int i=97;i<123;i++)
    {
        NSMutableArray*subArray=[[NSMutableArray alloc]init];
        for(int j=0;j<10;j++)
        {
            MMGroupEntity *subfriend = [[MMGroupEntity alloc] init];
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
        [_dataArr addObject:subArray];
    }
    
    

}

#pragma mark tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if(tableView!=self.tableView)
        return 1;
    return [_dataArr count]+1;
}
//设置rows的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView!=self.tableView)
    {
        //先清空数组里的内容。每次搜索显示的不能一样吧。
        [_resultArr removeAllObjects];
        //把输入的内容与原有数据源比较，有相似的就加到_resultArray数组里
        for(NSMutableArray*mArray in _dataArr)
        {
            for(MMGroupEntity *str in mArray)
            {
                NSRange range=[[str.firstNameChar lowercaseString] rangeOfString:[_searchBar.text lowercaseString]];
                if(range.location!=NSNotFound){
                    [_resultArr addObject:str];
                }
            }
            
        }
        
        return [_resultArr count];
    }
    else
    {
        if (section == 0)
        {
            return 1;
        }
        return [[_dataArr objectAtIndex:section-1] count];
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
    MMGroupEntity *subfriend = nil;
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
        UILabel *leftLable = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 15, 200.0f, 30.0f)];
        [leftLable setBackgroundColor:[UIColor clearColor]];
        if (isSendKard)
        {
            [leftLable setText:@"选择一个联系人"];
        }
        else{
            [leftLable setText:@"选择一个群"];
        }
        
        [leftLable setTextColor:kMM_ProjectColor_DeepGray];
        [leftLable setTextAlignment:NSTextAlignmentLeft];
        [leftLable setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:16.0f]];
        [cell.contentView addSubview:leftLable];
        
    }
    else
    {
        if(tableView!=self.tableView)
        {
            subfriend = [_resultArr objectAtIndex:indexPath.row];
            
        }else{
            
            subfriend = [[_dataArr objectAtIndex:indexPath.section-1] objectAtIndex:indexPath.row];
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
        
        //是否选择
        UIButton *selectbt = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectbt setFrame:CGRectMake(kMM_SCREEN_W-50.0f, 15.0f, 30.0f, 30.0f)];
        if (currentindex && currentindex.section == indexPath.section && currentindex.row == indexPath.row)
        {
            [selectbt setBackgroundImage:[UIImage imageNamed:@"btn_chose_pressed"] forState:UIControlStateNormal];
        }
        else
        {
            [selectbt setBackgroundImage:[UIImage imageNamed:@"btn_chose_nor"] forState:UIControlStateNormal];
        }
        [selectbt setUserInteractionEnabled:NO];
        [selectbt setTag:[[NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row] intValue]];
        [cell.contentView addSubview:selectbt];
        
        
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView !=self.tableView)
    {
        isSearch = YES;
    }
    else
    {
        isSearch = NO;
    }
    currentindex = indexPath;
    [tableView reloadData];
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


#pragma  mark Action Method
-(void)BaseNavigatinRightItemClicked:(UIButton *)sender
{
    if (currentindex)
    {
        MMGroupEntity *subEntity = nil;
        if (isSearch)
        {
            subEntity = _resultArr[currentindex.row];
        }
        else
        {
            subEntity = _dataArr[currentindex.section-1][currentindex.row];
        }
        
        MMChatViewController *chatview = [[MMChatViewController alloc] init];
        [chatview setTargetName:subEntity.nickName];
        [chatview setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chatview animated:YES];
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
