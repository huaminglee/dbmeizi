//
//  DBMeiziViewController.m
//  dbmeizi
//
//  Created by kaibin on 14-2-8.
//  Copyright (c) 2014年 kaibin. All rights reserved.
//

#import "DBMeiziViewController.h"
#import "GHPushedViewController.h"
#import "CollectionViewController.h"
#import "DBMeiziService.h"
#import "LogUtil.h"
#import "DBMeizi.h"
#import "SVWebViewController.h"
#import "ColllectionViewCell.h"

static int fetchSize = 20;

#pragma mark Private Interface
@interface DBMeiziViewController ()
@property (nonatomic,strong) LoadingMoreFooterView *loadFooterView;
@property (nonatomic,readwrite) BOOL loadingmore;
- (void)revealSidebar;
@end

#pragma mark Implementation
@implementation DBMeiziViewController{
@private
	RevealBlock _revealBlock;
}

#pragma mark Memory Management
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    WaterFlowLayout *layout = [[WaterFlowLayout alloc] init];
    if (self = [super initWithCollectionViewLayout:layout]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
		self.navigationItem.leftBarButtonItem =
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
														  target:self
														  action:@selector(revealSidebar)];
        self.collectionView.backgroundColor = [UIColor colorWithRed:(237.0f/255.0f) green:(244.0f/255.0f) blue:(237.0f/255.0f) alpha:1.0f];
        self.loadFooterView = [[LoadingMoreFooterView alloc]initWithFrame:CGRectMake(0, self.collectionView.frame.size.height, self.view.frame.size.width, 44.f)];
        self.loadingmore = NO;
        [self.collectionView addSubview:self.loadFooterView];
	}
	return self;
}

- (id)initWithTitle:(NSString *)title withCategory:(NSUInteger)category withRevealBlock:(RevealBlock)revealBlock {
    self = [self initWithTitle:title withRevealBlock:revealBlock];
    self.category = category;
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view.backgroundColor = [UIColor lightGrayColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [[DBMeiziService sharedService] dbMeiziWithCategory:self.category start:0 count:fetchSize handler:^(NSArray *dataList){
        self.dataList = [NSMutableArray arrayWithArray:dataList];
        PPDebug(@"dataList count %d", [self.dataList count]);

        NSMutableArray *imageList = [[NSMutableArray alloc] init];
        NSMutableArray *nameList = [[NSMutableArray alloc] init];
        for (DBMeizi *meizi in dataList) {
            [imageList addObject:meizi.img];
            [nameList addObject:meizi.name];
        }
        self.imageUrls = [NSMutableArray arrayWithArray:imageList];
        self.names = [NSMutableArray arrayWithArray:nameList];
        [self refresh:nil];
    }];
}

#pragma mark - UICollectionViewDelegate methods
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DBMeizi *meizi = [self.dataList objectAtIndex:indexPath.row];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithAddress: meizi.topic];
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark Private Methods
- (void)revealSidebar {
	_revealBlock();
}

- (void)loadMoreImages
{
    if (self.loadingmore) return;
    
    PPDebug(@"Loading more...");
    self.loadingmore = YES;
    self.loadFooterView.showActivityIndicator = YES;
    self.currentPage ++;
    
    [[DBMeiziService sharedService] dbMeiziWithCategory:0 start:fetchSize*(self.currentPage-1) count:fetchSize handler:^(NSArray *dataList){
        [self.dataList addObjectsFromArray:dataList];
        NSMutableArray *imageList = [[NSMutableArray alloc] init];
        NSMutableArray *nameList = [[NSMutableArray alloc] init];
        for (DBMeizi *meizi in dataList) {
            [imageList addObject:meizi.img];
            [nameList addObject:meizi.name];
        }
        [self.imageUrls addObjectsFromArray:imageList];
        [self.names addObjectsFromArray:nameList];
        PPDebug(@"dataList count %d", [self.dataList count]);
        
        if(self.loadingmore)
        {
            self.loadingmore = NO;
            self.loadFooterView.showActivityIndicator = NO;
        }
        
        [self.collectionView reloadData];

    }];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    self.loadFooterView.frame = CGRectMake(0, scrollView.contentSize.height, scrollView.frame.size.width, 44.0);
    
    if (bottomEdge >=  floor(scrollView.contentSize.height) )
    {
        [self loadMoreImages];
    }
}

@end
