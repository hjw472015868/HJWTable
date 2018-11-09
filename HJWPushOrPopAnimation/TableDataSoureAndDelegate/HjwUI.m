//
//  HjwUI.m
//
//  Created by hjw on 16/4/5.
//  Copyright (c) 2016年 Hujinwei. All rights reserved.
//

#import "HjwUI.h"



@implementation HjwUI
//label
+(UILabel *)createLabel:(CGRect)cg backGroundColor:(UIColor *)bgColor textAlignment:(NSInteger)alignment font:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:cg];
    if (bgColor)
    {
        label.backgroundColor = bgColor;
    }
    label.userInteractionEnabled = YES;
    label.textAlignment = alignment;
    label.font = font;
    label.textColor = textColor;
    label.text = text;
    return label;
}

//UIImageView
+ (UIImageView*)createImageView:(CGRect)cg backGroundImageV:(NSString*)imageName WithContentModel:(UIViewContentMode)contentModel{
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:cg];
    imageV.userInteractionEnabled = YES;
    imageV.contentMode = contentModel;
    imageV.image = [UIImage imageNamed:imageName];
    return imageV;
}

//UIButton
+ (UIButton*)createBt:(CGRect)cg targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font image:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title backGroundColor:(UIColor *)bgColor{
    
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = cg;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:imageName?imageName:@""] forState:UIControlStateNormal];
    [bt setBackgroundImage:[UIImage imageNamed:backImage?imageName:@""] forState:UIControlStateNormal];
    bt.titleLabel.font = font;
    bt.backgroundColor = bgColor;
    [bt addTarget:targ action:sel forControlEvents:UIControlEventTouchUpInside];
    return bt ;
}


//textField
+ (UITextField *) createTextField:(CGRect)cg withPalcehoder:(NSString *)placehoderText WithFont:(UIFont *)font WithTextAlignment:(NSInteger)alignment{
    UITextField *textField = [[UITextField alloc] initWithFrame:cg];
    textField.font = font;
    textField.backgroundColor = [UIColor whiteColor];
    textField.textAlignment = alignment;
    textField.placeholder = placehoderText;
    return textField;
}


//创建table
+ (UITableView *) createTableWithFrame:(CGRect)frame WithStyle:(UITableViewStyle)style{
    UITableView *table = [[UITableView alloc] initWithFrame:frame style:style];
    table.tableFooterView = [[UIView alloc] init];
    if (style == UITableViewStyleGrouped) {
        table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return table;
}



@end



































































