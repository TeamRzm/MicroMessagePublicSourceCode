//
//  MMChatViewController.m
//  MicroMessage
//
//  Created by jason on 15/5/2.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMChatViewController.h"
#import "MMGroupSettingViewController.h"
#import "aya_MultimediaKeyBoard.h"


@interface MMChatViewController ()
{
    NSMutableArray *chatMessageArr;
    aya_MultimediaKeyBoard *keyBoard;
    UITableView  *table_view;
    NSIndexPath *lastindexpath;
    UIImagePickerController *pickview;
    UIButton *hidebutton;
    
}
@end

@implementation MMChatViewController
@synthesize targetName;
@synthesize isGroupChat;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:targetName];
    if (isGroupChat)
    {
        [self SetBaseNavigationRightItem:@"btn_youquan"];
    }
    
    table_view = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,0.0f, kMM_SCREEN_W, kMM_SCREEN_H-45.0)];
    [table_view setDataSource:self];
    [table_view setDelegate:self];
    [table_view setBackgroundColor:kMM_ProjectColor_BackGroundGray];
    self.view.backgroundColor=kMM_ProjectColor_BackGroundGray;
    //[table_view setBackgroundView:nil];
    [table_view setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //  [table_view setRowHeight:80.0f];
    [self.view addSubview:table_view];
    
    
    chatMessageArr = [[NSMutableArray alloc] init];
    
    [self LoadData];
    
    
    keyBoard = [[aya_MultimediaKeyBoard alloc] init];
    [self.view addSubview:keyBoard];
    [keyBoard setDelegate:self];
    
    [self selectLastCell];
    
}

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


-(void) LoadData
{
    for (int i = 0; i< 20; i++)
    {
        
        MMMessageEntity *subEntity = [[MMMessageEntity alloc] init];
        if (i%2==0)
        {
            subEntity.M_From = @"you";
            subEntity.M_To = @"me";
        }
        else
        {
            subEntity.M_From = @"me";
            subEntity.M_To = @"you";
        }
        
        subEntity.M_Owner = @"self";
        subEntity.M_Status = @"sended";
        subEntity.M_Msg = @"你好,欢迎使用微用";
        
        subEntity.M_LastUpdateTime = [NSDate date];
        
        [chatMessageArr addObject:subEntity];
        
    }
}

#pragma mark Override Method
-(void)BaseNavigatinRightItemClicked:(UIButton *)sender
{
    MMGroupSettingViewController *settingview = [[MMGroupSettingViewController alloc] init];
    [settingview setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:settingview animated:YES];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [chatMessageArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier     =   @"ChatRightCell";
    static NSString *CellIdentifier1    =   @"ChatLeftCell";
    
    MMMessageEntity *enity=[chatMessageArr objectAtIndex:indexPath.row];
    
    if([enity.M_From isEqualToString:@"me"])
    {
        ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell    =[[ChatListCell alloc]initRightCellUnitWithModel:enity className:CellIdentifier Withdelegate:self];
        }
        
        [cell configRightCellUnitWithModel:enity className:CellIdentifier];
        cell.backgroundColor=kMM_ProjectColor_BackGroundGray;
        return cell;
    }
    else
    {
        ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil)
        {
            cell   =[[ChatListCell alloc]initCellUnitWithModel:enity className:CellIdentifier1 Withdelegate:self];
        }
        [cell configCellUnitWithModel:enity className:CellIdentifier1];
        cell.backgroundColor=kMM_ProjectColor_BackGroundGray;
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatListCell *cell = (ChatListCell *)[self tableView:table_view cellForRowAtIndexPath:indexPath];
    return [cell ReturnCellHeight];
}

-(void) selectLastCell
{
    if ([chatMessageArr count]>0)
    {
        [table_view scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[chatMessageArr count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
    
}


#pragma mark chatlistcell delegate
-(void)ChatListCellGoToWebViewWithCell:(ChatListCell *)_cell WithMode:(id)_model WithUrl:(NSString *)_url
{
}


-(void)ChatListCellClickImageWithCell:(ChatListCell *)_cell WithModel:(id)_model
{
}

-(void)ChatListCellReSendMesssageWithCell:(ChatListCell *)_cell WithMode:(id)_model
{
}

-(void)ChatListCellGoToZoneWithCell:(ChatListCell *)_cell WithMode:(id)_model
{
}

-(void)ChatListCellPlayVoiceWithCell:(ChatListCell *)_cell WithModel:(id)_model
{
    
}

#pragma mark aya_keyboard
-(void)ayaKeyBoard:(aya_MultimediaKeyBoard *)_keyboard quikLookImg:(UIImage *)_limg
{
    
}

-(void)ayaKeyBoard:(aya_MultimediaKeyBoard *)_keyboard willChangedKeyBoardStatus:(KEYBOARD_STATUS)_status currKeyboardHeight:(CGFloat)_height
{
    
    if (_status == KEYBOARD_STATUS_TEXT || _status == KEYBOARD_STATUS_FACE || _status == KEYBOARD_STATUS_OTHER )
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            
            [table_view setFrame:CGRectMake(0.0f,-_height+44.0f, table_view.frame.size.width, kMM_SCREEN_H-45.0f)];
        }];
        [self  selectLastCell];
        if (hidebutton)
        {
            [hidebutton removeFromSuperview];
        }
        hidebutton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, kMM_SCREEN_H-_height-60.0f)];
        [hidebutton setBackgroundColor:[UIColor clearColor]];
        [hidebutton addTarget:self action:@selector(HideKeyboard) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:hidebutton];
        [self.view bringSubviewToFront:keyBoard];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^
         {
             
             [table_view setFrame:CGRectMake(table_view.frame.origin.x, 0.0, table_view.frame.size.width, kMM_SCREEN_H-45.0f)];
             
             [self selectLastCell];
         }];
        if (hidebutton)
        {
            [hidebutton removeFromSuperview];
            hidebutton = nil;
        }
        
        
    }
    
}

-(void)ayaKeyBoard:(aya_MultimediaKeyBoard *)_keyboard willFinishInputAmrData:(NSData *)_amrStrame timeLen:(NSTimeInterval)_timeLen
{
    MMMessageEntity *enity =[[MMMessageEntity alloc]init];
    enity.M_Status =    @"Sended";
    
    enity.M_Msg =[NSString stringWithFormat:@"[voice]%@,%.0f[/voice]",@"",_timeLen];
    enity.M_From=@"me";
    enity.M_To  =@"you";
    NSDateFormatter *ft1 = [[NSDateFormatter alloc] init];
    [ft1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [ft1 setDoesRelativeDateFormatting:YES];
    [ft1 setDateStyle:NSDateFormatterShortStyle];
    [ft1 setTimeStyle:NSDateFormatterNoStyle];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: [NSDate date]];
    
    NSDate *localeDate = [[NSDate date]  dateByAddingTimeInterval: interval];
    
    enity.M_LastUpdateTime=localeDate;
    enity.M_Owner=@"me";
    
    [chatMessageArr addObject:enity];
    lastindexpath = [NSIndexPath indexPathForRow:[chatMessageArr count]-1 inSection:0];
    [table_view insertRowsAtIndexPaths:[NSArray arrayWithObjects:lastindexpath, nil] withRowAnimation:UITableViewRowAnimationNone];
    [self selectLastCell];
    
}
-(void)ayaKeyBoard:(aya_MultimediaKeyBoard *)_keyboard willFinishInputMsg:(NSString *)_string
{
    MMMessageEntity *enity =[[MMMessageEntity alloc]init];
    enity.M_Status =    @"Sended";
    enity.M_Msg = _string;
    enity.M_From=@"me";
    enity.M_To  =@"you";
    NSDateFormatter *ft1 = [[NSDateFormatter alloc] init];
    [ft1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [ft1 setDoesRelativeDateFormatting:YES];
    [ft1 setDateStyle:NSDateFormatterShortStyle];
    [ft1 setTimeStyle:NSDateFormatterNoStyle];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: [NSDate date]];
    
    NSDate *localeDate = [[NSDate date]  dateByAddingTimeInterval: interval];
    
    enity.M_LastUpdateTime=localeDate;
    enity.M_Owner=@"me";
    
    [chatMessageArr addObject:enity];
    lastindexpath = [NSIndexPath indexPathForRow:[chatMessageArr count]-1 inSection:0];
    [table_view insertRowsAtIndexPaths:[NSArray arrayWithObjects:lastindexpath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
    [self selectLastCell];
    
}
-(void)ayaKeyBoard:(aya_MultimediaKeyBoard *)_keyboard willSelectOtherBoardIndex:(NSInteger)_index
{
    switch (_index)
    {
        case 0:
        {
            if(pickview == nil)
            {
                pickview = [[UIImagePickerController alloc] init];
                
                [pickview setDelegate:self];
            }
            if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前设备无法拍照" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
                return ;
            }
            [pickview setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:pickview animated:YES completion:nil];        }
            break;
        case 1:
        {
            if(pickview == nil)
            {
                pickview = [[UIImagePickerController alloc] init];
                [pickview setDelegate:self];
            }
            [pickview setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:pickview animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
}

-(void) HideKeyboard
{
    [keyBoard hidekeyboardview];
    [hidebutton removeFromSuperview];
    hidebutton = nil;
}


#pragma mark UIImagePickerController  delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"])
    {
        UIImage *temimage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage * originImage= [self compressImageWith:temimage width:kMM_SCREEN_W height:kMM_SCREEN_H];
        
        MMMessageEntity *enity =[[MMMessageEntity alloc]init];
        enity.M_Status =    @"Sended";
        enity.M_Msg =[NSString stringWithFormat:@"[img]%@[/img]",@"t_avter_4,50X50"];
        enity.M_From=@"me";
        enity.M_To  =@"you";
        NSDateFormatter *ft1 = [[NSDateFormatter alloc] init];
        [ft1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [ft1 setDoesRelativeDateFormatting:YES];
        [ft1 setDateStyle:NSDateFormatterShortStyle];
        [ft1 setTimeStyle:NSDateFormatterNoStyle];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: [NSDate date]];
        NSDate *localeDate = [[NSDate date]  dateByAddingTimeInterval: interval];
        enity.M_LastUpdateTime=localeDate;
        enity.M_Owner=@"me";
        [chatMessageArr addObject:enity];
        
        lastindexpath = [NSIndexPath indexPathForRow:[chatMessageArr count]-1 inSection:0];
        
        [table_view insertRowsAtIndexPaths:[NSArray arrayWithObjects:lastindexpath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
        [self selectLastCell];
        
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    return;
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIImage *)compressImageWith:(UIImage *)image width:(float)width height:(float)height
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    
    float widthScale = imageWidth /640;
    float heightScale = imageHeight;
    float newwidth = imageWidth;
    if (imageWidth >= 640)
    {
        newwidth = 640.0f;
        heightScale = imageHeight / widthScale;
    }
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(newwidth, heightScale));
    
    [image drawInRect:CGRectMake(0, 0, newwidth , heightScale)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
