//
//  MMOtherViewController.m
//  MicroMessage
//
//  Created by Martin.Ren on 15/4/23.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMOtherViewController.h"
#import "DRNRealTimeBlurView.h"
#import "AppDelegate.h"
#import "MMPublishViewController.h"
#import "MMLoveFriendViewController.h"



@interface MMOtherViewController ()
{
    EGOImageView *avterImageView;
    UILabel *userNameLable;
    UILabel *contentLable;
    EGOImageView *enCodeImageView;
    
    NSMutableArray *_dataArr;
    NSMutableArray *_imageArr;
    NSMutableArray *_titleArr;
    
    DRNRealTimeBlurView *_drnview;
    
    NSMutableArray *_qingyuanArr;
    
    BOOL IsPublish;

}
@end

@implementation MMOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"应用"];
    _dataArr = [[NSMutableArray alloc] initWithObjects:@"空间",@"情缘",@"淘用", nil];
    _imageArr = [[NSMutableArray alloc] initWithObjects:@"btn_kongjian",@"btn_qingyuan",@"btn_taoyong", nil];
    IsPublish = YES;
    if (IsPublish)
    {
        _titleArr =  [[NSMutableArray alloc] initWithObjects:@"搜索交友",@"搜索婚恋",@"我要发布", nil];
            _qingyuanArr = [[NSMutableArray alloc] initWithObjects:@"btn_jiaoyou",@"btn_hunlian",@"btn_write_nor", nil];
    }
    else
    {
        _titleArr =  [[NSMutableArray alloc] initWithObjects:@"搜索交友",@"搜索婚恋",@"取消发布", nil];
            _qingyuanArr = [[NSMutableArray alloc] initWithObjects:@"btn_jiaoyou",@"btn_hunlian",@"btn_write_pressed", nil];
    }
    
    
    
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

-(void) CreateMoSaView
{
    if (!_drnview)
    {
        _drnview = [[DRNRealTimeBlurView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, kMM_SCREEN_H)];
        UIButton *cancelbt = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelbt setFrame:CGRectMake(kMM_SCREEN_W-50.0f, 10.0f, 40.0f, 40.0f)];
        [cancelbt setImage:[UIImage imageNamed:@"btn_delete"] forState:UIControlStateNormal];
        [cancelbt addTarget:self action:@selector(CancleClicked) forControlEvents:UIControlEventTouchUpInside];
        [_drnview addSubview:cancelbt];
        
        for (int i =0 ; i< _qingyuanArr.count; i++)
        {
            UIButton *qingbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            [qingbutton setFrame:CGRectMake(0+i*(kMM_SCREEN_W/3), kMM_SCREEN_H/2-kMM_SCREEN_W/6, kMM_SCREEN_W/3, kMM_SCREEN_W/3)];
            [qingbutton setImage:[UIImage imageNamed:_qingyuanArr[i]] forState:UIControlStateNormal];
            [qingbutton addTarget:self action:@selector(QingYuanClicked:) forControlEvents:UIControlEventTouchUpInside];
            [qingbutton setTag:i];
            [_drnview addSubview:qingbutton];
            
            UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(qingbutton.frame.origin.x, qingbutton.frame.origin.y+qingbutton.frame.size.height-60/2.0f, qingbutton.frame.size.width, 30.0f)];
            [titlelabel setBackgroundColor:[UIColor clearColor]];
            [titlelabel setTextColor:kMM_ProjectColor_DeepGray];
            [titlelabel setTextAlignment:NSTextAlignmentCenter];
            [titlelabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:18.0f]];
            [titlelabel setText:_titleArr[i]];
            [_drnview addSubview:titlelabel];
            
            
        }
        
        
        
        [[AppDelegate sharedDelegate].window addSubview:_drnview];
    }
    
}

-(void) CancleClicked
{
    if (_drnview)
    {
        [_drnview removeFromSuperview];
        _drnview = nil;
    }
}

-(void) QingYuanClicked:(UIButton *) sender
{
    [self CancleClicked];
    switch (sender.tag)
    {
        case 0:
        {
            MMLoveFriendViewController *loveview = [[MMLoveFriendViewController alloc] init];
            [loveview setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:loveview animated:YES];

        }
            break;
            
        case 1:
            break;

        case 2:
        {
            if (IsPublish)
            {
                MMPublishViewController *publishview = [[MMPublishViewController alloc] init];
                [publishview setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:publishview animated:YES];
            }

        }
            break;

            
        default:
            break;
    }
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
        }
            break;
        case 1:
            [self CreateMoSaView];
            break;
        case 2:
            break;

        default:
            break;
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
