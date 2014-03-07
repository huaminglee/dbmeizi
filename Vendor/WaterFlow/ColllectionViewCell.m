//
//  ColllectionViewCell.m
//  WaterFlowDisplay
//
//  Created by B.H.Liu on 12-8-22.
//  Copyright (c) 2012年 Appublisher. All rights reserved.
//

#import "ColllectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ColllectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.contentView.layer.borderWidth = 1.f;
        AsyncImageView *asyncimageView = [[AsyncImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:asyncimageView];
        _imageView = asyncimageView;
        
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.imageView.backgroundColor = [UIColor grayColor];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 15, frame.size.width, 15)];
        _label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        _label.backgroundColor = [UIColor colorWithWhite:1 alpha:.5];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.label.text = text;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
