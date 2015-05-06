//
//  MMAddGroupViewController.h
//  MicroMessage
//
//  Created by jason on 15/5/4.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMBaseViewController.h"

@interface MMAddGroupViewController : MMBaseViewController
{
    NSMutableArray *_dataArr;
    NSMutableArray *_resultArr;
    NSMutableArray *_searchKeyArr;
    
}
@property (nonatomic,assign) BOOL isSendKard;
@end
