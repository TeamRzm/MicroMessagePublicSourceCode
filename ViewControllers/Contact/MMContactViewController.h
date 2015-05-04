//
//  MMContactViewController.h
//  MicroMessage
//
//  Created by Martin.Ren on 15/4/23.
//  Copyright (c) 2015年 Martin.Ren. All rights reserved.
//

#import "MMBaseViewController.h"

@interface MMContactViewController : MMBaseViewController<UISearchBarDelegate,UITextFieldDelegate>
{
    //数据源数组
    NSMutableArray*_dataArray;
    NSMutableArray *_resultData;
    NSMutableArray *_searchKeyArr;
}
@end
