//
//  LocaleUtils.m
//  three20test
//
//  Created by qqn_pipi on 10-3-20.
//  Copyright 2010 QQN-PIPI.com. All rights reserved.
//

#import "LocaleUtils.h"


@implementation LocaleUtils

+ (NSString *)getCountryCode
{
	NSLocale *currentLocale = [NSLocale currentLocale];
	
//	NSLog(@"Country Code is %@", [currentLocale objectForKey:NSLocaleCountryCode]);	
	return [currentLocale objectForKey:NSLocaleCountryCode];
}

+ (NSString *)getLanguageCode
{
//	NSLocale *currentLocale = [NSLocale currentLocale];
//	
//	NSLog(@"Language Code is %@", [currentLocale objectForKey:NSLocaleLanguageCode]);	
//	
//	return [currentLocale objectForKey:NSLocaleLanguageCode];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
//	NSLog(@"Language Code is %@", currentLanguage);	
    return currentLanguage;
}

+ (BOOL)isChinese
{
    return [[self getLanguageCode] hasPrefix:@"zh-Han"];
}

+ (BOOL)isTraditionalChinese
{
    return [LocaleUtils isChinese] && ![[self getLanguageCode] hasPrefix:@"zh-Hans"];
}


+ (BOOL)isChina
{
	NSLocale *currentLocale = [NSLocale currentLocale];

	NSString* countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
	if ([countryCode isEqualToString:@"CN"])
		return YES;	
	
	return NO;
}

+ (BOOL)isOtherChina
{
	NSLocale *currentLocale = [NSLocale currentLocale];
    
	NSString* countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
	if ([countryCode isEqualToString:@"TW"] || 
        [countryCode isEqualToString:@"HK"] || 
        [countryCode isEqualToString:@"MO"])
		return YES;	
	
	return NO;
}

+ (BOOL)supportChinese
{
    if ([[self getLanguageCode] hasPrefix:@"zh-Han"])
        return YES;

	NSLocale *currentLocale = [NSLocale currentLocale];
	NSString* countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
	if ([countryCode isEqualToString:@"CN"] ||
        [countryCode isEqualToString:@"TW"] ||
        [countryCode isEqualToString:@"HK"] ||
        [countryCode isEqualToString:@"MO"]){
		return YES;
    }	
    
	return NO;
}

@end
