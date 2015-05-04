//
//  MMFriendsViewController.m
//  MicroMessage
//
//  Created by Martin.Ren on 15/4/23.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMFriendsViewController.h"
#import "XHImageViewer.h"
#import "CommentTableViewCell.h"

@interface MMFriendsViewController () <UITableViewDelegate, UITableViewDataSource,CommentTableViewCellDelegate,XHImageViewerDelegate>
{
    UITableView *boundTableView;
    
    NSMutableArray *boundTableViewDataSource;
    
    UIView *tableViewHeadView;
    
    EGOImageView *headAvterImageView;
    
    UILabel *userNameLable;
}
@end

@implementation MMFriendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"友圈";
    // Do any additional setup after loading the view.
    boundTableViewDataSource = [[NSMutableArray alloc] init];
    
    boundTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMM_SCREEN_W, kMM_SCREEN_H)
                                                  style:UITableViewStyleGrouped];
    boundTableView.delegate = self;
    boundTableView.dataSource = self;
    [self.view addSubview:boundTableView];
    
    
    tableViewHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMM_SCREEN_W, 200)];
    UIImageView *backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMM_SCREEN_W, 200.0f)];
    backGroundView.image = [UIImage imageNamed:@"yourown_1.jpg"];
    [tableViewHeadView addSubview:backGroundView];
    boundTableView.tableHeaderView = tableViewHeadView;
    
    UIImageView *lineRectImage = [[UIImageView alloc] initWithFrame:CGRectMake(kMM_SCREEN_W / 2.0f - 55.0f / 2.0f, 100.0f, 55.0f, 55.0f)];
    lineRectImage.image = [UIImage imageNamed:@"bg_imgframe"];
    [tableViewHeadView addSubview:lineRectImage];
    
    headAvterImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"t_avter_9"]];
    headAvterImageView.frame = CGRectMake(kMM_SCREEN_W / 2.0f - 50.0f / 2.0f, 102.5f, 50.0f, 50.0f);
    [tableViewHeadView addSubview:headAvterImageView];
    
    userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 165, kMM_SCREEN_W, 20)];
    userNameLable.font = [UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:14.0f];
    userNameLable.textColor = [UIColor whiteColor];
    userNameLable.text = @"怪蜀黍隔壁的小妹妹";
    userNameLable.textAlignment = NSTextAlignmentCenter;
    [tableViewHeadView addSubview:userNameLable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return boundTableViewDataSource.count;
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCircleContentEntity *entity = [[FriendCircleContentEntity alloc] init];
    entity.avterURL = @"t_avter_9";
    entity.content = @"     深入贯彻习主席系列重要讲话精神特别是关于加强纪律建设的重要指示，紧紧围绕实现党在新形势下的强军目标，认真落实依法治军、从严治军要求，对严格军队党员领导干部纪律约束作出明确规定，是新形势下严格党员领导干部纪律约束、加强军队纪律建设的重要指导性文件。";
    entity.contentImgURLList = @[@"t_avter_5",@"t_avter_6",@"t_avter_7",@"t_avter_8",@"t_avter_1",@"t_avter_2",@"t_avter_3",@"t_avter_4",@"t_avter_0"];
    entity.address = @"新家园小区";
    entity.nickName = @"邻家小妹";
    entity.commitDate = @"5分钟前";
    entity.lookCount = @"2031";
    entity.pointApproves = @"232";
    entity.commentCount = @"14";
    
    return [CommentTableViewCell heightWithEntity:entity];
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMM_TABLEVIEW_CELL_NOIDENTIFIER];
    cell.delegate = self;
    FriendCircleContentEntity *entity = [[FriendCircleContentEntity alloc] init];
    entity.avterURL = @"t_avter_9";
    entity.content = @"     深入贯彻习主席系列重要讲话精神特别是关于加强纪律建设的重要指示，紧紧围绕实现党在新形势下的强军目标，认真落实依法治军、从严治军要求，对严格军队党员领导干部纪律约束作出明确规定，是新形势下严格党员领导干部纪律约束、加强军队纪律建设的重要指导性文件。";
    entity.contentImgURLList = @[@"t_avter_5",@"t_avter_6",@"t_avter_7",@"t_avter_8",@"t_avter_1",@"t_avter_2",@"t_avter_3",@"t_avter_4",@"t_avter_0"];
    entity.address = @"新家园小区";
    entity.nickName = @"邻家小妹";
    entity.commitDate = @"5分钟前";
    entity.lookCount = @"2031";
    entity.pointApproves = @"232";
    entity.commentCount = @"14";
    [cell setDateEntity:entity];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (currentSegmentIndex == 0 || currentSegmentIndex == 2)
//    {
//        ComentDetailViewController *nVC = [[ComentDetailViewController alloc] initWithNibName:nil bundle:nil];
//        nVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nVC animated:YES];
//    }
//    else if (currentSegmentIndex == 1)
//    {
//        ActivityDetailViewController *nVC = [[ActivityDetailViewController alloc] initWithNibName:nil bundle:nil];
//        nVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nVC animated:YES];
//    }
//    
//    return ;
}

- (void) commentTableViewCell : (CommentTableViewCell*) _cell tapSubImageViews : (UIImageView*) tapView allSubImageViews : (NSMutableArray *) _allSubImageviews
{
    XHImageViewer *imageViewer = [[XHImageViewer alloc] init];
    imageViewer.delegate = self;
    [imageViewer showWithImageViews:_allSubImageviews selectedView:tapView];
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
