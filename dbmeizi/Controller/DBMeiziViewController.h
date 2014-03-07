//
//  DBMeiziViewController.h
//  dbmeizi
//
//  Created by kaibin on 14-2-8.
//  Copyright (c) 2014年 kaibin. All rights reserved.
//

#import "CollectionViewController.h"
#import "LoadingMoreFooterView.h"

typedef void (^RevealBlock)();

@interface DBMeiziViewController : WaterflowCollectionViewController
{

}

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic) NSUInteger category;

- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock;
- (id)initWithTitle:(NSString *)title withCategory:(NSUInteger)category withRevealBlock:(RevealBlock)revealBlock;

@end
