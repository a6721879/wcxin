//
//  FriendsListViewController.m
//  Wcxin
//
//  Created by chengzi on 15/10/28.
//  Copyright © 2015年 fosung. All rights reserved.
//

#import "FriendsListViewController.h"
#import "FriendsMoodCell.h"
#import "MessageBody.h"
#import "ReplyBody.h"
#import "ContantHead.h"
#import "FriendsMoodLayout.h"
#import "YYFPSLabel.h"

#define kAdmin @"小虎-tiger"

@interface FriendsListViewController (){
    NSArray *_contentDataSource;//模拟接口给的数据

}
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;
@property (assign, nonatomic) CGFloat lastScrollOffset;
@property (strong, nonatomic) NSMutableArray *contentDataArray;
@end

@implementation FriendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[FriendsMoodCell class] forCellReuseIdentifier:@"FriendsMoodCell"];
    [self configData];
    
    YYFPSLabel *fps = [YYFPSLabel new];
    [fps setFrame:CGRectMake(10, 20, 100, 30)];
    [[UIApplication sharedApplication].keyWindow addSubview:fps];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源
- (void)configData{
    self.offscreenCells = [NSMutableDictionary dictionary];
    self.contentDataArray = @[].mutableCopy;

    ReplyBody *body1 = [[ReplyBody alloc] init];
    body1.replyUser = kAdmin;
    body1.repliedUser = @"红领巾";
    body1.replyInfo = kContentText1;
    
    
    ReplyBody *body2 = [[ReplyBody alloc] init];
    body2.replyUser = @"迪恩";
    body2.repliedUser = @"";
    body2.replyInfo = kContentText2;
    
    
    ReplyBody *body3 = [[ReplyBody alloc] init];
    body3.replyUser = @"山姆";
    body3.repliedUser = @"";
    body3.replyInfo = kContentText3;
    
    
    ReplyBody *body4 = [[ReplyBody alloc] init];
    body4.replyUser = @"雷锋";
    body4.repliedUser = @"简森·阿克斯";
    body4.replyInfo = kContentText4;
    
    
    ReplyBody *body5 = [[ReplyBody alloc] init];
    body5.replyUser = kAdmin;
    body5.repliedUser = @"";
    body5.replyInfo = kContentText5;
    
    
    ReplyBody *body6 = [[ReplyBody alloc] init];
    body6.replyUser = @"红领巾";
    body6.repliedUser = @"";
    body6.replyInfo = kContentText6;
    
    
    MessageBody *messBody1 = [[MessageBody alloc] init];
    messBody1.posterContent = kShuoshuoText1;
    messBody1.posterPostImage = @[@"image_1.png",@"image_1.png",@"image_1.png"];
    messBody1.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4, nil];
    messBody1.posterImgstr = @"mao.jpg";
    messBody1.posterName = @"大猫大猫";
    messBody1.posterIntro = @"这个人很懒，什么都没有留下";
    messBody1.posterFavour = [NSMutableArray arrayWithObjects:@"路人甲",@"希尔瓦娜斯",kAdmin,@"鹿盔", nil];
    messBody1.isFavour = YES;
    
    MessageBody *messBody2 = [[MessageBody alloc] init];
    messBody2.posterContent = kShuoshuoText1;
    messBody2.posterPostImage = @[@"image_1.png",@"image_1.png",@"image_1.png"];
    messBody2.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4, nil];
    messBody2.posterImgstr = @"mao.jpg";
    messBody2.posterName = @"山姆·温彻斯特";
    messBody2.posterIntro = @"这个人很懒，什么都没有留下";
    messBody2.posterFavour = [NSMutableArray arrayWithObjects:@"塞纳留斯",@"希尔瓦娜斯",@"鹿盔", nil];
    messBody2.isFavour = NO;
    
    
    MessageBody *messBody3 = [[MessageBody alloc] init];
    messBody3.posterContent = kShuoshuoText3;
    messBody3.posterPostImage = @[@"image_1.png",@"image_1.png",@"image_1.png",@"image_1.png",@"image_1.png",@"image_1.png"];
    messBody3.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4,body6,body5,body4, nil];
    messBody3.posterImgstr = @"mao.jpg";
    messBody3.posterName = @"伊利丹怒风";
    messBody3.posterIntro = @"这个人很懒，什么都没有留下";
    messBody3.posterFavour = [NSMutableArray arrayWithObjects:@"路人甲",kAdmin,@"希尔瓦娜斯",@"鹿盔",@"黑手", nil];
    messBody3.isFavour = YES;
    
    MessageBody *messBody4 = [[MessageBody alloc] init];
    messBody4.posterContent = kShuoshuoText4;
    messBody4.posterPostImage = @[@"image_1.png",@"image_1.png",@"image_1.png",@"image_1.png",@"image_1.png"];
    messBody4.posterReplies = [NSMutableArray arrayWithObjects:body1, nil];
    messBody4.posterImgstr = @"mao.jpg";
    messBody4.posterName = @"基尔加丹";
    messBody4.posterIntro = @"这个人很懒，什么都没有留下";
    messBody4.posterFavour = [NSMutableArray arrayWithObjects:@"打哇",nil];
    messBody4.isFavour = NO;
    
    MessageBody *messBody5 = [[MessageBody alloc] init];
    messBody5.posterContent = kShuoshuoText5;
    messBody5.posterPostImage = @[@"image_1.png",@"image_1.png",@"image_1.png",@"image_1.png"];
    messBody5.posterReplies = [NSMutableArray arrayWithObjects:body2,body4,body5, nil];
    messBody5.posterImgstr = @"mao.jpg";
    messBody5.posterName = @"阿克蒙德";
    messBody5.posterIntro = @"这个人很懒，什么都没有留下";
    messBody5.posterFavour = [NSMutableArray arrayWithObjects:@"希尔瓦娜斯",@"格鲁尔",@"魔兽世界5区石锤人类联盟女圣骑丨阿诺丨",@"钢铁女武神",@"魔兽世界5区石锤人类联盟女盗贼chaotics",@"克苏恩",@"克尔苏加德",@"钢铁议会", nil];
    messBody5.isFavour = NO;
    
    MessageBody *messBody6 = [[MessageBody alloc] init];
    messBody6.posterContent = kShuoshuoText5;
    messBody6.posterPostImage = @[@"image_1.png",@"image_1.png",@"image_1.png",@"image_1.png",@"image_1.png"];
    messBody6.posterReplies = [NSMutableArray arrayWithObjects:body2,body4,body5,body4,body6, nil];
    messBody6.posterImgstr = @"mao.jpg";
    messBody6.posterName = @"红领巾";
    messBody6.posterIntro = @"这个人很懒，什么都没有留下";
    messBody6.posterFavour = [NSMutableArray arrayWithObjects:@"爆裂熔炉",@"希尔瓦娜斯",@"阿尔萨斯",@"死亡之翼",@"玛里苟斯", nil];
    messBody6.isFavour = NO;
    
    _contentDataSource = @[messBody1,messBody2,messBody3,messBody4,messBody5,messBody6];
    for (MessageBody *boby in _contentDataSource) {
        FriendsMoodLayout *friendLayout = [[FriendsMoodLayout alloc] init];
        MessageBody *kboby = [friendLayout getCellHeight:boby];
        [self.contentDataArray addObject:kboby];
    }
    [self.tableView reloadData];
}


#pragma mark - Table view data sources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.contentDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"FriendsMoodCell";
    FriendsMoodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    MessageBody *wfMessageBoby = [self.contentDataArray objectAtIndex:indexPath.row];
    [cell setModel:wfMessageBoby];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageBody *wfMessageBoby = [self.contentDataArray objectAtIndex:indexPath.row];

    return wfMessageBoby.cellsHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastScrollOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if( scrollView.contentOffset.y > self.lastScrollOffset) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.tabBarController.tabBar setAlpha:0.0f];
        }];

    }else{
        [UIView animateWithDuration:0.2 animations:^{
            [self.tabBarController.tabBar setAlpha:1.0f];
        }];

    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
