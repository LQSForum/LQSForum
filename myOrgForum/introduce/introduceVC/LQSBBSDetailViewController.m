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
    total_num = 8;
    head = {
        errInfo = 调用成功,没有任何错误;
        alert = 0;
        errCode = 00000000;
        version = 2.5.0.0;
    }
    ;
    has_next = 0;
    errcode = ;
    img_url = ;
    topic = {
        hits = 150;
        icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=216574&size=middle;
        poll_info = <null>;
        level = 2;
        replies = 8;
        isFollow = 0;
        managePanel = (
        );
        hot = 0;
        essence = 1;
        location = ;
        reply_status = 1;
        flag = 0;
        vote = 0;
        type = normal_complex;
        delThread = 0;
        create_date = 1471920767000;
        activityInfo = <null>;
        is_favor = 0;
        rateList = {
            padding = ;
        }
        ;
        top = 0;
        status = 1;
        user_nick_name = 论坛报道;
        extraPanel = (
                      {
                          extParams = {
                              beforeAction = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/topicrate&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64072&pid=329651&type=check;
                          }
                          ;
                          title = 评分;
                          type = rate;
                          action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/topicrate&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64072&pid=329651&type=view;
                      }
                      ,
                      );
        content = (
                   {
                       infor = 编者按：
                       
                       
                       刚皈依的两三年，由于福报缺失，自己是不知道龙泉寺有那么多部组的，经常去的只有大寮。后来加入班长班，慢慢被师兄们拉拔到学修处承担，继而参与梳理编撰一些寺院资料，才发现——哇，寺院有这么多部组。
                       工程部数十年如一日，负责寺院各种工程建设；文化部负责师父光盘制作、博客书编辑、大型活动视频拍摄等；弘宣部负责龙泉之声网站的维护，对外弘传佛法正能量；慈善部对外称仁爱慈善基金会，有10几个项目连续不停地运转，各个角度扶危济困、接引大众；教化部承担居士学修和教育教化职能，多年来下设学修处、研修处，今年年初师父大人又根据缘起变化，新成立项目处、京外境外处等。其中项目处下设践行组、人力资源组、论坛组、慈幼组、妙音合唱团等。
                       不独这些，龙泉寺还有庞大的动漫中心、翻译中心……，今后，龙泉论坛都带您一起深入每个角落，一一去了解。
                       这次，咱们走进教化部，先听听项目处信息技术组的故事吧。
                       
                       
                       
                       部组档案
                       
                       
                       信息技术组，隶属于项目处，为2016年年初教化部架构调整时，新成立的部组。该组的成立主要是对当前龙泉论坛PC版的维护和新版龙泉APP的开发。龙泉论坛一直以来都备受师父的关注，并希望通过本次的开发使龙泉论坛成为龙泉寺内部学修的园地。;
                       type = 0;
                   }
                   ,
                   {
                       infor = http://forum.longquanzs.org/data/attachment/forum/201608/23/105156leyoyfexkybox0fu.jpg.thumb.jpg;
                       type = 1;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/105156leyoyfexkybox0fu.jpg;
                       aid = 137157;
                   }
                   ,
                   {
                       infor = 信息技术组组长王师兄：
                       
                       
                       新组成立之初可以说万事纷繁，在这个过程中，多亏张师兄和徐师兄的大力承担，不仅体现了作为老义工的标范作用，更是表率了依师法门深厚的修持。张师兄和徐师兄是龙泉论坛从无到有的见证者和参与者，这次进行全面完善，需要二位师兄贡献龙泉论坛前世今生，因此，二位师兄前期准备上下了很大的功夫，为新进组的师兄进行详细介绍并不厌其烦的讲解。
                       
                       
                       张师兄远在河南郑州，由于对龙泉论坛承担有着深刻的理解，因此，一直以来都没有好好去找世间的工作，当龙泉论坛和新版app出现问题时，都是张师兄第一时间进行解决，我经常看到微信群里很晚了张师兄还在与师兄们商讨问题的解决方案。当我们需要张师兄来寺里面对面详细介绍时，她便不辞辛苦从郑州直接来京主持会议。
                       
                       
                       徐师兄长期编程导致双手都有很严重的腱鞘炎，而且时不时的发作，发作时，双手什么都不能做，即使这样，徐师兄除了承担技术组副组长的承担外，还要考虑组内的建设，发心接引组里的师兄们能亲近佛法。最深刻的是当他腱鞘炎再次发作的时候还要带着组里的师兄们去出坡劳作，虽然不能亲手劳动，但是依旧顶着炎炎烈日，汗出如雨的陪伴着劳动的师兄们。
                       
                       
                       在这个和平的组内，2位师兄没有示现大威德，但是就是用这些看上去很平常、很细密的事在默默的奉献着自己，感动着身边的师兄。有惊天动地的威德固然可喜，但是小事中示现更是不易。我为这两位师兄喝彩，祈愿两位师兄资粮广积、福慧圆满！
                       ;
                       type = 0;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/105156leyoyfexkybox0fu.jpg;
                       aid = 137157;
                   }
                   ,
                   {
                       infor = http://forum.longquanzs.org/data/attachment/forum/201608/23/105215q9dtbbm9m3d3hby9.jpg.thumb.jpg;
                       type = 1;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/105215q9dtbbm9m3d3hby9.jpg;
                       aid = 137158;
                   }
                   ,
                   {
                       infor = 骨干义工徐师兄采访：
                       
                       
                       1、请问您结缘龙泉寺多久了？当时什么因缘？
                       徐师兄：我跟龙泉寺结缘大概是从2011年8月14日，当时是来寺里皈依。
                       
                       
                       2、什么时候皈依的?当时是什么因缘？
                       徐师兄：2011年8月14日（七一五法会）皈依。大概是2009年，父母来北京给帮我们带孩子，有一天母亲在小区里闲逛时，有人给她结缘了一套光盘“山西小院”，讲的是来自一群来自全国各地的病友在山西聚会的事情，这些人都是通过诵地藏经而受益。因为母亲身体多病，当时我虽然没有信佛，但是觉得这套光盘对母亲可能有帮助，为了让母亲观看，我就陪着她看。看过之后，觉得很好，便开始信佛。随后自己在网上找了很多佛法相关的资料来看，没有系统，也没有人指导，就是自己瞎看。后来我的一位学佛的朋友对我说，你应该去皈依了，当时自己对皈依没有什么概念，也不知道该到哪里去皈依，这个朋友向我推荐了龙泉寺，就这样来到了龙泉寺。
                       
                       
                       3、接触龙泉寺后先后承担过哪些岗位？
                       徐师兄：法会辅导员，班长，讲师，视频制作，直播，论坛维护
                       
                       
                       4、能介绍下您在技术组承担的历程么？在这里最大的收获是什么？有没有一些触动您的人或者事？
                       徐师兄：信息技术组成立的时间不长，前身是学修处文宣组，最开始我是承担班长班课和讲师班课的直播，然后加入以前的视频组，做一些法会的结行视频及师父的微开示，随后承担论坛的改版和维护，改为信息技术组之后，主要是承担论坛维护、论坛功能开发以及论坛app的开发。
                       通过承担收获有很多，最大的收获就是上位师兄的精进勇猛承担感染了我，让我看到什么是真正的发心。当自己处于低谷期时，这种感染给了我力量，没有脱离团队。;
                       type = 0;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/105215q9dtbbm9m3d3hby9.jpg;
                       aid = 137158;
                   }
                   ,
                   {
                       infor = http://forum.longquanzs.org/data/attachment/forum/201608/23/141919ik3tz5xte37t2kx7.jpg.thumb.jpg;
                       type = 1;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/141919ik3tz5xte37t2kx7.jpg;
                       aid = 137232;
                   }
                   ,
                   {
                       infor = http://forum.longquanzs.org/data/attachment/forum/201608/23/141901voor6wo9w6f6mlmf.jpg.thumb.jpg;
                       type = 1;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/141901voor6wo9w6f6mlmf.jpg;
                       aid = 137231;
                   }
                   ,
                   {
                       infor = 5、下一步您怎么规划您的承担的？包括承担和学修的平衡等。
                       徐师兄：目前心力不够，没有什么具体的规划，但是我想至少不要掉队，做好承担事项。改掉拖拉的习惯，坚持定课，闻思，不再浪费时间。
                       6、能否介绍一下目前您正在参与的一些工作，比如APP升级改版等等。
                       徐师兄：目前参与论坛服务器的迁移，论坛插件的开发，论坛app开发等
                       7、据我了解您接触论坛承担很久，您怎么理解龙泉论坛给大家带来的意义？是怎样不断提策自己承担的意乐的？
                       徐师兄：刚开始对论坛没有信心，觉得论坛已经过时了，应该用现在更先进的方式传播佛法。但是因为是师父在力推论坛，所以坚持承担下来，在承担的过程中，越来越觉得师父是对的。可能在世间大家论坛的使用越来越少，但是龙泉论坛却在不断生长壮大，在这个信息碎片化的时代，论坛越来越像一个大家庭，让师兄们凝聚在一起，交流互动，互相拉拔，这些是其他网络形式无法实现的。;
                       type = 0;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/141901voor6wo9w6f6mlmf.jpg;
                       aid = 137231;
                   }
                   ,
                   {
                       infor = http://forum.longquanzs.org/data/attachment/forum/201608/23/141951kzwk55ekcpevzacv.jpg.thumb.jpg;
                       type = 1;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/141951kzwk55ekcpevzacv.jpg;
                       aid = 137233;
                   }
                   ,
                   {
                       infor =
                       自己的意乐其实都来自于师法友团队，每当自己心里没有力量的时候，这个团队总能把我再拉起来。看到师父的辛苦，看到法师的用心，看到同行善友的发心，自己就很惭愧，虽然很多时候萎靡不振，但至少还是在这个团队里，只要在，就总有一天会恢复状态，跟随大家一起辗转增上。;
                       type = 0;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/141951kzwk55ekcpevzacv.jpg;
                       aid = 137233;
                   }
                   ,
                   {
                       infor = http://forum.longquanzs.org/data/attachment/forum/201608/23/105239oesadsb11bzax1js.jpg.thumb.jpg;
                       type = 1;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/105239oesadsb11bzax1js.jpg;
                       aid = 137159;
                   }
                   ,
                   {
                       infor =    编辑：王隆隆  ;
                       type = 0;
                       originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/105239oesadsb11bzax1js.jpg;
                       aid = 137159;
                   }
                   ,
                   );
        user_id = 216574;
        userTitle = 初级会员;
        gender = 1;
        mobileSign = ;
        reply_posts_id = 329651;
        topic_id = 64072;
        title = [教化部]部组故事03：信息技术组采访∣我们心灵家园的守护者;
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
                                     infor = 随喜赞叹！[good][good][good];
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
                reply_posts_id = 329693;
                role_num = 1;
                level = 6;
                reply_id = 195349;
                is_quote = 0;
                userTitle = 金牌会员;
                quote_pid = 0;
                posts_date = 1471929613000;
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
                                  action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64072&pid=329693&type=post;
                              }
                              ,
                              );
                quote_user_name = ;
            }
            ,
            {
                reply_content = (
                 {
                     infor = 心灵家园的守护者。
                     [mobcent_phiz=http://forum.longquanzs.org/static/image/smiley/QQ/079.gif]
                      突然想起那些和张师兄在微信上互喊沟通的不眠凌晨。;
                      type = 0;
                      }
                      ,
                      );
                      location = ;
                      mobileSign = ;
                      position = 3;
                      status = 1;
                      title = ;
                      managePanel = (
                      );
                      delThread = 0;
                      icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=165485&size=middle;
                      reply_status = 1;
                      reply_type = normal;
                      reply_name = 人间的面;
                      reply_posts_id = 329734;
                      role_num = 1;
                      level = 8;
                      reply_id = 165485;
                      is_quote = 0;
                      userTitle = 超级版主;
                      quote_pid = 0;
                      posts_date = 1471936384000;
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
                                        action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64072&pid=329734&type=post;
                                    }
                                    ,
                                    );
                      quote_user_name = ;
                      }
                      ,
                      {
                          reply_content = (
                                           {
                                               infor = 心力不够，没有什么具体的规划，但是我想至少不要掉队，做好承担事项。改掉拖拉的习惯，坚持定课，闻思，不再浪费时间。这也是我目前的状态，感恩师兄分享[good];
                                               type = 0;
                                           }
                                           ,
                                           );
                          location = ;
                          mobileSign = 来自龙泉论坛手机客户端;
                          position = 4;
                          status = 1;
                          title = ;
                          managePanel = (
                          );
                          delThread = 0;
                          icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=207267&size=middle;
                          reply_status = 1;
                          reply_type = normal;
                          reply_name = 贤英@;
                          reply_posts_id = 329745;
                          role_num = 1;
                          level = 6;
                          reply_id = 207267;
                          is_quote = 0;
                          userTitle = 金牌会员;
                          quote_pid = 0;
                          posts_date = 1471937523000;
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
                                            action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64072&pid=329745&type=post;
                                        }
                                        ,
                                        );
                          quote_user_name = ;
                      }
                      ,
                      {
                          reply_content = (
                                           {
                                               infor = 点点滴滴的成长包含了师长的用心，为我们搭建学修、积累资粮的平台;
                                               type = 0;
                                           }
                                           ,
                                           );
                          location = ;
                          mobileSign = 来自龙泉论坛手机客户端;
                          position = 5;
                          status = 1;
                          title = ;
                          managePanel = (
                          );
                          delThread = 0;
                          icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=207686&size=middle;
                          reply_status = 1;
                          reply_type = normal;
                          reply_name = fanzhiwen;
                          reply_posts_id = 329787;
                          role_num = 1;
                          level = 4;
                          reply_id = 207686;
                          is_quote = 0;
                          userTitle = 高级会员;
                          quote_pid = 0;
                          posts_date = 1471942544000;
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
                                            action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64072&pid=329787&type=post;
                                        }
                                        ,
                                        );
                          quote_user_name = ;
                      }
                      ,
                      {
                          reply_content = (
                           {
                               infor = 出山了？[mobcent_phiz=http://forum.longquanzs.org/static/image/smiley/QQ/heshi.gif]欢迎回来;
                                            type = 0;
                                            }
                                            ,
                                            );
                                            location = ;
                                            mobileSign = ;
                                            position = 6;
                                            status = 1;
                                            title = ;
                                            managePanel = (
                                            );
                                            delThread = 0;
                                            icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=141111&size=middle;
                                            reply_status = 1;
                                            reply_type = normal;
                                            reply_name = 贤写;
                                            reply_posts_id = 329814;
                                            role_num = 1;
                                            level = 8;
                                            reply_id = 141111;
                                            is_quote = 1;
                                            userTitle = 超级版主;
                                            quote_pid = 0;
                                            posts_date = 1471944653000;
                                            quote_content = fanzhiwen 发表于 2016-8-23 16:55
                                            点点滴滴的成长包含了师长的用心，为我们搭建学修、积累资粮的平台;
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
                                                              action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64072&pid=329814&type=post;
                                                          }
                                                          ,
                                                          );
                                            quote_user_name = ;
                                            }
                                            ,
                                            {
                                                reply_content = (
                                                     {
                                                         infor = [mobcent_phiz=http://forum.longquanzs.org/static/image/smiley/QQ/heshi.gif][mobcent_phiz=http://forum.longquanzs.org/static/image/smiley/QQ/014.gif]随喜大家~;
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
                                                                  icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=141111&size=middle;
                                                                  reply_status = 1;
                                                                  reply_type = normal;
                                                                  reply_name = 贤写;
                                                                  reply_posts_id = 329828;
                                                                  role_num = 1;
                                                                  level = 8;
                                                                  reply_id = 141111;
                                                                  is_quote = 0;
                                                                  userTitle = 超级版主;
                                                                  quote_pid = 0;
                                                                  posts_date = 1471945688000;
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
                                                                                    action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64072&pid=329828&type=post;
                                                                                }
                                                                                ,
                                                                                );
                                                                  quote_user_name = ;
                                                                  }
                                                                  ,
                                                                  {
                                                                      reply_content = (
                                                                                       {
                                                                                           infor = 随喜发心！;
                                                                                           type = 0;
                                                                                       }
                                                                                       ,
                                                                                       );
                                                                      location = ;
                                                                      mobileSign = ;
                                                                      position = 8;
                                                                      status = 1;
                                                                      title = ;
                                                                      managePanel = (
                                                                      );
                                                                      delThread = 0;
                                                                      icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=204511&size=middle;
                                                                      reply_status = 1;
                                                                      reply_type = normal;
                                                                      reply_name = 路人乙;
                                                                      reply_posts_id = 329943;
                                                                      role_num = 1;
                                                                      level = 3;
                                                                      reply_id = 204511;
                                                                      is_quote = 0;
                                                                      userTitle = 中级会员;
                                                                      quote_pid = 0;
                                                                      posts_date = 1471957180000;
                                                                      quote_content = ;
                                                                      extraPanel = (
                                                                      );
                                                                      quote_user_name = ;
                                                                  }
                                                                  ,
                                                                  {
                                                                      reply_content = (
                                                                                       {
                                                                                           infor = 随喜赞叹信息技术组的义工菩萨们[mobcent_phiz=http://forum.longquanzs.org/static/image/smiley/QQ/heshi.gif][mobcent_phiz=http://forum.longquanzs.org/static/image/smiley/QQ/080.gif];
                                                                                                                   type = 0;
                                                                                                                   }
                                                                                                                   ,
                                                                                                                   );
                                                                                                                   location = ;
                                                                                                                   mobileSign = ;
                                                                                                                   position = 9;
                                                                                                                   status = 1;
                                                                                                                   title = ;
                                                                                                                   managePanel = (
                                                                                                                   );
                                                                                                                   delThread = 0;
                                                                                                                   icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=194170&size=middle;
                                                                                                                   reply_status = 1;
                                                                                                                   reply_type = normal;
                                                                                                                   reply_name = 窗前明月光;
                                                                                                                   reply_posts_id = 330905;
                                                                                                                   role_num = 1;
                                                                                                                   level = 6;
                                                                                                                   reply_id = 194170;
                                                                                                                   is_quote = 0;
                                                                                                                   userTitle = 金牌会员;
                                                                                                                   quote_pid = 0;
                                                                                                                   posts_date = 1472090311000;
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
                                                                                                                                     action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64072&pid=330905&type=post;
                                                                                                                                 }
                                                                                                                                 ,
                                                                                                                                 );
                                                                                                                   quote_user_name = ;
                                                                                                                   }
                                                                                                                   ,
                                                                                                                   );
                               page = 1;
                               forumTopicUrl = http://forum.longquanzs.org/forum.php?mod=viewthread&tid=64072;
                               }



*/








@end
