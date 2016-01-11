//
//  CommentCell.m
//  Wcxin
//
//  Created by chengzi on 15/11/27.
//  Copyright © 2015年 fosung. All rights reserved.
//

#import "CommentCell.h"
#import "ReplyBody.h"
#import "MLEmojiLabel.h"

@interface CommentCell ()<MLEmojiLabelDelegate>
@property (strong, nonatomic) UILabel *userNameLabel, *timeLabel;
@property (strong, nonatomic) ReplyBody *curComment;

@end

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        if (!self.commentLabel) {
            self.commentLabel = [[MLEmojiLabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 28, 20) ];
            self.commentLabel.numberOfLines = 0;
            self.commentLabel.font = [UIFont systemFontOfSize:13.0f];
            self.commentLabel.delegate = self;
            self.commentLabel.backgroundColor = [UIColor clearColor];
            self.commentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.commentLabel.textColor = [UIColor darkGrayColor];
            self.commentLabel.backgroundColor = [UIColor whiteColor];
            self.commentLabel.textInsets = UIEdgeInsetsMake(5, 5, 5, 5);
            self.commentLabel.isNeedAtAndPoundSign = YES;
            self.commentLabel.disableEmoji = NO;
            self.commentLabel.lineSpacing = 3.0f;
            self.commentLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
            [self.contentView addSubview:self.commentLabel];
            
        }
        
        if (!_userNameLabel) {
            _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 150, 15)];
            _userNameLabel.backgroundColor = [UIColor clearColor];
            _userNameLabel.font = [UIFont boldSystemFontOfSize:12];
            [self.contentView addSubview:_userNameLabel];
        }
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 80, 15)];
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.font = [UIFont systemFontOfSize:12];
            [self.contentView addSubview:_timeLabel];
        }

    }
    return self;
}


- (void)configWithComment:(ReplyBody *)curComment{
    _curComment = curComment;
    //    [_commentLabel setWidth:kTweetCommentCell_ContentWidth];
    //    _commentLabel.text = _curComment.content;
    //    [_commentLabel sizeToFit];
    [_commentLabel setText:curComment.replyInfo];
    CGFloat commentHeight = [_commentLabel preferredSizeWithMaxWidth:[UIScreen mainScreen].bounds.size.width - 28].height;
    CGRect commentRect = _commentLabel.frame;
    commentRect.size.height = commentHeight;
    [_commentLabel setFrame:commentRect];
    
    if (curComment.repliedUser.length > 0) {
        _userNameLabel.text = [NSString stringWithFormat:@"%@ 回复 %@",curComment.replyUser,curComment.repliedUser];
    }else{
        _userNameLabel.text = curComment.replyUser;
    }
    
    _timeLabel.text = @"2015-11-28";
    CGRect rect = _userNameLabel.frame;
    rect.origin.y = commentHeight + 8;
    [_userNameLabel setFrame:rect];
    [_userNameLabel sizeToFit];
    
    [_timeLabel setFrame:CGRectMake(_userNameLabel.frame.origin.x + _userNameLabel.frame.size.width + 8, _userNameLabel.frame.origin.y, 80, 15)];
    [_timeLabel sizeToFit];
}

+ (CGFloat)cellHeightWithObj:(ReplyBody *)curComment{
    CGFloat cellHeight = 0;
    if ([curComment isKindOfClass:[ReplyBody class]]) {
        cellHeight = [self getUserContentHeight:curComment] + 10 + 20;
    }
    return ceilf(cellHeight);
}

+ (CGFloat)getUserContentHeight :(ReplyBody *)curComment{
    static MLEmojiLabel *protypeLabel = nil;
    if (!protypeLabel) {
        protypeLabel = [MLEmojiLabel new];
        protypeLabel.numberOfLines = 0;
        protypeLabel.font = [UIFont systemFontOfSize:13.0f];
        protypeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        protypeLabel.textInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        protypeLabel.isNeedAtAndPoundSign = YES;
        protypeLabel.disableEmoji = NO;
        protypeLabel.lineSpacing = 3.0f;
        
        protypeLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
    }
    
    [protypeLabel setText:curComment.replyInfo];
    
    return [protypeLabel preferredSizeWithMaxWidth:[UIScreen mainScreen].bounds.size.width - 28].height;
}

@end
