//
//  HjwUI.h
//
//  Created by hjw on 16/4/5.
//  Copyright (c) 2016年 Hujinwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface HjwUI : NSObject

//label
+(UILabel *)createLabel:(CGRect)cg backGroundColor:(UIColor *)bgColor textAlignment:(NSInteger)alignment font:(UIFont *)font textColor:(UIColor *)textColor text:(NSString *)text;

//UIImageView
+ (UIImageView*)createImageView:(CGRect)cg backGroundImageV:(NSString*)imageName WithContentModel:(UIViewContentMode)contentModel;
    
//UIButton
+ (UIButton*)createBt:(CGRect)cg targ:(id)targ sel:(SEL)sel titleColor:(UIColor*)titleColor font:(UIFont*)font  image:(NSString*)imageName backGroundImage:(NSString*)backImage title:(NSString*)title backGroundColor:(UIColor *)bgColor;

//textField
+ (UITextField *) createTextField:(CGRect)cg withPalcehoder:(NSString *)placehoderText WithFont:(UIFont *)font WithTextAlignment:(NSInteger)alignment;

//table
+ (UITableView *) createTableWithFrame:(CGRect)frame WithStyle:(UITableViewStyle)style;

@end
