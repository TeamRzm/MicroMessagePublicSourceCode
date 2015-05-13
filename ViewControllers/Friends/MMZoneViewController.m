//
//  MMZoneViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/9.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMZoneViewController.h"

@interface MMZoneViewController ()

@end

@implementation MMZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"空间"];
    _dataArr  = [[NSMutableArray alloc] init];
    [self LoadData];
    [self.tableView setRowHeight:160.0f];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
}

-(void) LoadData
{
    for (int i =0; i<10; i++)
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
        [_dataArr addObject:entity];
    }
}
#pragma  mark tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMZoneCell *cell = (MMZoneCell *)[self.tableView dequeueReusableCellWithIdentifier:@"MMZoneCell"];
    if (!cell)
    {
        cell = [[MMZoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMZoneCell"];
    }
    
    [cell  setDataModel:_dataArr[indexPath.row]];
    
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
