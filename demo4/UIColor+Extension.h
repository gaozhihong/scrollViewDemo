//
//  UIColor+Extension.h
//  UI-02-Color
//
//  Created by Apple on 16/3/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

///  根据无符号的 32 位整数转换成对应的 rgb 颜色，0xFF0000
///
///  @param hex hex
///
///  @return UIColor
+ (instancetype)cz_colorWithHex:(u_int32_t)hex;

@end
