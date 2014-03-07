//
//  AppDelegate.m
//  dbmeizi
//
//  Created by kaibin on 14-2-8.
//  Copyright (c) 2014年 kaibin. All rights reserved.
//

#import "AppDelegate.h"
#import "GHMenuCell.h"
#import "GHMenuViewController.h"
#import "DBMeiziViewController.h"
#import "GHRevealViewController.h"
#import "TimeUtils.h"

static int sexyCategory = 1;
static int cleavageCategory = 2;
static int prettyLegsCategory = 3;
static int cuteCategory = 11;
static int artisticCategory = 12;

@interface AppDelegate ()
@property (nonatomic, strong) GHRevealViewController *revealController;
@property (nonatomic, strong) GHMenuViewController *menuController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	UIColor *bgColor = [UIColor colorWithRed:(50.0f/255.0f) green:(57.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
	self.revealController = [[GHRevealViewController alloc] initWithNibName:nil bundle:nil];
	self.revealController.view.backgroundColor = bgColor;
	
	RevealBlock revealBlock = ^(){
		[self.revealController toggleSidebar:!self.revealController.sidebarShowing
									duration:kGHRevealSidebarDefaultAnimationDuration];
	};
	
	NSArray *headers = @[[NSNull null], @"豆瓣妹子"];
	NSArray *controllers = @[
                             @[
                                 [[UINavigationController alloc] initWithRootViewController:[[DBMeiziViewController alloc] initWithTitle:@"首页" withRevealBlock:revealBlock]]
                                 ],
                             @[
                                 [[UINavigationController alloc] initWithRootViewController:[[DBMeiziViewController alloc] initWithTitle:@"性感" withCategory:sexyCategory withRevealBlock:revealBlock]],
                                 [[UINavigationController alloc] initWithRootViewController:[[DBMeiziViewController alloc] initWithTitle:@"有沟"  withCategory:cleavageCategory withRevealBlock:revealBlock]],
                                 [[UINavigationController alloc] initWithRootViewController:[[DBMeiziViewController alloc] initWithTitle:@"美腿"  withCategory:prettyLegsCategory withRevealBlock:revealBlock]],
                                 [[UINavigationController alloc] initWithRootViewController:[[DBMeiziViewController alloc] initWithTitle:@"小清新"  withCategory:cuteCategory withRevealBlock:revealBlock]],
                                 [[UINavigationController alloc] initWithRootViewController:[[DBMeiziViewController alloc] initWithTitle:@"文艺范"  withCategory:artisticCategory withRevealBlock:revealBlock]],
                                 [[UINavigationController alloc] initWithRootViewController:[[DBMeiziViewController alloc] initWithTitle:@"今日妹子"  withCategory:[self getNewCategory] withRevealBlock:revealBlock]],
                                 
                                 ]
                             ];
	NSArray *cellInfos = @[
                           @[
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"首页", @"")}
                               ],
                           @[
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"性感", @"")},
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"有沟", @"")},
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"美腿", @"")},
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"清新", @"")},
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"文艺范", @"")},
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"今日妹子", @"")}
                               ]
                           ];
	
	// Add drag feature to each root navigation controller
	[controllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
		[((NSArray *)obj) enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx2, BOOL *stop2){
			UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.revealController 
																						 action:@selector(dragContentView:)];
			panGesture.cancelsTouchesInView = YES;
			[((UINavigationController *)obj2).view addGestureRecognizer:panGesture];
		}];
	}];

    self.menuController = [[GHMenuViewController alloc] initWithSidebarViewController:self.revealController
																		withSearchBar:nil
																		  withHeaders:headers
																	  withControllers:controllers
																		withCellInfos:cellInfos];
	
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.revealController;
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Private Methods
- (NSUInteger)getNewCategory
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSInteger category = [dateString integerValue];
    return 20140209;
//    return category;
}

@end
