//
//  MMChatViewController.h
//  MicroMessage
//
//  Created by jason on 15/5/2.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMBaseViewController.h"
#import "ChatListCell.h"
#import "aya_MultimediaKeyBoard.h"


@interface MMChatViewController : UIViewController<ChatListCellDelegate,aya_MultimediaKeyBoardDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) NSString *targetName;
@property (nonatomic,assign) BOOL isGroupChat;
@end
