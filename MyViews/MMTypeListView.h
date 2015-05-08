//
//  MMTypeListView.h
//  MicroMessage
//
//  Created by jason on 15/5/8.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MMTypeListViewDelegate<NSObject>

-(void) MMTypeListViewClickedWithIndex:(NSInteger) index;

-(void) MMTypeListViewCancel;

@end

@interface MMTypeListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_titleArr;
    NSMutableArray *_imageArr;
}
@property (nonatomic,assign) id<MMTypeListViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame withTitls:(NSMutableArray *) _titles withImages:(NSMutableArray *) _images;


@end
