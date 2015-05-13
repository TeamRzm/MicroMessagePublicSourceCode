//
//  MMZoneDetailCell.m
//  MicroMessage
//
//  Created by jason on 15/5/10.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMZoneDetailCell.h"

@implementation MMZoneDetailCell
@synthesize dataModel;

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    }
    return self;
    
}

-(void) configView:(FriendCircleContentEntity *) _model
{
    logoView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@""]];
    [logoView setFrame:CGRectMake(10.0f, 10.0f, 50.0f, 50.0f)];
    [self addSubview:logoView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(logoView.frame.origin.x+logoView.frame.size.width+5.0f, logoView.frame.origin.y, kMM_SCREEN_W-70.0f, 25.0f)];
    [nameLabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:14.0f]];
    [nameLabel setTextColor:kMM_ProjectColor_StandBlue];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:nameLabel];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y+nameLabel.frame.size.width+5.0f, kMM_SCREEN_W-70.0f, 25.0f)];
    [contentLabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:14.0f]];
    [contentLabel setTextColor:kMM_ProjectColor_DeepGray];
    [contentLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:contentLabel];
    
    imageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@""]];
    [imageView setFrame:CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y+contentLabel.frame.size.width+5.0f, kMM_SCREEN_W-70.0f, 120.0f)];
    [self addSubview:imageView];
    
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+5.0f, imageView.frame.origin.y, kMM_SCREEN_W-70.0f, 25.0f)];
    [locationLabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:14.0f]];
    [locationLabel setTextColor:kMM_ProjectColor_StandBlue];
    [locationLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:locationLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationLabel.frame.origin.x+locationLabel.frame.size.width+5.0f, locationLabel.frame.origin.y, kMM_SCREEN_W-70.0f, 25.0f)];
    [timeLabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:14.0f]];
    [timeLabel setTextColor:kMM_ProjectColor_StandBlue];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:timeLabel];

    
    
    loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loveButton setFrame:CGRectMake(kMM_SCREEN_W-200.0f, locationLabel.frame.origin.y, 80.0f, 40.0f)];
    [loveButton setTitle:@"喜好" forState:UIControlStateNormal];
    [loveButton setTitleColor:kMM_ProjectColor_StandBlue forState:UIControlStateNormal];
    [self addSubview:loveButton];
    
    commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton setFrame:CGRectMake(kMM_SCREEN_W-100.0f, locationLabel.frame.origin.y, 80.0f, 40.0f)];
    [commentButton setTitle:@"评论" forState:UIControlStateNormal];
    [commentButton setTitleColor:kMM_ProjectColor_StandBlue forState:UIControlStateNormal];
    [self addSubview:commentButton];
    
    cellheight = timeLabel.frame.origin.y+timeLabel.frame.size.height+10.0f;
    
}

-(void)setDataModel:(FriendCircleContentEntity *)_dataModel
{
    dataModel = _dataModel;
    [self configView:dataModel];
}


-(float )ReturnCellHeight
{
    return cellheight;
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
