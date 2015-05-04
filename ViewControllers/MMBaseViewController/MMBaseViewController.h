//
//  MMBaseViewController.h
//  MicroMessage
//
//  Created by Martin.Ren on 15/4/23.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMBaseViewController : UITableViewController<UISearchBarDelegate>
{
    UISearchBar    *_searchBar;
    UISearchDisplayController *_searchcontroller;

}
@property (nonatomic,strong) UISearchBar    *_searchBar;

-(void) SetBaseNavigationRightItem:(NSString *) rightimgname;

-(void) SetBaseNavigationLeftItem:(NSString *) leftimgname;

-(void) SetBaseNavigationRightItemWithTitle:(NSString *) title;

-(void) SetBaseNavigationLeftItemWithTitle:(NSString *) title;


-(void) BaseNavigatinRightItemClicked:(UIButton *) sender;
-(void) BaseNavigatinLeftItemClicked:(UIButton *) sender;

-(void) InitSearchBarView;


@end
