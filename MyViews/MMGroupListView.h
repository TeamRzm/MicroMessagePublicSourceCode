//
//  MMGroupListView.h
//  MicroMessage
//
//  Created by jason on 15/5/5.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMFriendEntity.h"

@protocol MMGroupListViewDelegate <NSObject>

-(void) MMGroupListViewDidClicked:(MMFriendEntity *) _model;
-(void) MMGroupListViewDelete:(MMFriendEntity *) _model;

@end

@interface MMGroupListView : UIView
{
    EGOImageView *logoView;
    UILabel      *nameLable;
    UIButton     *deleteButton;
    MMFriendEntity *datamodel;
}

@property (nonatomic,strong) MMFriendEntity *datamodel;
@property (nonatomic,assign) id<MMGroupListViewDelegate> delegate;


@end
