//
//  MMFriendInfoViewController.h
//  MicroMessage
//
//  Created by jason on 15/5/2.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMBaseViewController.h"
#import "MMFriendEntity.h"

@interface MMFriendInfoViewController : MMBaseViewController
@property (nonatomic,strong) NSString *friendId;
@property (nonatomic,strong) UITableView *selectTableview;

@end
