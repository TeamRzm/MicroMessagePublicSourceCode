//
//  MMZoneCell.m
//  MicroMessage
//
//  Created by jason on 15/5/9.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMZoneCell.h"

@implementation MMZoneCell
@synthesize dataModel;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        timelabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 80.0f, 25.0f)];
        [timelabel setBackgroundColor:kMM_ProjectColor_StandBlue];
        [timelabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:14.0f]];
        [timelabel setTextAlignment:NSTextAlignmentCenter];
        [timelabel setTextColor:kMM_ProjectColor_StandWhite];
        [self addSubview:timelabel];
        
        imageView = [[EGOImageView alloc] initWithFrame:CGRectMake(timelabel.frame.origin.x, timelabel.frame.size.height+timelabel.frame.origin.y, 200.0f, 120.0f)];
        [self addSubview:imageView];
        
        contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+5.0f, imageView.frame.origin.y, kMM_SCREEN_W-imageView.frame.origin.x-imageView.frame.size.width-10.0f, 25.0f)];
        [contentlabel setNumberOfLines:0];
        [contentlabel setBackgroundColor:[UIColor clearColor]];
        [contentlabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:14.0f]];
        [contentlabel setTextColor:kMM_ProjectColor_DeepGray];
        [self addSubview:contentlabel];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

-(void)setDataModel:(FriendCircleContentEntity *) _dataModel
{
    dataModel = _dataModel;
    
    timelabel.text = dataModel.commitDate;
    [imageView setPlaceholderImage:[UIImage imageNamed:dataModel.contentImgURLList[0]]];
    [imageView setImageURL:[NSURL URLWithString:dataModel.contentImgURLList[0]]];
    [contentlabel setFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+5.0f, imageView.frame.origin.y, kMM_SCREEN_W-imageView.frame.origin.x-imageView.frame.size.width-10.0f, 25.0f)];
    contentlabel.text = dataModel.content;
    [contentlabel sizeToFit];
    
    if (contentlabel.frame.size.height > imageView.frame.size.height)
    {
        [contentlabel setFrame:CGRectMake(contentlabel.frame.origin.x, contentlabel.frame.origin.y, contentlabel.frame.size.width, imageView.frame.size.height)];
        
    }
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
