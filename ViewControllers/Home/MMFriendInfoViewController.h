//
//  MMFriendInfoViewController.h
//  MicroMessage
//
//  Created by jason on 15/5/2.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMBaseViewController.h"
#import "MMFriendEntity.h"
#import "MMTypeListView.h"


@interface MMFriendInfoViewController : MMBaseViewController<MMTypeListViewDelegate>
{
    MMTypeListView *_listView;
}
@property (nonatomic,strong) NSString *friendId;
@property (nonatomic,strong) UITableView *selectTableview;
@property (nonatomic,assign) BOOL isSelf;

@end
