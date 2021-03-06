//
//  MMGroupEntity.h
//  MicroMessage
//
//  Created by jason on 15/5/3.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMGroupEntity : NSObject

@property (nonatomic, copy) NSString* nickName;
@property (nonatomic, copy) NSString* signMessage;
@property (nonatomic, copy) NSString* avterURL;
@property (nonatomic, copy) NSString* firstNameChar;
@property (nonatomic, copy) NSString* inviteState;

@end
