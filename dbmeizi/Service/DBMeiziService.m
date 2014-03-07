//
//  DBMeiziService.m
//  dbmeizi
//
//  Created by kaibin on 14-2-9.
//  Copyright (c) 2014年 kaibin. All rights reserved.
//

#import "DBMeiziService.h"
#import "DBMeizi.h"
#import "StringUtil.h"
#import "LogUtil.h"
#import "HUD.h"
#import "JSONHTTPClient.h"
#import "GlobalConstants.h"

@implementation DBMeiziService

+ (DBMeiziService*)sharedService {
    static DBMeiziService *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[DBMeiziService alloc] init];

    });
    return _sharedInstance;
}

- (void)dbMeiziWithCategory:(NSUInteger)category start:(NSUInteger)start count:(NSUInteger)count handler:(CompletionBlock)handler {
    [HUD showUIBlockingIndicatorWithText:@"Fetching JSON"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *params = @{@"category": @(category), @"start": @(start), @"count": @(count)};
        NSString *url = [NSString addQueryStringToUrlString:kServerAddr withDictionary:params];
        PPDebug(@"Fetching data from: %@", url);
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        NSArray *json = nil;
        NSArray *items = nil;
        if (data) {
            json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            items = [DBMeizi arrayOfModelsFromDictionaries:json];
            PPDebug(@"Result count: %d", [items count]);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD hideUIBlockingIndicator];
            if (handler != NULL) {
                handler(items);
            }
        });
    });
    
}

@end
