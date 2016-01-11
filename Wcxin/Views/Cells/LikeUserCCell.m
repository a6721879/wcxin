//
//  LikeUserCCell.m
//  Wcxin
//
//  Created by chengzi on 15/11/26.
//  Copyright © 2015年 fosung. All rights reserved.
//

#import "LikeUserCCell.h"

#define kCell_LikeUserCCell_Height 25.0


@interface LikeUserCCell ()
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSNumber *likes;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *likesLabel;

@end


@implementation LikeUserCCell
- (void)configWithUser:(NSString *)image likesNum:(NSNumber *)likes{
    self.image = image;
    self.likes = likes;
    
    if (!self.imgView) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kCell_LikeUserCCell_Height, kCell_LikeUserCCell_Height)];
//        [self.imgView doCircleFrame];
        [self.contentView addSubview:self.imgView];
    }
    if (image) {
        [self.imgView setImage:[UIImage imageNamed:self.image]];
        if (_likesLabel) {
            _likesLabel.hidden = YES;
        }
    }else{
//        [self.imgView sd_setImageWithURL:nil];
//        [self.imgView setImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xdadada"]]];
        if (!_likesLabel) {
            _likesLabel = [[UILabel alloc] initWithFrame:_imgView.frame];
            _likesLabel.backgroundColor = [UIColor blueColor];
            _likesLabel.textColor = [UIColor redColor];
            _likesLabel.font = [UIFont systemFontOfSize:15];
            _likesLabel.minimumScaleFactor = 0.5;
            _likesLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:_likesLabel];
        }
        _likesLabel.text = [NSString stringWithFormat:@"%d", _likes.intValue];
        _likesLabel.hidden = NO;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
