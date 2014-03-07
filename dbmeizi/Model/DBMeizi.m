//
//  Meizi.m
//  dbmeizi
//
//  Created by kaibin on 14-2-9.
//  Copyright (c) 2014年 kaibin. All rights reserved.
//

#import "DBMeizi.h"

@implementation DBMeizi

// Map automatically under_score case to camelCase
+ (JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
