//
//  ATypeTabCell.m
//  demo3
//
//  Created by gzh on 2021/8/16.
//

#import "ATypeTabCell.h"
#import <UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageDownloader.h>

@interface  ATypeTabCell()


@property(nonatomic,strong)UIImageView *imgV;

@property(nonatomic,strong) UILabel *lab;

@end


@implementation ATypeTabCell{
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupView];
        
    }
    return self;
}
-(void)setupView{
    [self.contentView addSubview:self.imgV];
    
    [self.contentView addSubview:self.lab];
    

}
-(UIImageView *)imgV{
    if (!_imgV) {
        //imgView
        _imgV = [[UIImageView alloc] init];
        
        CGFloat screen_W = [UIScreen mainScreen].bounds.size.width;
        CGFloat img_W = 0.8 *screen_W;
        
        _imgV.frame= CGRectMake(0.1 *screen_W, 10, img_W, 180);
        _imgV.layer.cornerRadius = 5.0;
        _imgV.layer.masksToBounds = YES;
        
//     _imgV.center = self.contentView.center;
        
        if (@available(iOS 13.0, *)) {
            _imgV.backgroundColor = [UIColor linkColor];
        } else {
            // Fallback on earlier versions
        }
      
    }
    return _imgV;
}

-(UILabel *)lab{
    if (!_lab) {
        //label
        _lab = [[UILabel alloc] init];
       
        _lab.frame = CGRectMake(0, CGRectGetMaxY(self.imgV.frame), [UIScreen mainScreen].bounds.size.width, 40);
        _lab.textColor = [UIColor redColor];
       
        _lab.textAlignment = NSTextAlignmentCenter;
       
        _lab.text =  NSStringFromClass(ATypeTabCell.class);
       
    }
    return _lab;
}
-(void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    
    [_imgV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage new] options:(SDWebImageRefreshCached)];
    
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//
//      }];
    
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
