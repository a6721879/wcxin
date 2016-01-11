//
//  FriendsMoodCell.h
//  Wcxin
//
//  Created by chengzi on 15/10/28.
//  Copyright © 2015年 fosung. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageBody;
@class MLEmojiLabel;
@class DWTagList;

@interface FriendsMoodCell : UITableViewCell

- (void)setModel:(MessageBody *)wfMessageBody;

//获取cell高度
//+ (CGFloat)cellHeightWithObj:(WFMessageBody *)wfmessageBoby;

@end
