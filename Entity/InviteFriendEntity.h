//
//  InviteFriendEntity.h
//  MicroMessage
//
//  Created by jason on 15/5/2.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InviteFriendEntity : NSObject

@property (nonatomic, copy) NSString* nickname;
@property (nonatomic, copy) NSString* inviteMessage;
@property (nonatomic, copy) NSString* avterURL;
@property (nonatomic, copy) NSString* inviteState;

@end
