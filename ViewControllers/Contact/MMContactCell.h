//
//  MMContactCell.h
//  MicroMessage
//
//  Created by jason on 15/5/5.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMFriendEntity.h"


@interface MMContactCell : UITableViewCell
{
    EGOImageView *avterImageView;
    UILabel *userNameLable;
    UILabel *contentLable;
    
    MMFriendEntity *model;
    
}

@property (nonatomic,strong) MMFriendEntity *dataModel;



@end
