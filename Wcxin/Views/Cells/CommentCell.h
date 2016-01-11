//
//  CommentCell.h
//  Wcxin
//
//  Created by chengzi on 15/11/27.
//  Copyright © 2015年 fosung. All rights reserved.
//
#define kCellIdentifier_Comment @"CommentCell"

#import <UIKit/UIKit.h>
@class ReplyBody;
@class MLEmojiLabel;


@interface CommentCell : UITableViewCell

@property (strong, nonatomic) MLEmojiLabel *commentLabel;
- (void)configWithComment:(ReplyBody *)curComment;
+ (CGFloat)cellHeightWithObj:(ReplyBody *)curComment;

@end
