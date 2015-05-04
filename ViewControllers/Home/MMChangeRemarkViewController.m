//
//  MMChangeRemarkViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/3.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMChangeRemarkViewController.h"

@interface MMChangeRemarkViewController ()
{
    UITextField *_textfield;
}
@end

@implementation MMChangeRemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"备注信息"];
    [self SetBaseNavigationRightItemWithTitle:@"完成"];
    [self.tableView setRowHeight:70.0f];
    [self.tableView setSectionHeaderHeight:30.0f];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

#pragma  mark tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    _textfield = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 15.0f, kMM_SCREEN_W-20.0f, 40.0f)];
    [_textfield setBorderStyle:UITextBorderStyleNone];
    [_textfield.layer setBorderColor:kMM_ProjectColor_LineLightGray.CGColor];
    [_textfield.layer setBorderWidth:1.0f];
    [_textfield setClearButtonMode:UITextFieldViewModeAlways];
    [_textfield setTextColor:kMM_ProjectColor_DeepGray];
    [_textfield setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:16.0f]];
    [cell.contentView addSubview:_textfield];
    
    return cell;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, 30.0f)];
    [sectionview setBackgroundColor:[UIColor clearColor]];
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, kMM_SCREEN_W-20.0f, 30.0f)];
    [titlelabel setBackgroundColor:[UIColor clearColor]];
    [titlelabel setTextColor:kMM_ProjectColor_MidGray];
    [titlelabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:18.0f]];
    [titlelabel setText:@"备注名"];
    [sectionview addSubview:titlelabel];
    return sectionview;
    
    
}

#pragma mark Method
-(void)BaseNavigatinRightItemClicked:(UIButton *)sender
{
    if (_textfield.text.length == 0)
    {
        SIAlertView *alertview = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"备注名不能为空,请重新输入备注名"];
        [alertview addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:nil];
        [alertview show];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeRemark_Notifiy" object:_textfield.text];
        [self.navigationController popViewControllerAnimated:YES];
        
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
