//
//  LQSNewDiscoverCell.m
//  myOrgForum
//
//  Created by g x on 2017/7/27.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSNewDiscoverCell.h"
#import "LQSDiscoverModel.h"

@interface LQSNewDiscoverCell ()
@property (nonatomic,strong)UILabel *titleLabel;// 大标题
@property (nonatomic,strong)UILabel *detailLabel;// 副标题
@property (nonatomic,strong)UIView *picBottomView;// 放置图片的view
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *nameLabel;// 用户名
@property (nonatomic,strong)UILabel *hitLabel;// 阅读数label


@end
@implementation LQSNewDiscoverCell{
    CGFloat _titleLabelH;
    CGFloat _detailLabelH;
    CGFloat _timeLabelH;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    _titleLabelH = [self caculateHeightForStr:@"testString" givenWidth:1000 fontSize:17];
    _detailLabelH = [self caculateHeightForStr:@"testString" givenWidth:1000 fontSize:13];
    _timeLabelH = [self caculateHeightForStr:@"testString" givenWidth:1000 fontSize:10];
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
    }];
    _detailLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.right.equalTo(_titleLabel.mas_right).offset(-5);
    }];
    _detailLabel.textColor = [UIColor lightGrayColor];
    _detailLabel.font = [UIFont systemFontOfSize:13];
    _picBottomView = [[UIView alloc]init];
    [self.contentView addSubview:_picBottomView];
    [_picBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(_titleLabelH + _detailLabelH + 10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@1);
    }];
    //_picBottomView.backgroundColor = [UIColor yellowColor];
    _timeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_picBottomView.mas_bottom).offset(5);
        make.left.equalTo(_titleLabel.mas_left);
    }];
    _nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel.mas_right).offset(30);
        make.top.equalTo(_picBottomView.mas_bottom).offset(5);
    }];
    _hitLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_hitLabel];
    [_hitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(_picBottomView.mas_bottom).offset(5);
    }];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _nameLabel.textColor = [UIColor lightGrayColor];
    _hitLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _nameLabel.font = [UIFont systemFontOfSize:10];
    _hitLabel.font = [UIFont systemFontOfSize:10];
}
-(void)prepareForReuse{
    [super prepareForReuse];
    // 移除图片底部view的子试图，不移除的话，会图片显示错乱，目前还没想到更好的解决办法。
    [self.picBottomView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}
- (void)setCellWithModel:(LQSDiscoverListModel *)model{
    
    CGFloat cellTotalHeight = 0;// 用于累加高度，需要一步一步跟着算，不能直接一下算出来，因为图片的情况有三种，所以需要跟着步骤走。
    _titleLabel.text = model.title;
    CGFloat imgVWidth = (kScreenWidth - 30)/3;// 30是前后间距20+图片间距5的总和。
    CGFloat imgViewHeight = (kScreenWidth-30)/3/3*2;;
    // 照片view的排布：如果大于等于三张，在文字下面展示三张，如果大于0小于3，则在右侧展示一张，如果等于0，则不展示
    NSInteger imgCount = model.imageList.count;
    // 这里根据三种情况的某一种情况调整picBottomView和titleLabel的约束时，记得要在另外几种不同情况再此调整，否则就会只出现一种效果，因为其他情况并没有把约束改为想要的情况。
    if (imgCount >= 3) {
        _detailLabel.numberOfLines = 1;
        [_picBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(_titleLabelH + _detailLabelH + 10);
            make.left.equalTo(self.contentView).offset(10);
            make.height.mas_equalTo(imgViewHeight);
        }];
        /*
                  */
        for (NSInteger i = 0; i < 3; i++) {
            UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake((imgVWidth + 5) * i, 0,imgVWidth , imgViewHeight)];
            [_picBottomView addSubview:imgV];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.clipsToBounds = YES;
            NSString *imgUrl = model.imageList[i];
            [imgV sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        }
        cellTotalHeight = _titleLabelH + _detailLabelH+imgViewHeight+15;// 15为3个间距
    }else if (imgCount >0 && imgCount < 3){
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-imgVWidth-3);
        }];
        _detailLabel.numberOfLines = 2;
        [_picBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(kScreenWidth - imgVWidth -10);
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.height.mas_equalTo(imgViewHeight);
        }];
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,imgVWidth , imgViewHeight)];
        [_picBottomView addSubview:imgV];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.clipsToBounds = YES;
        NSString *imgUrl = model.imageList[0];
        [imgV sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        cellTotalHeight = 5+imgViewHeight;
    }else{
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        [_picBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(_titleLabelH + _detailLabelH*2 + 10);
            make.left.equalTo(self.contentView).offset(10);
            make.height.mas_equalTo(1);
        }];
        self.detailLabel.numberOfLines = 2;
        cellTotalHeight = 10+_titleLabelH + 2*_detailLabelH;// 20 为17+13两个label的高度
    }
    _detailLabel.text = model.subject;
    
    _timeLabel.text = model.last_reply_date;
    _nameLabel.text = model.user_nick_name;
    _hitLabel.text = [NSString stringWithFormat:@"%zd阅读",model.hits];
    cellTotalHeight += 10+_timeLabelH;
    model.cellheight = cellTotalHeight;
}
- (CGFloat)caculateHeightForStr:(NSString *)str givenWidth:(CGFloat)width fontSize:(CGFloat)font{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return rect.size.height;
    
}
@end
