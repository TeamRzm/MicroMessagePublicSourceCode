//
//  MMGroupListView.m
//  MicroMessage
//
//  Created by jason on 15/5/5.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMGroupListView.h"

@implementation MMGroupListView
@synthesize datamodel;
@synthesize delegate;


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self)
    {
        //头像
        logoView= [[EGOImageView alloc] initWithFrame:CGRectMake(15.0f,10 , frame.size.width-10.0f-20.0f, frame.size.width-10.0f-20.0f)];
        logoView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
        logoView.layer.borderWidth = 1.0f;
        [self addSubview:logoView];
        [logoView setUserInteractionEnabled:YES];
        
        //用户名
        nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, logoView.frame.origin.y+logoView.frame.size.height, frame.size.width, 20)];
        nameLable.font = [UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:14.0f];
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.textColor = kMM_ProjectColor_DeepGray;
        [self addSubview:nameLable];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LogoViewClicked)];
        [logoView addGestureRecognizer:gesture];
        
        deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setFrame:CGRectMake(logoView.frame.origin.x+logoView.frame.size.width-12.0f, logoView.frame.origin.y-12.0f, 24.0f, 24.0f)];
        [deleteButton setImage:[UIImage imageNamed:@"btn_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"btn_delete"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        
        
    }
    return self;
}

-(void)setDatamodel:(MMFriendEntity *) _datamodel
{
    datamodel = _datamodel;
    [logoView setPlaceholderImage:[UIImage imageNamed:datamodel.avterURL]];
    [logoView setImageURL:[NSURL URLWithString:datamodel.avterURL]];
    [deleteButton setHidden:!_datamodel.isCanDelete];
    [nameLable setText:datamodel.nickName];
    if ([_datamodel.avterURL isEqualToString:@"add_groupadd_nor"])
    {
        [deleteButton setHidden:YES];
    }
   [nameLable setHidden:!datamodel.isShownickName];
    
}

-(void) deleteClicked
{
    if (delegate && [delegate respondsToSelector:@selector(MMGroupListViewDelete:)])
    {
        [delegate MMGroupListViewDelete:datamodel];
        
    }
}

-(void) LogoViewClicked
{
    if (delegate && [delegate respondsToSelector:@selector(MMGroupListViewDidClicked:)])
    {
        [delegate MMGroupListViewDidClicked:datamodel];
    }
}

@end
