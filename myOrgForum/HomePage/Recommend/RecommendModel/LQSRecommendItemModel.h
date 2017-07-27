//
//  LQSRecommendItemModel.h
//  myOrgForum
//
//  Created by wangbo on 2017/7/16.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LQSRecommendItemModel <NSObject>

@end

@interface LQSReItemExtParam : NSObject

@property (nonatomic, strong) NSMutableArray *fastpostForumIds;
@property (nonatomic, strong) NSString *moduleId;
@property (nonatomic, strong) NSString *dataId;
@property (nonatomic, strong) NSString *titlePosition;
@property (nonatomic, strong) NSString *subListStyle;
@property (nonatomic, strong) NSString *listTitleLength;
@property (nonatomic, strong) NSString *listSummaryLength;
@property (nonatomic, strong) NSString *newsModuleId;
@property (nonatomic, strong) NSString *articleId;
@property (nonatomic, strong) NSString *subDetailViewStyle;
@property (nonatomic, strong) NSString *listBoardNameState;
@property (nonatomic, strong) NSString *order;
@property (nonatomic, strong) NSString *filterId;
@property (nonatomic, strong) NSString *forumId;
@property (nonatomic, strong) NSString *topicId;
@property (nonatomic, strong) NSString *orderby;
@property (nonatomic, strong) NSString *redirect;
@property (nonatomic, strong) NSString *isShowMessagelist;
@property (nonatomic, strong) NSString *isShowTopicTitle;
@property (nonatomic, strong) NSString *listImagePosition;
@property (nonatomic, strong) NSString *filter;


@end

@interface LQSRecommendItemModel : NSObject

@property (nonatomic, strong) NSString *belongId;               //属于哪一个 id 对应 id
@property (nonatomic, strong) NSString *iconStyle;              // "image"
@property (nonatomic, strong) NSString *icon;                   // "http://7xs527.com2.z0.glb.qiniucdn.com/user-icon-1496783788761-be230cae"
@property (nonatomic, strong) NSString *title;                  // 1、2、3、4、5
@property (nonatomic, strong) NSString *desc;                   //实际使用的标题
@property (nonatomic, strong) LQSReItemExtParam *extParams;     //
@property (nonatomic, strong) NSString *style;                  
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSMutableArray *componentList;

@end


/**
 {
    "id": "c148",
    "iconStyle": "image",
    "icon": "http://7xs527.com2.z0.glb.qiniucdn.com/user-icon-1496783788761-be230cae",
    "title": "1",
    "desc": "死亡到底离我们有的多远？ ",
    "extParams": {
        "fastpostForumIds": [ ],
        "moduleId": 1,
        "dataId": 0,
        "titlePosition": "left",
        "subListStyle": "",
        "listTitleLength": 40,
        "listSummaryLength": 40,
        "newsModuleId": 0,
        "articleId": 0,
        "subDetailViewStyle": "",
        "listBoardNameState": 0,
        "order": 0,
        "filterId": 0,
        "forumId": 0,
        "topicId": 89611,
        "orderby": "",
        "redirect": "",
        "isShowMessagelist": 0,
        "isShowTopicTitle": 1,
        "listImagePosition": 2,
        "filter": ""
    },
    "style": "flat",
    "type": "postlist",
    "componentList": [ ]
 },
 */
