//
//  MMOtherViewController.m
//  MicroMessage
//
//  Created by Martin.Ren on 15/4/23.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMOtherViewController.h"

@interface MMOtherViewController ()
{
    EGOImageView *avterImageView;
    UILabel *userNameLable;
    UILabel *contentLable;
    EGOImageView *enCodeImageView;
    
    NSMutableArray *_dataArr;
    NSMutableArray *_imageArr;
    
    
}
@end

@implementation MMOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"应用"];
    _dataArr = [[NSMutableArray alloc] initWithObjects:@"空间",@"情缘",@"淘用", nil];
    _imageArr = [[NSMutableArray alloc] initWithObjects:@"btn_kongjian",@"btn_qingyuan",@"btn_taoyong", nil];
    [self SetBaseNavigationLeftItem:@"btn_add"];
    [self CreateHeaderView];
    
}

-(void) CreateHeaderView
{
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, 70.0f)];
    [headerview setBackgroundColor:[UIColor clearColor]];
    //头像
    avterImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    avterImageView.placeholderImage = [UIImage imageNamed:@"t_avter_9"];
    avterImageView.image = [UIImage imageNamed:@"t_avter_9"];
    avterImageView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
    avterImageView.layer.borderWidth = 1.0f;
    avterImageView.layer.cornerRadius = 4.0f;
    [headerview addSubview:avterImageView];
    
    //用户名
    userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, kMM_SCREEN_W-80.0f, 25)];
    userNameLable.font = [UIFont boldSystemFontOfSize:16.0f];
    userNameLable.textColor = kMM_ProjectColor_DeepGray;
    userNameLable.text = @"阿九";
    [headerview addSubview:userNameLable];
    
    //消息
    contentLable = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 35, kMM_SCREEN_W-80.0f, 25)];
    contentLable.font = [UIFont systemFontOfSize:14.0f];
    contentLable.textColor = [UIColor lightGrayColor];
    contentLable.text = @"微用:shenzhen";
    [headerview addSubview:contentLable];
    
    
    enCodeImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(kMM_SCREEN_W-60.0f, 10, 50, 50)];
    enCodeImageView.placeholderImage = [UIImage imageNamed:@"encode_image"];
    enCodeImageView.image = [UIImage imageNamed:@"encode_image"];
    [headerview addSubview:enCodeImageView];
    
    self.tableView.tableHeaderView = headerview;
    
    
    
}

#pragma mark tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}

-(NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @" ";
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell.imageView setImage:[UIImage imageNamed:_imageArr[indexPath.row]]];
    cell.textLabel.text = _dataArr[indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
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
