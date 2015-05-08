//
//  MMTypeListView.m
//  MicroMessage
//
//  Created by jason on 15/5/8.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMTypeListView.h"

@implementation MMTypeListView
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame withTitls:(NSMutableArray *)_titles withImages:(NSMutableArray *)_images
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleArr = _titles;
        _imageArr = _images;
        
        UIView *bgview = [[UIView alloc] initWithFrame:frame];
        [bgview setBackgroundColor:kMM_ProjectColor_DeepBlack];
        [bgview setAlpha:0.7];
        [self addSubview:bgview];
        
        UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideListView:)];
        [bgview addGestureRecognizer:tapgesture];
        
        
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width-210.0f, 0.0f, 200.0f, 170.0f)];
        [_tableview setBackgroundView:nil];
        [_tableview setDataSource:self];
        [_tableview setDelegate:self];
        [self addSubview:_tableview];
        
    }
    return self;
    
}

#pragma mark tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_imageArr count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.imageView  setImage:[UIImage imageNamed:_imageArr[indexPath.row]]];
    [cell.textLabel setText:_titleArr[indexPath.row]];
    [cell.textLabel setTextColor:kMM_ProjectColor_StandBlue];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (delegate && [delegate respondsToSelector:@selector(MMTypeListViewClickedWithIndex:)])
    {
        [delegate MMTypeListViewClickedWithIndex:indexPath.row];
    }
}

-(void) HideListView:(UITapGestureRecognizer *) _gesture
{
    if (delegate && [delegate respondsToSelector:@selector(MMTypeListViewCancel)])
    {
        [delegate MMTypeListViewCancel];
    }
}



@end
