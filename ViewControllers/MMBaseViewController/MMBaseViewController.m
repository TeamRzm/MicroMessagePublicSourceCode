//
//  MMBaseViewController.m
//  MicroMessage
//
//  Created by Martin.Ren on 15/4/23.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMBaseViewController.h"

@interface MMBaseViewController ()

@end

@implementation MMBaseViewController
@synthesize _searchBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.view setBackgroundColor:kMM_ProjectColor_BackGroundGray];

}

-(void) InitSearchBarView
{
    _searchBar=[[UISearchBar alloc] init];
    [_searchBar setFrame:CGRectMake(0.0, 0.0f, kMM_SCREEN_W, 44.0f)];
    [_searchBar setPlaceholder:@"搜索全部好友"];
    [_searchBar setTintColor:kMM_ProjectColor_DeepBlack];
    UIView *searchbarview = [[UIView alloc] initWithFrame:_searchBar.frame];
    [searchbarview setBackgroundColor:kMM_ProjectColor_StandBlue];
    [searchbarview setBackgroundColor:kMM_ProjectColor_BackGroundGray];
    [_searchBar insertSubview:searchbarview atIndex:1];
    
    //    //把搜索条加到headerView上，其实不是很好，可以加到view上更好
    //搜索控制器
    _searchcontroller=[[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    //设置代理(不需要遵循协议)
    _searchcontroller.searchResultsDataSource=self;
    _searchcontroller.searchResultsDelegate=self;
    self.tableView.tableHeaderView = _searchBar;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark navigation Method
-(void) SetBaseNavigationRightItem:(NSString *) rightimgname
{
    UIButton *rightbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbt setFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [rightbt setImage:[UIImage imageNamed:rightimgname] forState:UIControlStateNormal];
    [rightbt setImage:[UIImage imageNamed:rightimgname] forState:UIControlStateHighlighted];
    [rightbt addTarget:self action:@selector(BaseNavigatinRightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithCustomView:rightbt];
    [self.navigationItem setRightBarButtonItem:rightitem];
}

-(void) SetBaseNavigationLeftItem:(NSString *) leftimgname
{
    UIButton *leftbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbt setFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [leftbt setImage:[UIImage imageNamed:leftimgname] forState:UIControlStateNormal];
    [leftbt setImage:[UIImage imageNamed:leftimgname] forState:UIControlStateHighlighted];
    [leftbt addTarget:self action:@selector(BaseNavigatinLeftItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbt];
    [self.navigationItem setLeftBarButtonItem:leftitem];

}

-(void) SetBaseNavigationRightItemWithTitle:(NSString *) title
{
    UIButton *rightbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbt setFrame:CGRectMake(0.0f, 0.0f, 90.0f, 30.0f)];
    UIImage *image = [UIImage imageNamed:@"bg_btnbg_pressed"];
    image = [image stretchableImageWithLeftCapWidth:5.0f topCapHeight:25.0f];
    [rightbt setBackgroundColor:[UIColor colorWithPatternImage:image]];
    [rightbt setBackgroundColor:kMM_ProjectColor_StandBlue];
    [rightbt setTitle:title forState:UIControlStateNormal];
    [rightbt.layer setCornerRadius:4.0f];
    UIFont *font = [UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:16.0f];
    [rightbt setTitleColor:kMM_ProjectColor_StandWhite forState:UIControlStateNormal];
    [rightbt.titleLabel setFont:font];
    [rightbt sizeToFit];
    [rightbt addTarget:self action:@selector(BaseNavigatinRightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightbt setFrame:CGRectMake(0.0f, 0.0f, rightbt.frame.size.width+15.0f, 30.0f)];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithCustomView:rightbt];
    [self.navigationItem setRightBarButtonItem:rightitem];
}

-(void) SetBaseNavigationLeftItemWithTitle:(NSString *) title
{
    UIButton *leftbt = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbt setFrame:CGRectMake(0.0f, 0.0f, 90.0f, 30.0f)];
    UIImage *image = [UIImage imageNamed:@"bg_btnbg_pressed"];
    image = [image stretchableImageWithLeftCapWidth:5.0f topCapHeight:25.0f];
    [leftbt setBackgroundColor:[UIColor colorWithPatternImage:image]];
    [leftbt setBackgroundColor:kMM_ProjectColor_StandBlue];
    [leftbt setTitle:title forState:UIControlStateNormal];
    [leftbt.layer setCornerRadius:4.0f];
    [leftbt setTitleColor:kMM_ProjectColor_StandWhite forState:UIControlStateNormal];
    [leftbt.titleLabel setFont:[UIFont fontWithName:kMM_DEFAULT_FONT_NAME_BLOD size:16.0f]];
    [leftbt sizeToFit];
    [leftbt setFrame:CGRectMake(0.0f, 0.0f, leftbt.frame.size.width+15.0f, 30.0f)];
    [leftbt addTarget:self action:@selector(BaseNavigatinLeftItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithCustomView:leftbt];
    [self.navigationItem setLeftBarButtonItem:leftitem];
}


-(void) BaseNavigatinRightItemClicked:(UIButton *) sender
{
     NSLog(@"right item clicked!");
}
-(void) BaseNavigatinLeftItemClicked:(UIButton *) sender
{
    NSLog(@"left item clicked!");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
