//
//  MMChangeTelephoneViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/7.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMChangeTelephoneViewController.h"

@interface MMChangeTelephoneViewController ()
{
    UITextField *oldtellfield;
    UITextField *newtellfield;
    UITextField *confirmtellfield;
    NSMutableArray *_dataArr;
}
@end

@implementation MMChangeTelephoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"修改电话号码"];
    _dataArr = [[NSMutableArray alloc] initWithObjects:@"原电话号码:",@"新电话号码:",@"确认新号码:", nil];
    [self.tableView setRowHeight:60];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self CreateFooterView];


}

-(void) CreateFooterView
{
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, 300.0f)];
    [footview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *noticebt = [UIButton buttonWithType:UIButtonTypeCustom];
    [noticebt setFrame:CGRectMake(20.0f,15.0f, 80.0f, 30.0f)];
    [noticebt setTitleColor:kMM_ProjectColor_StandWhite forState:UIControlStateNormal];
    [noticebt setBackgroundColor:kMM_ProjectColor_StandRed];
    [noticebt setTitle:@"友情提示" forState:UIControlStateNormal];
    [noticebt.layer setCornerRadius:8.0f];
    [footview addSubview:noticebt];
    
    
    UILabel *tipslabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f,noticebt.frame.origin.y+noticebt.frame.size.height+20, kMM_SCREEN_W-40.0f, 80.0f)];
    [tipslabel setTextColor:kMM_ProjectColor_DeepGray];
    [tipslabel setNumberOfLines:0];
    [tipslabel setBackgroundColor:[UIColor clearColor]];
    [tipslabel setText:@"请谨慎操作此功能，如果你已更换新的电话号码，请在此修改，已便使新电话号码作为微用加友方法之一"];
    [tipslabel sizeToFit];
    [footview addSubview:tipslabel];
    

    UIButton *changepwbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [changepwbt setBackgroundColor:kMM_ProjectColor_LightGreen];
    [changepwbt setFrame:CGRectMake(20.0f, tipslabel.frame.origin.y+tipslabel.frame.size.height+20.0f, kMM_SCREEN_W-40.0f, 40.0f)];
    [changepwbt.layer setCornerRadius:4.0f];
    [changepwbt setTitle:@"完成" forState:UIControlStateNormal];
    [changepwbt addTarget:self action:@selector(CommitPassword:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:changepwbt];
    
    [self.tableView setTableFooterView:footview];
    
    
}

#pragma mark tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,15.0f, 100.0f, 30.0f)];
    [titlelabel setTextColor:kMM_ProjectColor_DeepGray];
    [titlelabel setBackgroundColor:[UIColor clearColor]];
    [titlelabel setTextAlignment:NSTextAlignmentRight];
    [titlelabel setText:_dataArr[indexPath.row]];
    [cell.contentView addSubview:titlelabel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(115.0f, 30.0f+8.0f, kMM_SCREEN_W-125.0f, 1)];
    [line setBackgroundColor:kMM_ProjectColor_LineLightGray];
    [cell.contentView addSubview:line];
    
    switch (indexPath.row)
    {
        case 0:
        {
            oldtellfield = [[UITextField alloc] initWithFrame:CGRectMake(line.frame.origin.x, 15.0f, line.frame.size.width, 30.0f)];
            [oldtellfield setTextColor:kMM_ProjectColor_DeepGray];
            [oldtellfield setReturnKeyType:UIReturnKeyDone];
            [oldtellfield setBorderStyle:UITextBorderStyleNone];
            [oldtellfield setDelegate:self];
            [cell.contentView addSubview:oldtellfield];
        }
            break;
        case 1:
        {
            newtellfield = [[UITextField alloc] initWithFrame:CGRectMake(line.frame.origin.x, 15.0f, line.frame.size.width, 30.0f)];
            [newtellfield setTextColor:kMM_ProjectColor_DeepGray];
            [newtellfield setReturnKeyType:UIReturnKeyDone];
            [newtellfield setBorderStyle:UITextBorderStyleNone];
            [newtellfield setDelegate:self];
            [cell.contentView addSubview:newtellfield];
        }
            break;
        case 2:
        {
            confirmtellfield = [[UITextField alloc] initWithFrame:CGRectMake(line.frame.origin.x, 15.0f, line.frame.size.width, 30.0f)];
            [confirmtellfield setTextColor:kMM_ProjectColor_DeepGray];
            [confirmtellfield setReturnKeyType:UIReturnKeyDone];
            [confirmtellfield setBorderStyle:UITextBorderStyleNone];
            [confirmtellfield setDelegate:self];
            [cell.contentView addSubview:confirmtellfield];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

#pragma mark sender Method
-(void) CommitPassword:(UIButton *) sender
{
    NSString *errormessage = nil;
    if(oldtellfield.text.length == 0 || newtellfield.text.length == 0 || confirmtellfield.text.length == 0)
    {
        errormessage = @"密码不能为空";
    }
    else
    {
        if (![newtellfield.text isEqualToString:confirmtellfield.text])
        {
            errormessage = @"新密码与确认密码不一致";
        }
    }
    if (errormessage)
    {
        SIAlertView *alertview = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:errormessage];
        [alertview addButtonWithTitle:@"确认" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertview show];
    }
    else
    {
        //
    }
    
}

#pragma mark textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
