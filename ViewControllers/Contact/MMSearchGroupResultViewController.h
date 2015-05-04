//
//  MMSearchGroupResultViewController.h
//  MicroMessage
//
//  Created by jason on 15/5/4.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMBaseViewController.h"

@interface MMSearchGroupResultViewController : MMBaseViewController
{
    NSMutableArray *_dataArr;
    NSMutableArray *_sectionTitleArr;
}
@property (nonatomic,strong) NSString *searchKey;
@end
