//
//  LQSBBSDetailViewController.m
//  myOrgForum
//  功能 ： 论坛详情页
//  Created by 徐经纬 on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBBSDetailViewController.h"
#import "LQSHttpsRequest.h"
#import "LQSBBSDetailModel.h"


@interface LQSBBSDetailViewController ()

@property (nonatomic,strong) LQSBBSDetailModel *bbsDetailModel;

@end

@implementation LQSBBSDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *loginUrlStr = @"http://forum.longquanzs.org/mobcent/app/web/index.php?";
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    //    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"forum/postlist" forKey:@"r"];
    [dict setObject:@"10" forKey:@"pageSize"];
    [dict setObject:@"v2035.2" forKey:@"egnVersion"];
    [dict setObject:@"0" forKey:@"order"];
    [dict setObject:@"2.4.3.0" forKey:@"sdkVersion"];//待变
    [dict setObject:@"a15172f4" forKey:@"apphash"];//待变
    [dict setObject:LQSTR(self.selectModel.board_id) forKey:@"boardId"];//待变
    [dict setObject:LQSTR(self.selectModel.topicId) forKey:@"topicId"];//待变
    [dict setObject:@"7e3972a7a729e541ee373e7da3d06" forKey:@"accessToken"];
    [dict setObject:@"1" forKey:@"page"];//待变
    [dict setObject:@"39a68e4d5473e75669bce2d70c4b9" forKey:@"accessSecret"];
    [dict setObject:@"BW0L5ISVRsOTVLCTJx" forKey:@"forumKey"];
    
    [session POST:loginUrlStr parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
//        [self cleanData];
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];//[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"返回数据：%@",dict);
        [self getBBSDetailModelFrom:dict];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
/*
//    LQSHttpsRequest *request = [[LQSHttpsRequest alloc] init];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:@"forum/postlist" forKey:@"r"];
//    [dict setObject:@"10" forKey:@"pageSize"];
//    [dict setObject:@"v2035.2" forKey:@"egnVersion"];
//    [dict setObject:@"0" forKey:@"order"];
//    [dict setObject:@"2.4.3.0" forKey:@"sdkVersion"];//待变
//    [dict setObject:@"a15172f4" forKey:@"apphash"];//待变
//    [dict setObject:LQSTR(self.selectModel.board_id) forKey:@"boardId"];//待变
//    [dict setObject:LQSTR(self.selectModel.topicId) forKey:@"topicId"];//待变
//    [dict setObject:@"7e3972a7a729e541ee373e7da3d06" forKey:@"accessToken"];
//    [dict setObject:@"1" forKey:@"page"];//待变
//    [dict setObject:@"39a68e4d5473e75669bce2d70c4b9" forKey:@"accessSecret"];
//    [dict setObject:@"BW0L5ISVRsOTVLCTJx" forKey:@"forumKey"];
//    
//    [request POST:@"http://forum.longquanzs.org//mobcent/app/web/index.php?" parameters:dict success:^(id responseObject) {
//        LQSLog(@"请求成功");
//        
//        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
//        LQSBBSModel *model = [LQSBBSModel mj_objectWithKeyValues:dict];
//        
//        LQSLog(@"%@",dict);
//    } failure:^(NSError *error) {
//        LQSLog(@"请求失败");
//        
//        
//    }];
 */
    
    
}

- (void)getBBSDetailModelFrom:(NSDictionary *)dict
{
    if (nil != dict) {
        
    }
}
/*
{
    body = {
        externInfo = {
            padding = ;
        }
        ;
    }
    ;
    forumName = 聚焦龙泉;
    rs = 1;
    total_num = 15;
    head = {
        errInfo = 调用成功,没有任何错误;
        alert = 0;
        errCode = 00000000;
        version = 2.5.0.0;
    }
    ;
    has_next = 1;
    errcode = ;
    img_url = ;
    topic = {
        hits = 201;
        icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=216574&size=middle;
        poll_info = <null>;
        level = 2;
        replies = 15;
        isFollow = 0;
        managePanel = (
        );
        hot = 0;
        essence = 1;
        location = ;
        reward = {
            score = (
                     {
                         value = 10;
                         info = 微笑;
                     }
                     ,
                     );
            userList = (
                        {
                            uid = 212816;
                            userIcon = http://forum.longquanzs.org/uc_server/avatar.php?uid=212816&size=middle;
                            userName = 净琉璃;
                        }
                        ,
                        );
            showAllUrl = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/ratelistview&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=&pid=329531;
            userNumber = 1;
        }
        ;
        reply_status = 1;
        flag = 0;
        vote = 0;
        type = normal_complex;
        delThread = 0;
        create_date = 1471903513000;
        activityInfo = <null>;
        is_favor = 0;
        rateList = {
            body = (
                    {
                        field3 = ;
                        field2 = +10;
                        field1 = 净琉璃;
                    }
                    ,
                    );
            showAllUrl = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/ratelistview&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=&pid=329531;
            total = {
                field3 = ;
                field2 = 10;
                field1 = 1;
            }
            ;
            head = {
                field3 = ;
                field2 = 微笑;
                field1 = 参与人数;
            }
            ;
        }
        ;
        top = 0;
        status = 1;
        user_nick_name = 论坛报道;
        extraPanel = (
                      {
                          extParams = {
                              beforeAction = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/topicrate&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329531&type=check;
                          }
                          ;
                          title = 评分;
                          type = rate;
                          action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/topicrate&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329531&type=view;
                      }
                      ,
                      );
        content = (
                   {
                       infor = 部组档案
                       慈幼组：目前隶属于教化部项目处，日常主要在周六承担班长、讲师或其他骨干义工在寺学修期间，孩子的临时看护，使得师兄们可以不受孩子“打扰”，安心学修。
                       在重大节日或活动，慈幼组的老师们还带领孩子排演节目，为大家带来萌萌的欢乐。
                       我是一位孩子的妈妈，也是慈幼组的义工。
                       当提笔写这篇文章时，眼前浮现出齐师兄那一双笑起来眯成月牙状的眼睛，高师兄分享带动时平和谦卑的笑容，吴师兄的幽默与严谨，孙师兄抓拍镜头的认真，李师兄默默及时的补位，周师兄一讲故事就变身为表情帝的模样，马老师带领着小朋友翩翩起舞，小朋友身穿绿马甲在寺院穿梭、玩耍……;
                       type = 0;
                   }
                   ,
                   {
                       infor = http://forum.longquanzs.org/data/attachment/forum/201608/23/055521nno046oy1w4ipzmn.jpg.thumb.jpg;
                       type = 1;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/055521nno046oy1w4ipzmn.jpg;
                       aid = 137123;
                   }
                   ,
                   {
                       infor = （周老师讲故事）
                       
                       这一幅幅画面是如此温馨，让我一想起来就倍感温暖，躁动的心就会安静。
                       每次上山看到这些师兄们在，就像是有了依靠一样。虽然慈幼组很缺人，但当我一边做义工看其他师兄的孩子，自家孩子过来黏糊的时候，师兄们都接纳我及孩子当时的状态，等着我和孩子成长。
                       
                       初识齐师兄，是在九品莲花路的走廊下，她说动漫中心需要小朋友给贤二配音，问我家姑娘愿不愿意去？她总是能见缝插针的给大家寻找机会承担。
                       说起动漫，小朋友都喜欢，所以每当六一儿童节的时候，动漫中心都会和慈幼组一起联合举办亲子法会，捏个贤二、赵小翠，看看贤二系列电影，好运气的时候还会有法师慈悲的给小朋友在额头点个圆圆的朱砂。动漫中心也会把小朋友配音的动漫片拿到慈幼组，让小朋友在快乐中学习佛法。
                       
                       提起高师兄，我就想起宝宝稚嫩的声音：“妈妈，高兴阿姨为什么是快乐阿姨呢”？就忍不住扑哧一乐。是呀，高兴阿姨可不就是快乐阿姨嘛。
                       高师兄虽然年龄小，但她对佛法的行持让我深深的震撼。她最常说的一句话就是“我们要发和师长一样的心”。
                       高师兄的依师是“无我”的状态。这表现在她对上位及法师的安排从来都是不打折扣的执行，遇到困难就自己默默的在部组里带领大家努力的解决。用朝娜师兄的话来说，她不会想为我的部组争取什么利益，而是想师长需要这个部组怎么做、这个部组需要我怎么做。
                       
                       慈幼组大部分都是女众，当8、9岁的男孩儿们躁动起来打闹时，女众很难hold住场面，这时吴师兄就救星般的出现了，他淡定的对惊慌失措的女众师兄说：把他们几个交给我吧，用斋的时候给你带回来。很奇怪，吴师兄一声招呼，刚才还躁动的几个男孩像被施了魔法一样，兴奋的但规矩地跟着吴老师身后出去玩了，等玩一圈回来时，几个孩子开始安静的拼乐高了。
                       
                       马老师，是慈幼组的舞蹈专家啦。每次举行茶话会或者晚会，如果有小朋友演出的话，基本都是马老师带领小义工们加班排练出来的啦。
                       因为慈幼组周六需要看护孩子，无法参加班长班课。于是师兄们就善巧的排班，隔周承担：需要上讲师课的师兄在上班长班课时参加慈幼组看护活动，需要上班长班课的师兄就在上讲师班课时参加看护活动，大家互相帮助，成就各自闻法的因缘。
                       
                       此外，为了拉拔既不是讲师也无法听班长班课的师兄，慈幼组开设了自己的YY共修平台，每天都有不同的内容。谭姥姥每天坚持带动大家背诵楞严咒，牛师兄、展师兄每天中午12:20——13:20带动大家拜忏、学习师父开示，每周四为本周六的承担开会。在义工群里每天都会有师兄发整理好的、师父当天微博答疑，YY平台学修内容如百法，最新版贤二漫画，让大家在学修中进步。
                       
                       慈幼组无论什么时候都是一个整体，这是我在慈幼组最强烈的一个感受。不但是在看护活动中，即使是法会期间，慈幼组总是作为一个部组去共同承担其中的一部分工作，不论是上班长班课还是讲师班课，大家都尽量聚在一起或者出坡或者讨论活动方案，不但积累了丰厚的资粮，还切实的拉近了大家的业缘。
                       
                       近期，慈幼组教室腾给了其他部组，场地变不稳定且没有室内场地，即使这样，师兄们仍然满心欢喜的承担。从马老师7月17日雨中看护活动的分享中，我们就能体会到这份欢喜。
                       
                       周六，阴有雨。 上午，小树林中，孩子们闭眼静坐，静听古筝独奏，欣赏古诗‘与赵莒茶宴’，慢慢的饮茶，甜甜的吃着茶点。当老师询问小朋友听古筝时，脑海里，眼前呈现的是什么时，小朋友们的分享让我赞叹。
                       
                       “我听到了蝉鸣”、“我听到了鸟叫”、“我听到了脚步声”、“我闻到了茶的清香”、 “我来做首诗”……
                       我又一次感动，我对天气的担心，是多余的。
                       
                       下雨了，孩子们笑着，说着，在他们心中，那不是雨，那是甘露。在三宝地，树林中，蝉鸣，鸟叫，饮茶，赏诗，作诗，品尝甜品，享受着天降甘露……好美呀！感恩孩子们！让我感受到户外活动的快乐！下周六见！爱你们。;
                       type = 0;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/055521nno046oy1w4ipzmn.jpg;
                       aid = 137123;
                   }
                   ,
                   {
                       infor = http://forum.longquanzs.org/data/appbyme/thumb/0/27/0/xgsize_a42b0c0f2487aab3a4aa07b661e38a83.gif;
                       type = 1;
                       originalInfo = http://forum.longquanzs.org/static/image/hrline/2.gif;
                       aid = 0;
                   }
                   ,
                   {
                       infor =  你是不是看得心动了呢？也想把孩子送到慈幼组呢？
                       噢，那就发心承担吧，因为慈幼组看护范围是班长、副班长、讲师及骨干义工的孩子呢。赶快承担起来，让你的孩子有机会加入我们吧。 ;
                       type = 0;
                       originalInfo = http://forum.longquanzs.org/static/image/hrline/2.gif;
                       aid = 0;
                   }
                   ,
                   );
        user_id = 216574;
        userTitle = 初级会员;
        gender = 1;
        mobileSign = ;
        reply_posts_id = 329531;
        topic_id = 64054;
        title = [教化部]部组故事02 | 一想起来就倍感温暖：我眼中的慈幼组;
        zanList = (
        );
        sortId = 0;
    }
    ;
    boardId = 502;
    icon_url = ;
    list = (
            {
                reply_content = (
                                 {
                                     infor = 随喜赞叹师兄分享！[good][good][good];
                                     type = 0;
                                 }
                                 ,
                                 );
                location = ;
                mobileSign = 来自龙泉论坛手机客户端;
                position = 2;
                status = 1;
                title = ;
                managePanel = (
                );
                delThread = 0;
                icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=195349&size=middle;
                reply_status = 1;
                reply_type = normal;
                reply_name = 丁烨;
                reply_posts_id = 329696;
                role_num = 1;
                level = 6;
                reply_id = 195349;
                is_quote = 0;
                userTitle = 金牌会员;
                quote_pid = 0;
                posts_date = 1471929834000;
                quote_content = ;
                extraPanel = (
                              {
                                  extParams = {
                                      recommendAdd = 0;
                                      beforeAction = ;
                                      isHasRecommendAdd = 0;
                                  }
                                  ;
                                  title = 支持;
                                  recommendAdd = ;
                                  type = support;
                                  action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329696&type=post;
                              }
                              ,
                              );
                quote_user_name = ;
            }
            ,
            {
                reply_content = (
                                 {
                                     infor = 成就他人就是成就自己！随喜赞叹师兄们[good][good][good];
                                     type = 0;
                                 }
                                 ,
                                 );
                location = ;
                mobileSign = 来自龙泉论坛手机客户端;
                position = 3;
                status = 1;
                title = ;
                managePanel = (
                );
                delThread = 0;
                icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=207267&size=middle;
                reply_status = 1;
                reply_type = normal;
                reply_name = 贤英@;
                reply_posts_id = 329747;
                role_num = 1;
                level = 6;
                reply_id = 207267;
                is_quote = 0;
                userTitle = 金牌会员;
                quote_pid = 0;
                posts_date = 1471937721000;
                quote_content = ;
                extraPanel = (
                              {
                                  extParams = {
                                      recommendAdd = 0;
                                      beforeAction = ;
                                      isHasRecommendAdd = 0;
                                  }
                                  ;
                                  title = 支持;
                                  recommendAdd = ;
                                  type = support;
                                  action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329747&type=post;
                              }
                              ,
                              );
                quote_user_name = ;
            }
            ,
            {
                reply_content = (
                                 {
                                     infor = 对慈幼组的师兄们除了赞叹，还是赞叹。
                                     对高师兄的印象也是如此，平和谦卑，微笑淡然。
                                     
                                     阿弥陀佛！;
                                     type = 0;
                                 }
                                 ,
                                 );
                location = ;
                mobileSign = ;
                position = 4;
                status = 1;
                title = ;
                managePanel = (
                );
                delThread = 0;
                icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=165485&size=middle;
                reply_status = 1;
                reply_type = normal;
                reply_name = 人间的面;
                reply_posts_id = 329796;
                role_num = 1;
                level = 8;
                reply_id = 165485;
                is_quote = 0;
                userTitle = 超级版主;
                quote_pid = 0;
                posts_date = 1471942903000;
                quote_content = ;
                extraPanel = (
                              {
                                  extParams = {
                                      recommendAdd = 0;
                                      beforeAction = ;
                                      isHasRecommendAdd = 0;
                                  }
                                  ;
                                  title = 支持;
                                  recommendAdd = ;
                                  type = support;
                                  action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329796&type=post;
                              }
                              ,
                              );
                quote_user_name = ;
            }
            ,
            {
                reply_content = (
                                 {
                                     infor = 是的 感恩他们！;
                                     type = 0;
                                 }
                                 ,
                                 );
                location = ;
                mobileSign = ;
                position = 5;
                status = 1;
                title = ;
                managePanel = (
                );
                delThread = 0;
                icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=141111&size=middle;
                reply_status = 1;
                reply_type = normal;
                reply_name = 贤写;
                reply_posts_id = 329829;
                role_num = 1;
                level = 8;
                reply_id = 141111;
                is_quote = 1;
                userTitle = 超级版主;
                quote_pid = 0;
                posts_date = 1471945781000;
                quote_content = 人间的面 发表于 2016-8-23 17:01
                对慈幼组的师兄们除了赞叹，还是赞叹。
                对高师兄的印象也是如此，平和谦卑，微笑淡然。;
                extraPanel = (
                );
                quote_user_name = ;
            }
            ,
            {
                reply_content = (
                                 {
                                     infor = 慈幼组的师兄们都棒棒哒！[good][good][good];
                                     type = 0;
                                 }
                                 ,
                                 );
                location = ;
                mobileSign = 来自龙泉论坛手机客户端;
                position = 6;
                status = 1;
                title = ;
                managePanel = (
                );
                delThread = 0;
                icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=205804&size=middle;
                reply_status = 1;
                reply_type = normal;
                reply_name = 贤从;
                reply_posts_id = 329999;
                role_num = 1;
                level = 3;
                reply_id = 205804;
                is_quote = 0;
                userTitle = 中级会员;
                quote_pid = 0;
                posts_date = 1471960827000;
                quote_content = ;
                extraPanel = (
                              {
                                  extParams = {
                                      recommendAdd = 0;
                                      beforeAction = ;
                                      isHasRecommendAdd = 0;
                                  }
                                  ;
                                  title = 支持;
                                  recommendAdd = ;
                                  type = support;
                                  action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329999&type=post;
                              }
                              ,
                              );
                quote_user_name = ;
            }
            ,
            {
                reply_content = (
                {
                    infor = 感恩随喜[mobcent_phiz=http:/ /forum.longquanzs.org/static/image/smiley/QQ/080.gif];
                    type = 0;
                }
                ,
                              );
                  location = ;
                  mobileSign = ;
                  position = 7;
                  status = 1;
                  title = ;
                  managePanel = (
                  );
                  delThread = 0;
                  icon = http:/ /forum.longquanzs.org/uc_server/avatar.php?uid=141074&size=middle;
                  reply_status = 1;
                  reply_type = normal;
                  reply_name = bathar;
                  reply_posts_id = 330385;
                  role_num = 1;
                  level = 8;
                  reply_id = 141074;
                  is_quote = 0;
                  userTitle = 论坛元老;
                  quote_pid = 0;
                  posts_date = 1472017683000;
                  quote_content = ;
                  extraPanel = (
                        {
                            extParams = {
                                recommendAdd = 0;
                                beforeAction = ;
                                isHasRecommendAdd = 0;
                            }
                            ;
                            title = 支持;
                            recommendAdd = ;
                            type = support;
                            action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=330385&type=post;
                        }
                                    ,
                                    );
                      quote_user_name = ;
                      }
            ,
              {
                  reply_content = (
                                   {
                                       infor = 感恩师兄们;
                                       type = 0;
                                   }
                                   ,
                                   );
                  location = ;
                  mobileSign = 来自龙泉论坛手机客户端;
                  position = 8;
                  status = 1;
                  title = ;
                  managePanel = (
                  );
                  delThread = 0;
                  icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=214227&size=middle;
                  reply_status = 1;
                  reply_type = normal;
                  reply_name = 贤萌;
                  reply_posts_id = 331125;
                  role_num = 1;
                  level = 2;
                  reply_id = 214227;
                  is_quote = 0;
                  userTitle = 初级会员;
                  quote_pid = 0;
                  posts_date = 1472116100000;
                  quote_content = ;
                  extraPanel = (
                  );
                  quote_user_name = ;
              }
              ,
              {
                  reply_content = (
                                   {
                                       infor = 随喜赞叹，看的末学满心欢喜[呵呵];
                                       type = 0;
                                   }
                                   ,
                                   );
                  location = ;
                  mobileSign = 来自龙泉论坛手机客户端;
                  position = 9;
                  status = 1;
                  title = ;
                  managePanel = (
                  );
                  delThread = 0;
                  icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=215236&size=middle;
                  reply_status = 1;
                  reply_type = normal;
                  reply_name = xinnongyang;
                  reply_posts_id = 331133;
                  role_num = 1;
                  level = 2;
                  reply_id = 215236;
                  is_quote = 0;
                  userTitle = 初级会员;
                  quote_pid = 0;
                  posts_date = 1472117521000;
                  quote_content = ;
                  extraPanel = (
                                {
                                    extParams = {
                                        recommendAdd = 0;
                                        beforeAction = ;
                                        isHasRecommendAdd = 0;
                                    }
                                    ;
                                    title = 支持;
                                    recommendAdd = ;
                                    type = support;
                                    action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=331133&type=post;
                                }
                                ,
                                );
                  quote_user_name = ;
              }
              ,
              {
                  reply_content = (
                                   {
                                       infor = 随喜赞叹！;
                                       type = 0;
                                   }
                                   ,
                                   );
                  location = ;
                  mobileSign = 来自龙泉论坛手机客户端;
                  position = 10;
                  status = 1;
                  title = ;
                  managePanel = (
                  );
                  delThread = 0;
                  icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=210503&size=middle;
                  reply_status = 1;
                  reply_type = normal;
                  reply_name = 阿珍;
                  reply_posts_id = 331208;
                  role_num = 1;
                  level = 3;
                  reply_id = 210503;
                  is_quote = 0;
                  userTitle = 中级会员;
                  quote_pid = 0;
                  posts_date = 1472128079000;
                  quote_content = ;
                  extraPanel = (
                  );
                  quote_user_name = ;
              }
              ,
              {
                  reply_content = (
                                   {
                                       infor = 成就他人就是成就自己，师兄们真正实践了这句话，我要向师兄们学习无我利他，阿弥陀佛！;
                                       type = 0;
                                   }
                                   ,
                                   );
                  location = ;
                  mobileSign = 来自龙泉论坛手机客户端;
                  position = 11;
                  status = 1;
                  title = ;
                  managePanel = (
                  );
                  delThread = 0;
                  icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=167890&size=middle;
                  reply_status = 1;
                  reply_type = normal;
                  reply_name = dongchen;
                  reply_posts_id = 331319;
                  role_num = 1;
                  level = 3;
                  reply_id = 167890;
                  is_quote = 0;
                  userTitle = 中级会员;
                  quote_pid = 0;
                  posts_date = 1472135435000;
                  quote_content = ;
                  extraPanel = (
                                {
                                    extParams = {
                                        recommendAdd = 0;
                                        beforeAction = ;
                                        isHasRecommendAdd = 0;
                                    }
                                    ;
                                    title = 支持;
                                    recommendAdd = ;
                                    type = support;
                                    action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=331319&type=post;
                                }
                                ,
                                );
                  quote_user_name = ;
              }
              ,
              );
    
              page = 1;
              forumTopicUrl = http://forum.longquanzs.org/forum.php?mod=viewthread&tid=64054;
              }


*/





@end
