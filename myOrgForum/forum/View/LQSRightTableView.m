//
//  LQSRightTableView.m
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSRightTableView.h"
#import "AFNetworking.h"
#import "LQSSectionModel.h"
#import "LQSCellModel.h"
#import "YYModel.h"
#import "LQSRightViewCell.h"
#import "LQSForumDetailViewController.h"

@interface LQSRightTableView ()<UITableViewDelegate,UITableViewDataSource,LQSRightViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *leftDataArray;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableArray *focusArray;

@end

@implementation LQSRightTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionNum;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.sectionNum == 1) {
        return self.rightDataArray.count;
    }else{
        if (section == 0) {
            return self.focusArray.count;
        }else{
            return self.rightDataArray.count;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"LQSPartTableViewCellID";
    LQSRightViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LQSRightViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    if (self.sectionNum == 1) {
        LQSCellModel *cellModel = self.rightDataArray[indexPath.row];
        cell.cellModel = cellModel;
    }else{
        if (indexPath.section == 0) {
            LQSCellModel *cellModel = self.focusArray[indexPath.row];
            cell.cellModel = cellModel;
        }else{
            LQSCellModel *cellModel = self.rightDataArray[indexPath.row];
            cell.cellModel = cellModel;
            
        }
    
  }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = selectedBackgroundView;
    
    LQSCellModel *cellModel = nil;
    if (self.sectionNum == 1) {
        cellModel = self.rightDataArray[indexPath.row];
    }else{
        if (indexPath.section == 0) {
            cellModel = self.focusArray[indexPath.row];
        }else{
            cellModel = self.rightDataArray[indexPath.row];
        }
    }
    NSLog(@"%@,%zd",cellModel.board_name,cellModel.board_id);
    LQSForumDetailViewController* detailVC = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"ForumDetail"];
    detailVC.boardid = cellModel.board_id;
    [self.lqs_parentViewController.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
    
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
        
        if (self.sectionNum == 2) {
            if (section == 0) {
                return @"猜你喜欢";
            }else{
                return nil;
            }
        }else{
            return nil;
        }
        
    }

- (void)rightViewFocus:(LQSRightViewCell *)rightViewCell{
    
    //    self.focusArray = focusArray;
    NSIndexPath *indexPath = [self indexPathForCell:rightViewCell];
    LQSCellModel *cellModel = self.rightDataArray[indexPath.row];
    [self.focusArray addObject:cellModel];
    [self reloadData];
}

- (void)setRightDataArray:(NSMutableArray *)rightDataArray{
    _rightDataArray = rightDataArray;
    [self reloadData];
}

- (void)setSectionNum:(int)sectionNum{
    _sectionNum = sectionNum;
    [self reloadData];
}

- (NSMutableArray *)focusArray{
    
    if (_focusArray == nil) {
        _focusArray = [NSMutableArray array];
    }
    return _focusArray;
}

@end
