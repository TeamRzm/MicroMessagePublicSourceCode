//
//  ConversationEntity.h
//  MicroMessage
//
//  Created by Martin.Ren on 15/4/23.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConversationEntity : NSObject
@property (nonatomic, copy) NSString* userName;
@property (nonatomic, copy) NSString* lastMessage;
@property (nonatomic, copy) NSString* avterURL;
@property (nonatomic, copy) NSString* sendData;
@end
