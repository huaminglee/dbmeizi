//
//  DBMeizi.h
//  dbmeizi
//
//  Created by kaibin on 14-2-9.
//  Copyright (c) 2014年 kaibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface DBMeizi : JSONModel

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *img;
@property (strong, nonatomic) NSString *bigImg;
@property (strong, nonatomic) NSString *people;
@property (strong, nonatomic) NSString *topic;
@property (strong, nonatomic) NSString *name;

@end
