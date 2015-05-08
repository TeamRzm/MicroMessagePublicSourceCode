//
//  MMChangePasswordViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/7.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMChangePasswordViewController.h"

@interface MMChangePasswordViewController ()
{
    UITextField *oldfield;
    UITextField *newfield;
    UITextField *confirmfield;
    NSMutableArray *_dataArr;
}

@end

@implementation MMChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"修改密码"];
    _dataArr = [[NSMutableArray alloc] initWithObjects:@"老密码:",@"新密码:",@"确认新密码:", nil];
    [self.tableView setRowHeight:60];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self CreateFooterView];
    
}

-(void) CreateFooterView
{
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMM_SCREEN_W, 300.0f)];
    [footview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *changepwbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [changepwbt setBackgroundColor:kMM_ProjectColor_LightGreen];
    [changepwbt setFrame:CGRectMake(20.0f, 20.0f, kMM_SCREEN_W-40.0f, 40.0f)];
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
            oldfield = [[UITextField alloc] initWithFrame:CGRectMake(line.frame.origin.x, 15.0f, line.frame.size.width, 30.0f)];
            [oldfield setTextColor:kMM_ProjectColor_DeepGray];
            [oldfield setReturnKeyType:UIReturnKeyDone];
            [oldfield setSecureTextEntry:YES];
            [oldfield setBorderStyle:UITextBorderStyleNone];
            [oldfield setDelegate:self];
            [cell.contentView addSubview:oldfield];
        }
            break;
        case 1:
        {
            newfield = [[UITextField alloc] initWithFrame:CGRectMake(line.frame.origin.x, 15.0f, line.frame.size.width, 30.0f)];
            [newfield setTextColor:kMM_ProjectColor_DeepGray];
            [newfield setReturnKeyType:UIReturnKeyDone];
            [newfield setSecureTextEntry:YES];
            [newfield setBorderStyle:UITextBorderStyleNone];
            [newfield setDelegate:self];
            [cell.contentView addSubview:newfield];
        }
            break;
        case 2:
        {
            confirmfield = [[UITextField alloc] initWithFrame:CGRectMake(line.frame.origin.x, 15.0f, line.frame.size.width, 30.0f)];
            [confirmfield setTextColor:kMM_ProjectColor_DeepGray];
            [confirmfield setReturnKeyType:UIReturnKeyDone];
            [confirmfield setSecureTextEntry:YES];
            [confirmfield setBorderStyle:UITextBorderStyleNone];
            [confirmfield setDelegate:self];
            [cell.contentView addSubview:confirmfield];
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
    if(oldfield.text.length == 0 || newfield.text.length == 0 || confirmfield.text.length == 0)
    {
        errormessage = @"密码不能为空";
    }
    else
    {
        if (![newfield.text isEqualToString:confirmfield.text])
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
