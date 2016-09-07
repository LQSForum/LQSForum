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
@property (nonatomic, strong) NSMutableArray *focusArray;//已关注的数据
@property (nonatomic, strong) NSMutableArray *focusArrayBoardId;//已关注数据的boardID
@property (nonatomic, strong) NSMutableArray *tempArray;//猜你喜欢下面的数据
@property (nonatomic, strong) NSMutableArray *notFocusArrayBoardId;//没有关注的数据的boardID

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
    
    if (self.sectionNum == 1) {//除我的关注以外其余四个板块时加载的数据
        return self.rightDataArray.count;
    }else{
        if (section == 0) {//我的关注版块第一组数据
            return self.focusArray.count;
        }else{//我的关注第二组数据
            if (self.focusArray.count < 1) {//如果已关注数据为空,加载原始的猜你喜欢
                return self.notFocusArray.count;
            }
            //如果猜你喜欢不为空,加载新的猜你喜欢数据
            return self.tempArray.count;
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
    
    cell.addFocusArrayBoardID = self.focusArrayBoardId;
    if (self.sectionNum == 1) {
        LQSCellModel *cellModel = self.rightDataArray[indexPath.row];
        cell.cellModel = cellModel;
    }else{
        if (indexPath.section == 0) {
            LQSCellModel *cellModel = self.focusArray[indexPath.row];
            cell.cellModel = cellModel;
        }else{
            if (self.focusArray.count < 1 ) {
                LQSCellModel *cellModel = self.notFocusArray[indexPath.row];
                cell.cellModel = cellModel;
            }else{
                LQSCellModel *cellModel = self.tempArray[indexPath.row];
                cell.cellModel = cellModel;
            }
            
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    UIView *selectedBackgroundView = [[UIView alloc] init];
//    selectedBackgroundView.backgroundColor = [UIColor whiteColor];
//    cell.selectedBackgroundView = selectedBackgroundView;
    
    LQSCellModel *cellModel = nil;
    if (self.sectionNum == 1) {
        cellModel = self.rightDataArray[indexPath.row];
    }else{
        if (indexPath.section == 0) {
            cellModel = self.focusArray[indexPath.row];
        }else{
            if (self.focusArray.count < 1 ) {
                cellModel = self.notFocusArray[indexPath.row];
            }else{
                cellModel = self.tempArray[indexPath.row];
            }
            
        }
    }
    NSLog(@"%@,%zd",cellModel.board_name,cellModel.board_id);
    LQSForumDetailViewController* detailVC = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"ForumDetail"];
    detailVC.boardid = cellModel.board_id;
    detailVC.boardChild = cellModel.board_child;
    detailVC.title = cellModel.board_name;
    [self.lqs_parentViewController.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

//设置头部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.sectionNum == 2 && section == 1){
        return 40;
    }
    return 0;
}

//设置头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    if (self.sectionNum == 2 && section == 1) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineView];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake( 10, 10, [UIScreen mainScreen].bounds.size.width, 25);
        //        label.lineBreakMode=NSLineBreakByWordWrapping;
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont boldSystemFontOfSize:13];
        label.text = @"猜你喜欢";
        [view addSubview:label];
        
        return view;
    }
    
    return nil;
    
}

#pragma mark - rightViewCell代理方法
//添加关注
- (void)rightViewAddFocus:(LQSRightViewCell *)rightViewCell{
    
    LQSCellModel *cellModel = rightViewCell.cellModel;
    if ([self.focusArrayBoardId containsObject:@(cellModel.board_id)]) {
        NSLog(@"已添加");
        return;
    }
    
    if (self.notFocusArrayBoardId.count > 0 ) {
        [self.notFocusArrayBoardId removeObject:@(cellModel.board_id)];
        
    }
    
    [self.focusArrayBoardId addObject:@(cellModel.board_id)];
    
    //已关注数据插入排序
    [self insertCellModelInArray:self.focusArray cellModel:cellModel];
    
//    for (int k=0; k<self.focusArray.count; k++) {
//        LQSCellModel *cellModelk = self.focusArray[k];
//        LQSLog(@"%zd/n",cellModelk.ID);
//    }
    
    //从所有数据中移除已关注数据
    [self.allFocusArray enumerateObjectsUsingBlock:^(LQSCellModel *cellModel1, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.focusArrayBoardId containsObject:@(cellModel1.board_id)]) {
            [self.allFocusArray removeObject:cellModel1];
        }
        
    }];
    
    //从猜你喜欢数据中移除已关注数据,同时从所有数据中补充新的数据
    [self.tempArray enumerateObjectsUsingBlock:^(LQSCellModel *cellModel2, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.focusArrayBoardId containsObject:@(cellModel2.board_id)]) {
            [self.tempArray removeObject:cellModel2];
            if (self.allFocusArray.count > 4) {
                [self.tempArray addObject:self.allFocusArray[4]];
                
            }else{
                
                return;
            }
            
        }
        
    }];
    
    [self reloadData];
//    NSLog(@"%s", __FUNCTION__);
    //    NSLog(@"%@", self.focusArray);
    //    NSLog(@"%@", self.rightDataArray);
}


//取消关注
- (void)rightViewCancleFocus:(LQSRightViewCell *)rightViewCell{
    
    LQSCellModel *cellModel = rightViewCell.cellModel;
    
    //判断已关注的数据组中是否存在这个boardID,如果存在即删除
    [self.focusArray enumerateObjectsUsingBlock:^(LQSCellModel *cellModel1, NSUInteger idx, BOOL * _Nonnull stop) {
        if (cellModel1.board_id == cellModel.board_id) {
            [self.focusArray removeObject:cellModel1];
        }
        
        //判断未关注数组中是否存在,如果没有则添加到未关注数组中
        if ([self.notFocusArrayBoardId containsObject:@(cellModel.board_id)]==NO) {
            
            [self.notFocusArrayBoardId addObject:@(cellModel.board_id)];
            
            if (self.allFocusArray.count > 0) {
                //添加到所有数据的数组中并排序以便点击关注时,猜你喜欢的数据可以按顺序补充
                [self insertCellModelInArray:self.allFocusArray cellModel:cellModel];
            }else{
                [self.allFocusArray addObject:cellModel];
            }
            
//            for (int k=0; k<self.allFocusArray.count; k++) {
//                LQSCellModel *cellModelk = self.allFocusArray[k];
//                NSLog(@"%zd/n",cellModelk.ID);
//            }
            
            if (self.tempArray.count < 5) {
                [self insertCellModelInArray:self.tempArray cellModel:cellModel];
                
            }else if (self.tempArray.count >= 5){
                for (int i=0; i<self.tempArray.count; i++) {
                    LQSCellModel *cellModelI = self.tempArray[i];
                    if (cellModel.ID < cellModelI.ID) {
                        [self.tempArray insertObject:cellModel atIndex:i];
                        [self.tempArray removeLastObject];
                        break;
                    }
                    
                }
                
            }
            
        }
        
    }];
    
    [self.focusArrayBoardId removeObject:@(cellModel.board_id)];
    [self reloadData];
    
//    NSLog(@"%s", __FUNCTION__);
    //    NSLog(@"%@", self.focusArray);
    //    NSLog(@"%@", self.rightDataArray);
}


//数组元素排序
- (void)insertCellModelInArray:(NSMutableArray *)array cellModel:(LQSCellModel *)cellModel{
    NSInteger index = -1;
    for (NSInteger i = 0; i < array.count; i++) {
        
        LQSCellModel *nextModel = array[i];
        if (cellModel.ID < nextModel.ID) {
            LQSLog(@"%zd---%zd",cellModel.ID,nextModel.ID);
            if (0 == i) {index = i;}
            if (i > 0) {
                LQSCellModel *previousModel = array[i - 1];
                if (cellModel.ID > previousModel.ID) {index = i;}
            }
        }
    }
    if (-1 == index) {
        index = array.count;
    }
    [array insertObject:cellModel atIndex:index];
}

- (void)setRightDataArray:(NSMutableArray *)rightDataArray{
    _rightDataArray = rightDataArray;
    [self reloadData];
}

- (void)setSectionNum:(int)sectionNum{
    _sectionNum = sectionNum;
    [self reloadData];
}

- (void)setAllFocusArray:(NSMutableArray *)allFocusArray{
    _allFocusArray = allFocusArray;
    
    [self reloadData];
}

- (void)setNotFocusArray:(NSMutableArray *)notFocusArray{
    _notFocusArray = notFocusArray;
    [self reloadData];
    
}

- (NSMutableArray *)focusArray{
    
    if (_focusArray == nil) {
        _focusArray = [NSMutableArray array];
    }
    return _focusArray;
}



- (NSMutableArray *)focusArrayBoardId{
    if (_focusArrayBoardId == nil) {
        _focusArrayBoardId = [NSMutableArray array];
    }
    return _focusArrayBoardId;
}

- (NSMutableArray *)notFocusArrayBoardId{
    if (_notFocusArrayBoardId == nil) {
        _notFocusArrayBoardId = [NSMutableArray array];
    }
    return _notFocusArrayBoardId;
}

- (NSMutableArray *)tempArray{
    if (_tempArray == nil) {
        _tempArray = [NSMutableArray arrayWithCapacity:5];
        [_tempArray addObject:self.allFocusArray[0]];
        [_tempArray addObject:self.allFocusArray[1]];
        [_tempArray addObject:self.allFocusArray[2]];
        [_tempArray addObject:self.allFocusArray[3]];
        [_tempArray addObject:self.allFocusArray[4]];
    }
    return _tempArray;
}





@end
