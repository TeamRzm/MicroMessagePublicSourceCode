//
//  MMFriendAccessViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/3.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMFriendAccessViewController.h"

@interface MMFriendAccessViewController ()
{
    BOOL AllowToOther;
    BOOL AllowToMySelf;
}

@end

@implementation MMFriendAccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"设置友圈权限"];
    
    AllowToMySelf = NO;
    AllowToOther = NO;
    
    [self.tableView setRowHeight:60.0f];
    
    
}

#pragma mark tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    //消息
    UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 5, kMM_SCREEN_W-80.0f, 20)];
    contentLable.font = [UIFont systemFontOfSize:16.0f];
    contentLable.textColor = kMM_ProjectColor_DeepGray;
    [cell.contentView addSubview:contentLable];
    
    //
    UIButton *actionbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionbt setBackgroundImage:[UIImage imageNamed:@"btn_switchoff"] forState:UIControlStateNormal];
    [actionbt setFrame:CGRectMake(kMM_SCREEN_W-40.0f, 14.0f, 32.0f, 23.0f)];
    [actionbt addTarget:self action:@selector(IsAllowToOther:) forControlEvents:UIControlEventTouchUpInside];
    [actionbt setTag:indexPath.row];
    [cell.contentView addSubview:actionbt];
    
    //消息
    UILabel *bottomLable = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 35, kMM_SCREEN_W-20, 20)];
    bottomLable.font = [UIFont systemFontOfSize:14.0f];
    bottomLable.textColor = kMM_ProjectColor_MidGray;
    [cell.contentView addSubview:bottomLable];
    
    
    
    switch (indexPath.row)
    {
        case 0:
        {
            [contentLable setText:@"不让Ta看我的友圈"];
            [bottomLable setText:@"打开后，您在友圈发的一切信息，对方将无法看到"];
        }
            break;
        case 1:
        {
            [contentLable setText:@"我不看Ta的友圈"];
            [bottomLable setText:@"打开后，对方发的一切信息，将不在我的友圈显示"];
        }
            break;

            
        default:
            break;
    }
    return cell;
}

#pragma mark Method
-(void) IsAllowToOther:(UIButton *) sender
{
    if (sender.tag)
    {
        AllowToOther = !AllowToOther;
        
        if (AllowToOther)
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"btn_switchon"] forState:UIControlStateNormal];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"btn_switchoff"] forState:UIControlStateNormal];
        }

    }
    else
    {
        AllowToMySelf = !AllowToMySelf;
        if (AllowToMySelf)
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"btn_switchon"] forState:UIControlStateNormal];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"btn_switchoff"] forState:UIControlStateNormal];
        }

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
