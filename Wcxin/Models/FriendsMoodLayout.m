//
//  FriendsMoodLayout.m
//  Wcxin
//
//  Created by chengzi on 15/12/3.
//  Copyright © 2015年 fosung. All rights reserved.
//

#import "FriendsMoodLayout.h"
#import "MessageBody.h"
#import "ReplyBody.h"
#import "MediaItemCCell.h"
#import "CommentCell.h"
#import "MLEmojiLabel.h"
#import "ControlsLayout.h"

#define kCommentBtnHeight 25

@implementation FriendsMoodLayout{
    MessageBody *messageBoby;
}

- (MessageBody *) getCellHeight:(MessageBody *)boby{
    messageBoby = boby;
    CGFloat cellHeight = [self cellHeightWithObj:boby];
    CGFloat contentHeight = [self getUserContentHeight:boby];
    CGFloat mediaHeight = [self contentMediaHeightWithTweet:boby];
    CGFloat likeHeight = [self likeUsersHeightWithTweet:boby];
    CGFloat commentHeight = [self commentListViewHeightWithTweet:boby];
    ControlsLayout *cotrolsLayout = [[ControlsLayout alloc] init];
    cotrolsLayout.textHeight = contentHeight;
    cotrolsLayout.picsHeight = mediaHeight;
    cotrolsLayout.likesHeight = likeHeight;
    cotrolsLayout.replyHeight = commentHeight;
    messageBoby.cotrolsLayout = cotrolsLayout;
    messageBoby.cellsHeight = cellHeight;
    
    return messageBoby;
}

//获取说说高度
- (CGFloat)getUserContentHeight:(MessageBody *)wfmessageBoby{
    static MLEmojiLabel *protypeLabel = nil;
    if (!protypeLabel) {
        protypeLabel = [MLEmojiLabel new];
        protypeLabel.numberOfLines = 0;
        protypeLabel.font = [UIFont systemFontOfSize:14.0f];
        protypeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        protypeLabel.textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        protypeLabel.isNeedAtAndPoundSign = YES;
        protypeLabel.disableEmoji = NO;
        protypeLabel.lineSpacing = 3.0f;
        
        protypeLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
    }
    
    [protypeLabel setText:wfmessageBoby.posterContent];
    
    return [protypeLabel preferredSizeWithMaxWidth:[UIScreen mainScreen].bounds.size.width - 28].height;
}

//获取说说内容图片高度
- (CGFloat)contentMediaHeightWithTweet:(MessageBody *)wfmessageBoby{
    CGFloat contentMediaHeight = 0;
    NSInteger mediaCount = wfmessageBoby.posterPostImage.count;
    if (mediaCount > 0) {
        NSString *imageName = wfmessageBoby.posterPostImage.firstObject;
        contentMediaHeight = ceilf((float)mediaCount/3)*([MediaItemCCell ccellSizeWithObj:imageName].height + 3.0);
    }
    
    return contentMediaHeight;
}


- (CGFloat)likeUsersHeightWithTweet:(MessageBody *)wfmessageBoby{
    CGFloat likeUsersHeight = 0;
    if (wfmessageBoby.posterFavour.count > 0) {
        likeUsersHeight = 45;
    }
    return likeUsersHeight;
}

- (CGFloat)commentListViewHeightWithTweet:(MessageBody *)wfmessageBoby{
    if (!wfmessageBoby) {
        return 0;
    }
    CGFloat commentListViewHeight = 0;
    
    NSInteger numOfComments = wfmessageBoby.posterReplies.count;
    //    BOOL hasMoreComments = tweet.hasMoreComments;
    
    for (int i = 0; i < numOfComments; i++) {
        
        ReplyBody *curComment = [wfmessageBoby.posterReplies objectAtIndex:i];
        commentListViewHeight += [CommentCell cellHeightWithObj:curComment];
    }
    
    return commentListViewHeight;
}


- (CGFloat)cellHeightWithObj:(MessageBody *)wfmessageBoby {
    CGFloat cellHeight = 0;
    cellHeight += 66;
    cellHeight += [self getUserContentHeight:wfmessageBoby];
    cellHeight += [self contentMediaHeightWithTweet:wfmessageBoby];
    cellHeight += [self likeUsersHeightWithTweet:wfmessageBoby];
    cellHeight += [self commentListViewHeightWithTweet:wfmessageBoby];
    cellHeight += kCommentBtnHeight;
    cellHeight += 8;
    return ceilf(cellHeight);
}

@end
