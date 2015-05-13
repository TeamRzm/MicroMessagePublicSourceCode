//
//  MMZoneDetailCell.h
//  MicroMessage
//
//  Created by jason on 15/5/10.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "FriendCircleContentEntity.h"


@interface MMZoneDetailCell : UITableViewCell
{
    EGOImageView *logoView;  //用户头像
    UILabel      *nameLabel; // 用户昵称
    UILabel      *contentLabel;  // 内容
    EGOImageView *imageView; ///图片
    UILabel      *locationLabel; //地址信息
    UILabel      *timeLabel; //时间信息
    UIButton     *loveButton; //喜欢
    UIButton     *commentButton; //评论
    
    FriendCircleContentEntity *dataModel;
    float        cellheight;
    
}


@property (nonatomic,strong) FriendCircleContentEntity *dataModel;

-(void)setDataModel:(FriendCircleContentEntity *)_dataModel;

-(float) ReturnCellHeight;


@end
