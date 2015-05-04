//
//  MMSearchGroupResultViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/4.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMSearchGroupResultViewController.h"
#import "MMGroupEntity.h"

@interface MMSearchGroupResultViewController ()

@end

@implementation MMSearchGroupResultViewController
@synthesize searchKey;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [[NSMutableArray alloc] init];
    _sectionTitleArr = [[NSMutableArray alloc] init];
    [self setTitle:@"查找结果"];
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
    [_searchBar setText:searchKey];
    [_searchBar setTintColor:kMM_ProjectColor_DeepBlack];
    UIView *searchbarview = [[UIView alloc] initWithFrame:_searchBar.frame];
    [searchbarview setBackgroundColor:kMM_ProjectColor_StandBlue];
    [searchbarview setBackgroundColor:kMM_ProjectColor_BackGroundGray];
    [_searchBar insertSubview:searchbarview atIndex:1];
    [_searchBar setDelegate:self];
    [_searchBar setShowsCancelButton:YES animated:YES];
    self.tableView.tableHeaderView = _searchBar;
    
    
}

-(void) LoadData
{
    for (int i = 0; i< 2; i++)
    {
        NSMutableArray *temdata = [[NSMutableArray alloc] init];
        MMGroupEntity *group1 = [[MMGroupEntity alloc] init];
        [group1 setNickName:@"a长沙老乡会"];
        [group1 setSignMessage:@"藏在我背包角落里的你"];
        [group1 setAvterURL:@"t_avter_0"];
        [group1 setInviteState:@"0"];
        [temdata addObject:group1];
        
        MMGroupEntity *group2 = [[MMGroupEntity alloc] init];
        [group2 setNickName:@"b书友荟萃"];
        //    [group2 setSignMessage:@""];
        [group2 setAvterURL:@"t_avter_1"];
        [group2 setInviteState:@"1"];
        [temdata addObject:group2];
        
        
        MMGroupEntity *group3 = [[MMGroupEntity alloc] init];
        [group3 setNickName:@"c爱狗者大"];
        [group3 setSignMessage:@"哈哈哈哈哈哈哈哈"];
        [group3 setAvterURL:@"t_avter_2"];
        [group3 setInviteState:@"2"];
        [temdata addObject:group3];
        
        [_dataArr addObject:temdata];
        
        [_sectionTitleArr addObject:@"陌生群"];
        
    }

    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touch begin....");
}

#pragma mark tableivew delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}

//Cell的相关设置
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellName=@"cell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    MMGroupEntity *subEntity = _dataArr[indexPath.section][indexPath.row];
    
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
    avterImageView.placeholderImage = [UIImage imageNamed:subEntity.avterURL];
    avterImageView.image = [UIImage imageNamed:subEntity.avterURL];
    avterImageView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
    avterImageView.layer.borderWidth = 1.0f;
    [cell.contentView addSubview:avterImageView];
    
    //用户名
    UILabel *userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, kMM_SCREEN_W-80.0f, 20)];
    userNameLable.font = [UIFont boldSystemFontOfSize:13.0f];
    userNameLable.textColor = kMM_ProjectColor_DeepGray;
    userNameLable.text = subEntity.nickName;
    [cell.contentView addSubview:userNameLable];
    
    //消息
    UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 35, kMM_SCREEN_W-80.0f, 20)];
    contentLable.font = [UIFont systemFontOfSize:12.0f];
    contentLable.textColor = [UIColor lightGrayColor];
    contentLable.text = subEntity.signMessage;
    [cell.contentView addSubview:contentLable];
    
    //状态
    UIButton *statebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [statebutton setFrame:CGRectMake(kMM_SCREEN_W-80.0f, 12.0f, 60.0f, 35.0f)];
    [statebutton.titleLabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:14.0f]];
    [statebutton setTag:indexPath.row];
    [statebutton setBackgroundColor:[UIColor clearColor]];
    [statebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [statebutton.layer setCornerRadius:4.0f];
    
    switch ([subEntity.inviteState intValue])
    {
        case 0:
        {
            [statebutton setTitle:@"" forState:UIControlStateNormal];
            
        }
            break;
        case 1:
        {
            [statebutton setTitle:@"接受" forState:UIControlStateNormal];
            [statebutton setBackgroundColor:kMM_ProjectColor_StandBlue];
            
        }
            break;
        case 2:
        {
            [statebutton setTitle:@"申请加入" forState:UIControlStateNormal];
            [statebutton setBackgroundColor:kMM_ProjectColor_StandGreen];
            
        }
            break;
            
        default:
            break;
    }
    [cell.contentView addSubview:statebutton];
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitleArr[section];
}

#pragma mark UISearchBar delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
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
