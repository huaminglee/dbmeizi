//
//  DBMeiziService.h
//  dbmeizi
//
//  Created by kaibin on 14-2-9.
//  Copyright (c) 2014年 kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock)(NSArray* array);

@interface DBMeiziService : NSObject

+ (DBMeiziService*)sharedService;

- (void)dbMeiziWithCategory:(NSUInteger)category start:(NSUInteger)start count:(NSUInteger)count handler:(CompletionBlock)handler;

@end
