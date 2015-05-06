//
//  MMContactCell.m
//  MicroMessage
//
//  Created by jason on 15/5/5.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMContactCell.h"
#import "EGOImageView.h"


@implementation MMContactCell
@synthesize dataModel;

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //头像
        avterImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        //        avterImageView.placeholderImage = [UIImage imageNamed:@""];
        //        avterImageView.image = [UIImage imageNamed:subfriend.avterURL];
        avterImageView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
        avterImageView.layer.borderWidth = 1.0f;
        avterImageView.layer.cornerRadius = 4.0f;
        [self.contentView addSubview:avterImageView];
        
        //用户名
        userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, kMM_SCREEN_W-80.0f, 25)];
        userNameLable.font = [UIFont boldSystemFontOfSize:16.0f];
        userNameLable.textColor = kMM_ProjectColor_DeepGray;
        userNameLable.text = dataModel.nickName;
        [self.contentView addSubview:userNameLable];
        
        //消息
        contentLable = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 35, kMM_SCREEN_W-80.0f, 25)];
        contentLable.font = [UIFont systemFontOfSize:14.0f];
        contentLable.textColor = [UIColor lightGrayColor];
        contentLable.text = dataModel.signMessage;
        [self.contentView addSubview:contentLable];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //头像
        avterImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
//        avterImageView.placeholderImage = [UIImage imageNamed:@""];
//        avterImageView.image = [UIImage imageNamed:subfriend.avterURL];
        avterImageView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
        avterImageView.layer.borderWidth = 1.0f;
        [self.contentView addSubview:avterImageView];
        
        //用户名
        userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, kMM_SCREEN_W-80.0f, 20)];
        userNameLable.font = [UIFont boldSystemFontOfSize:13.0f];
        userNameLable.textColor = kMM_ProjectColor_DeepGray;
        userNameLable.text = dataModel.nickName;
        [self.contentView addSubview:userNameLable];
        
        //消息
        contentLable = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 35, kMM_SCREEN_W-80.0f, 20)];
        contentLable.font = [UIFont systemFontOfSize:12.0f];
        contentLable.textColor = [UIColor lightGrayColor];
        contentLable.text = dataModel.signMessage;
        [self.contentView addSubview:contentLable];

    }
    return self;
}

-(void)setDataModel:(MMFriendEntity *) _dataModel
{
    dataModel = _dataModel;
    avterImageView.placeholderImage = [UIImage imageNamed:dataModel.avterURL];
    avterImageView.image = [UIImage imageNamed:dataModel.avterURL];
    userNameLable.text = dataModel.nickName;
    contentLable.text = dataModel.signMessage;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
