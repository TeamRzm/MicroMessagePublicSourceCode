//
//  MMLoveFriendViewController.h
//  MicroMessage
//
//  Created by jason on 15/5/7.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMBaseViewController.h"
#import "MMTypeListView.h"


@interface MMLoveFriendViewController : MMBaseViewController<MMTypeListViewDelegate>
{
    NSMutableArray *_friendArr;
    NSMutableArray *_loactionArr;
    MMTypeListView *_listView;
}

@end
