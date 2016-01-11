//
//  MediaItemCCell.h
//  Wcxin
//
//  Created by chengzi on 15/12/1.
//  Copyright © 2015年 fosung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLImageView.h"
#define kCCellIdentifier_MediaItem @"MediaItemCCell"

@interface MediaItemCCell : UICollectionViewCell
@property (strong, nonatomic) YLImageView *imgView;

- (void)setModel:(NSString *)imageName;
+ (CGSize)ccellSizeWithObj:(id)obj;

@end
