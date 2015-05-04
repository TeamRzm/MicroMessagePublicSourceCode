//
//  CommentTableViewCell.m
//  NeighborsApp
//
//  Created by Martin.Ren on 15/4/16.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "CommentTableViewCell.h"

@interface CommentTableViewCell()
{
    FriendCircleContentEntity *entity;
    
    NSMutableArray  *subImageViews;
}

@end

@implementation CommentTableViewCell

@synthesize avterImageView;
@synthesize nikeNameLable;
@synthesize contentLable;
@synthesize addressLable;
@synthesize commitDateLable;
@synthesize loogCountLable;
@synthesize pointApprovesLable;
@synthesize contentCountLable;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (void)awakeFromNib {

}

- (void) configView
{
    subImageViews = [[NSMutableArray alloc] init];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    
    //头像
    avterImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:entity.avterURL]];
    avterImageView.frame = CGRectMake(10, 5, 43.0f, 43.0f);
    [self.contentView addSubview:avterImageView];
    
    //昵称
    nikeNameLable = [[UILabel alloc] initWithFrame:CGRectMake(63,
                                                              5,
                                                              kMM_SCREEN_W - (43 + 10 * 3),
                                                              25.0f)];
    nikeNameLable.font = [UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:15.0f];
    nikeNameLable.textColor = [UIColor colorWithRed:26.0f / 255.0f  green:26.0f / 255.0f blue:26.0f / 255.0f alpha:1.0f];
    nikeNameLable.text = entity.nickName;
    nikeNameLable.autoresizingMask = NO;
    
    self.autoresizesSubviews = NO;
    
    [self.contentView addSubview:nikeNameLable];
    
    //内容
    NSMutableParagraphStyle *contentViewStyle = [[NSMutableParagraphStyle alloc] init];
    contentViewStyle.lineHeightMultiple = 1;
    contentViewStyle.lineSpacing = 4.0f;
    contentViewStyle.paragraphSpacing = 3.0f;
    
    //format attribute string dict
    UIFont *contentFont = [UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:14.0f];
    
    NSDictionary *formatDict = @{
                                 NSFontAttributeName               : contentFont,
                                 NSParagraphStyleAttributeName     : contentViewStyle,
                                 NSForegroundColorAttributeName    : [UIColor colorWithRed:26.0f / 255.0f  green:26.0f / 255.0f blue:26.0f / 255.0f alpha:1.0f],
                                 };
    
    CGRect contentStringSize = [entity.content boundingRectWithSize:CGSizeMake(kMM_SCREEN_W - (43 + 10 * 3), 1000)
                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                         attributes:formatDict
                                                            context:nil];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:entity.content];
    
    [attString addAttributes:formatDict range:NSMakeRange(0, entity.content.length)];

    contentLable = [[UILabel alloc] initWithFrame:CGRectMake(nikeNameLable.frame.origin.x, nikeNameLable.frame.origin.y + CGRectGetHeight(nikeNameLable.frame), contentStringSize.size.width, contentStringSize.size.height)];
    contentLable.numberOfLines = 0;
    contentLable.attributedText = attString;
    [self.contentView addSubview:contentLable];
    
    //图片
    NSMutableArray *contentImageViews = [[NSMutableArray alloc] init];
    
    CGSize singleImgSize = CGSizeMake((kMM_SCREEN_W - (43 + 10 * 3) - 10) / 3.0f,
                                      (kMM_SCREEN_W - (43 + 10 * 3) - 10) / 3.0f);
    
    for (int i = 0; i < entity.contentImgURLList.count; i++)
    {
        if (i >= 9)
        {
            return ;
        }
        
        EGOImageView *subImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:entity.contentImgURLList[i]]];
        subImageView.frame = CGRectMake( nikeNameLable.frame.origin.x + (i % 3) * singleImgSize.width,
                                         contentLable.frame.origin.y + contentLable.frame.size.height + (i / 3) * singleImgSize.height + 10,
                                         singleImgSize.width - 2, singleImgSize.height - 2);
        subImageView.layer.borderColor = kMM_ProjectColor_LightGray.CGColor;
        subImageView.layer.borderWidth = 0.5f;
        subImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSubImageView:)];
        [subImageView addGestureRecognizer:tapGesture];
        
        [contentImageViews addObject:subImageView];
        [self.contentView addSubview:subImageView];
        [subImageViews addObject:subImageView];
    }
    
    //小区定位尖脚logo
    NSInteger yIndex = entity.contentImgURLList.count > 9 ? 9 :entity.contentImgURLList.count;
    
    CGFloat tagFrameHeight = contentLable.frame.origin.y + contentLable.frame.size.height + (yIndex / 3) * singleImgSize.height + 10 + 5.5;
    
    //地点
    UIFont *addressContentFont = [UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:12.0f];
    
    //时间
    UIFont *commitDateFont = [UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:11.0f];
    CGSize commitDateStringSize = [entity.address sizeWithAttributes:@{NSFontAttributeName : addressContentFont}];
    
    commitDateLable = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                                10,
                                                                kMM_SCREEN_W - 20,
                                                                commitDateStringSize.height)];
    commitDateLable.text = entity.commitDate;
    commitDateLable.font = commitDateFont;
    commitDateLable.textAlignment = NSTextAlignmentRight;
    commitDateLable.textColor = kMM_ProjectColor_DeepGray;
    [self.contentView addSubview:commitDateLable];
    
    UIImageView *likeIConImageView = [[UIImageView alloc] initWithFrame:CGRectMake(225, tagFrameHeight, 11.5, 10)];
    likeIConImageView.image = [UIImage imageNamed:@"btn_like"];
    
    UILabel *likeIconLable = [[UILabel alloc] initWithFrame:CGRectMake(225 + 11.5 + 3, tagFrameHeight, 40, 10)];
    likeIconLable.font = [UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:10.0f];
    likeIconLable.text = entity.pointApproves;
    likeIconLable.textColor = [UIColor colorWithRed:244.0f / 255.0f green:108 / 255.0f blue:138 / 255.0f alpha:1.0f];
    [self.contentView addSubview:likeIconLable];
    
    UIImageView *commentIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(265, tagFrameHeight, 11.5, 10)];
    commentIconImageView.image = [UIImage imageNamed:@"btn_comment"];
    
    UILabel *commentIconLable = [[UILabel alloc] initWithFrame:CGRectMake(265 + 11.5 + 3, tagFrameHeight - 0.5f, 40, 10)];
    commentIconLable.font = [UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:10.0f];
    commentIconLable.text = @"评论";
    commentIconLable.textColor = [UIColor colorWithRed:244.0f / 255.0f green:108 / 255.0f blue:138 / 255.0f alpha:1.0f];
    [self.contentView addSubview:commentIconLable];
    
    [self.contentView addSubview:likeIConImageView];
    [self.contentView addSubview:commentIconImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setDateEntity : (FriendCircleContentEntity*) _dateEntity
{
    entity = _dateEntity;
    
    [self configView];
}

+ (CGFloat) heightWithEntity : (FriendCircleContentEntity*) _dateEntity
{
    FriendCircleContentEntity *entity = _dateEntity;
    //头像
    EGOImageView *avterImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:entity.avterURL]];
    avterImageView.frame = CGRectMake(10, 5, 43.0f, 43.0f);
    
    //昵称
    UILabel *nikeNameLable = [[UILabel alloc] initWithFrame:CGRectMake(63,
                                                              5,
                                                              kMM_SCREEN_W - (43 + 10 * 3),
                                                              25.0f)];
    
    //内容
    NSMutableParagraphStyle *contentViewStyle = [[NSMutableParagraphStyle alloc] init];
    contentViewStyle.lineHeightMultiple = 1;
    contentViewStyle.lineSpacing = 4.0f;
    contentViewStyle.paragraphSpacing = 3.0f;
    
    //format attribute string dict
    UIFont *contentFont = [UIFont fontWithName:kMM_DEFAULT_FONT_NAME size:14];
    
    NSDictionary *formatDict = @{
                                 NSFontAttributeName               : contentFont,
                                 NSParagraphStyleAttributeName     : contentViewStyle,
                                 NSForegroundColorAttributeName    : kMM_ProjectColor_DeepBlack,
                                 };
    
    CGRect contentStringSize = [entity.content boundingRectWithSize:CGSizeMake(kMM_SCREEN_W - (43 + 10 * 3), 1000)
                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                         attributes:formatDict
                                                            context:nil];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:entity.content];
    
    [attString addAttributes:formatDict range:NSMakeRange(0, entity.content.length)];
    
    UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(nikeNameLable.frame.origin.x, nikeNameLable.frame.origin.y + CGRectGetHeight(nikeNameLable.frame), contentStringSize.size.width, contentStringSize.size.height)];
    
    //图片
    CGSize singleImgSize = CGSizeMake((kMM_SCREEN_W - (43 + 10 * 3) - 10) / 3.0f,
                                      (kMM_SCREEN_W - (43 + 10 * 3) - 10) / 3.0f);
    
    //小区定位尖脚logo
    NSInteger yIndex = entity.contentImgURLList.count > 9 ? 9 :entity.contentImgURLList.count;
    
    CGFloat tagFrameHeight = contentLable.frame.origin.y + contentLable.frame.size.height + (yIndex / 3) * singleImgSize.height + 10 + 5.5;
    
    return tagFrameHeight + 20.0f;
}


- (void) tapSubImageView : (UIGestureRecognizer*) _gesture
{
    if (self.delegate)
    {
        [self.delegate commentTableViewCell:self tapSubImageViews:(UIImageView*)_gesture.view allSubImageViews:subImageViews];
    }
}

@end
