//
//  BaseTypeTabCell.m
//  demo4
//
//  Created by gzh on 2021/8/20.
//

#import "BaseTypeTabCell.h"
#import <UIImageView+WebCache.h>

@implementation BaseTypeTabCell
{
    UIImageView *_iconView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         //img
        UIImageView *iconV = [[UIImageView alloc] init];
        
        iconV.frame = CGRectMake(20, 20, 100 , 80);
        
        iconV.backgroundColor = [UIColor purpleColor];
        
        iconV.layer.cornerRadius = 2.5;
        
        iconV.layer.masksToBounds = YES;
        
        _iconView = iconV;
        
        [self.contentView addSubview:iconV];
        
//        iconV.contentMode = UIViewContentModeScaleAspectFill;
        
//        [iconV sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage new] options:(SDWebImageRefreshCached)];
        
        UILabel * contLab = [[UILabel alloc] init];
        
        contLab.frame = CGRectMake(CGRectGetMaxX(iconV.frame)+10, 20, 200, 80);
        
        contLab.numberOfLines = 0;
        
        contLab.font = [UIFont systemFontOfSize:15.0];
        contLab.text = @"秋天是收获的季节，2020年色彩斑斓的秋天即将划上丰收的句号。明天，溧水农民丰收节将在和美凤鸣的和凤开幕，万亩农田里即将唱起一年里最欢快的歌。";
        
        [self.contentView addSubview:contLab];

        
    }
    
    return self;
}

-(void)setPicUrl:(NSString *)picUrl{
    _picUrl = picUrl;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage new] options:(SDWebImageRefreshCached)];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
