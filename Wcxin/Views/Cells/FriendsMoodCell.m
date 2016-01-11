//
//  FriendsMoodCell.m
//  Wcxin
//
//  Created by chengzi on 15/10/28.
//  Copyright © 2015年 fosung. All rights reserved.
//

#import "FriendsMoodCell.h"
#import "MessageBody.h"
#import "MLEmojiLabel.h"
#import "DWTagList.h"
#import "LikeUserCCell.h"
#import "CommentCell.h"
#import "ReplyBody.h"
#import "MediaItemCCell.h"

#define kCommentBtnHeight 25

@interface FriendsMoodCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,MLEmojiLabelDelegate>

@property (strong, nonatomic) UIImageView *userHeadImage;
@property (strong, nonatomic) UIButton *userName;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) MLEmojiLabel *userContent;
@property (strong, nonatomic) UICollectionView *mediaView;
@property (strong, nonatomic) UICollectionView *likeUsersView;
@property (strong, nonatomic) UITableView *commentListView;
@property (strong, nonatomic) UIButton *likeBtn, *commentBtn, *deleteBtn;
@property (strong, nonatomic) MessageBody *wfMessageBody;

@end

@implementation FriendsMoodCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    
        if (!self.userHeadImage) {
            self.userHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 40, 40)];
            [self.contentView addSubview:self.userHeadImage];
        }
            
        if (!self.userName) {
            self.userName = [UIButton buttonWithType:UIButtonTypeCustom];
            self.userName.frame = CGRectMake(CGRectGetMaxX(self.userHeadImage.frame) + 10, 23, 172, 20);
            [self.userName setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //        [self.userName addTarget:self action:@selector(userBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:self.userName];
        }
        
        if (!self.timeLabel) {
            self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 85, 26, 70, 12)];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textAlignment = NSTextAlignmentRight;
            self.timeLabel.textColor = [UIColor darkGrayColor];
            [self.contentView addSubview:self.timeLabel];
        }
        
        if (!self.userContent) {
            self.userContent = [MLEmojiLabel new];
            self.userContent.numberOfLines = 0;
            self.userContent.font = [UIFont systemFontOfSize:14.0f];
            self.userContent.delegate = self;
            self.userContent.backgroundColor = [UIColor clearColor];
            self.userContent.lineBreakMode = NSLineBreakByTruncatingTail;
            self.userContent.textColor = [UIColor blackColor];
//            self.userContent.backgroundColor = [UIColor lightGrayColor];
            self.userContent.textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            self.userContent.isNeedAtAndPoundSign = YES;
            self.userContent.disableEmoji = NO;
            self.userContent.lineSpacing = 3.0f;
            self.userContent.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
            [self.contentView addSubview:self.userContent];
        }
        
        if (!self.mediaView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            self.mediaView = [[UICollectionView alloc] initWithFrame:CGRectMake(14, 0, [UIScreen mainScreen].bounds.size.width - 28, 80) collectionViewLayout:layout];
            self.mediaView.scrollEnabled = NO;
            [self.mediaView setBackgroundView:nil];
            [self.mediaView setBackgroundColor:[UIColor clearColor]];
            [self.mediaView registerClass:[MediaItemCCell class] forCellWithReuseIdentifier:kCCellIdentifier_MediaItem];
    //        [self.mediaView registerClass:[TweetMediaItemSingleCCell class] forCellWithReuseIdentifier:kCCellIdentifier_TweetMediaItemSingle];
            self.mediaView.dataSource = self;
            self.mediaView.delegate = self;
            [self.contentView addSubview:self.mediaView];
        }

        
        if (!self.likeBtn) {
            self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        self.likeBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 0, 50, 25);
            [self.likeBtn setImage:[UIImage imageNamed:@"tweet_like_btn"] forState:UIControlStateNormal];
    //        [self.likeBtn addTarget:self action:@selector(likeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:self.likeBtn];
        }
        
        if (!self.commentBtn) {
            self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        self.commentBtn.frame = CGRectMake(self.likeBtn.frame.origin.x + 50, 0, 50, 25);
            [self.commentBtn setImage:[UIImage imageNamed:@"tweet_comment_btn"] forState:UIControlStateNormal];
    //        [self.commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:self.commentBtn];
        }

        

        if (!self.likeUsersView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            self.likeUsersView = [[UICollectionView alloc] initWithFrame:CGRectMake(14, 0, [UIScreen mainScreen].bounds.size.width - 28, 35) collectionViewLayout:layout];
            self.likeUsersView.scrollEnabled = NO;
            [self.likeUsersView setBackgroundView:nil];
            [self.likeUsersView setBackgroundColor:[UIColor whiteColor]];
            [self.likeUsersView registerClass:[LikeUserCCell class] forCellWithReuseIdentifier:@"LikeUserCell"];
            self.likeUsersView.dataSource = self;
            self.likeUsersView.delegate = self;
            [self.contentView addSubview:self.likeUsersView];
        }
        if (!self.commentListView) {
            self.commentListView = [[UITableView alloc] initWithFrame:CGRectMake(14, 0, [UIScreen mainScreen].bounds.size.width - 28, 20) style:UITableViewStylePlain];
            self.commentListView.separatorStyle = UITableViewCellSeparatorStyleNone;
            self.commentListView.scrollEnabled = NO;
            [self.commentListView setBackgroundView:nil];
            [self.commentListView setBackgroundColor:[UIColor lightGrayColor]];
            [self.commentListView registerClass:[CommentCell class] forCellReuseIdentifier:kCellIdentifier_Comment];
    //        [self.commentListView registerClass:[CommentMoreCell class] forCellReuseIdentifier:kCellIdentifier_TweetCommentMore];
            self.commentListView.dataSource = self;
            self.commentListView.delegate = self;
            [self.contentView addSubview:self.commentListView];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MessageBody *)wfMessageBody{
    self.wfMessageBody = wfMessageBody;
    
    [self.userHeadImage setImage:[UIImage imageNamed:wfMessageBody.posterImgstr]];
    
    [self.userName setTitle:wfMessageBody.posterName forState:UIControlStateNormal];
    [self.timeLabel setText:@"2015-02-10"];
    self.userContent.isNeedAtAndPoundSign = YES;
    self.userContent.text = wfMessageBody.posterContent;
    
    
    CGFloat curBottomY = 0;
    curBottomY += self.userHeadImage.frame.origin.y + self.userHeadImage.frame.size.
    height + 8;
    [self.userContent setFrame:CGRectMake(self.userHeadImage.frame.origin.x, curBottomY, self.frame.size.width - 28, wfMessageBody.cotrolsLayout.textHeight)];
    
    curBottomY += wfMessageBody.cotrolsLayout.textHeight;

    //图片缩略图展示
    if (self.wfMessageBody.posterPostImage.count > 0) {
        
        [self.mediaView setFrame:CGRectMake(14, curBottomY + 3.0, [UIScreen mainScreen].bounds.size.width - 28, wfMessageBody.cotrolsLayout.picsHeight)];
        curBottomY += wfMessageBody.cotrolsLayout.picsHeight;
        [self.mediaView reloadData];
        self.mediaView.hidden = NO;
        
    }else{
        if (self.mediaView) {
            self.mediaView.hidden = YES;
        }
    }
    self.likeBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 120, curBottomY, 50, kCommentBtnHeight);
    self.commentBtn.frame = CGRectMake(self.likeBtn.frame.origin.x + 50, curBottomY, 50, kCommentBtnHeight);
    
    curBottomY += kCommentBtnHeight;
    
    //赞的列表
    if (self.wfMessageBody.posterFavour.count > 0) {
        [self.likeUsersView setFrame:CGRectMake(14, curBottomY, [UIScreen mainScreen].bounds.size.width - 28, wfMessageBody.cotrolsLayout.likesHeight)];
        curBottomY += wfMessageBody.cotrolsLayout.likesHeight;
        [self.likeUsersView reloadData];
        self.likeUsersView.hidden = NO;
        
    }else{
        if (self.likeUsersView) {
            self.likeUsersView.hidden = YES;
        }
    }
    
    //评论的人_列表
    //    可有可无
    if (self.wfMessageBody.posterReplies.count > 0) {
        [self.commentListView setFrame:CGRectMake(14, curBottomY, [UIScreen mainScreen].bounds.size.width - 28, wfMessageBody.cotrolsLayout.replyHeight)];
        [self.commentListView reloadData];
        self.commentListView.hidden = NO;
    }else{
        if (self.commentListView) {
            self.commentListView.hidden = YES;
        }
    }

}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];

}


//  增加手势
- (void)addtapGes:(UIView *)view withAction:(SEL)selector{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [view addGestureRecognizer:tapGes];
}

- (void)selectUserContent{
    NSLog(@"点击了说说内容");
    [self.userContent setBackgroundColor:[UIColor lightGrayColor]];

}

#pragma mark - delegate
- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL:
            NSLog(@"点击了链接%@",link);
            break;
        case MLEmojiLabelLinkTypePhoneNumber:
            NSLog(@"点击了电话%@",link);
            break;
        case MLEmojiLabelLinkTypeEmail:
            NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt:
            NSLog(@"点击了用户%@",link);
            break;
        case MLEmojiLabelLinkTypePoundSign:
            NSLog(@"点击了话题%@",link);
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
    
}


#pragma mark Collection M
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSInteger row = 0;
    if (collectionView == _mediaView) {
        row = self.wfMessageBody.posterPostImage.count;
    }else{
        row = self.wfMessageBody.posterFavour.count;
    }
    return row;

}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _mediaView) {
        NSString *imageName = [self.wfMessageBody.posterPostImage objectAtIndex:indexPath.row];
        MediaItemCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCCellIdentifier_MediaItem forIndexPath:indexPath];
        [cell setModel:imageName];
        
        return cell;
        
    }else{
        LikeUserCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LikeUserCell" forIndexPath:indexPath];
        [cell configWithUser:@"mao" likesNum:nil];
        
        return cell;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize;
    if (collectionView == _mediaView) {
        itemSize = [MediaItemCCell ccellSizeWithObj:self.wfMessageBody.posterPostImage.firstObject];
        
    }else{
        itemSize = CGSizeMake(25.0, 25.0);

    }
    return itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    UIEdgeInsets insetForSection;
    if (collectionView == _mediaView) {
        
        insetForSection = UIEdgeInsetsMake(0, 0, 0, 0);

    }else{
        insetForSection = UIEdgeInsetsMake(14, 5, 14, 5);

    }
    
    return insetForSection;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (collectionView == _mediaView) {
        return 3.0;
    }else{
        return 10.0;
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    if (collectionView == _mediaView) {
        return 3.0;
    }else{
        return 5.0;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark Table M comments
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wfMessageBody.posterReplies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Comment forIndexPath:indexPath];
    ReplyBody *curComment = [self.wfMessageBody.posterReplies objectAtIndex:indexPath.row];
    [cell configWithComment:curComment];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0;
    ReplyBody *curComment = [self.wfMessageBody.posterReplies objectAtIndex:indexPath.row];
    cellHeight = [CommentCell cellHeightWithObj:curComment];
    return cellHeight;
}

@end
