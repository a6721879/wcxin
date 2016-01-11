//
//  MediaItemCCell.m
//  Wcxin
//
//  Created by chengzi on 15/12/1.
//  Copyright © 2015年 fosung. All rights reserved.
//
#define kMediaItemCCell_Width (([UIScreen mainScreen].bounds.size.width - 36.0)/3.0)

#import "MediaItemCCell.h"

@implementation MediaItemCCell

- (void)setModel:(NSString *)imageName{
    if (!_imgView) {
        _imgView = [[YLImageView alloc] initWithFrame:CGRectMake(0, 0, kMediaItemCCell_Width, kMediaItemCCell_Width)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        [_imgView setImage:[UIImage imageNamed:imageName]];
        [self.contentView addSubview:_imgView];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

+ (CGSize)ccellSizeWithObj:(id)obj{
    CGSize itemSize = CGSizeMake(kMediaItemCCell_Width, kMediaItemCCell_Width);
    return itemSize;
}

@end
