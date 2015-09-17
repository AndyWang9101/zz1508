//
//  ScanCell.m
//  MyHomeFitment
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 ZhangShaoQi. All rights reserved.
//

#import "ScanCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"


@implementation ScanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//重写get方法


-(void)showDataWithModel:(ScanModel *)model{


    self.intro.text = [NSString stringWithFormat:@"Style:%@",model.title];
    self.address.text = [NSString stringWithFormat:@"详情介绍:%@",model.title_sub];
    self.autorName.text = [NSString stringWithFormat:@"设计者:%@",model.author_nick];
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.cover_pic]];
    if (!model.cover_pic) {
        [self.image sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        [_ImageBtn sd_setBackgroundImageWithURL:nil forState:(UIControlStateNormal)];
        self.autorName.text = nil;
        self.address.text = nil;
        self.intro.text = [NSString stringWithFormat:@"分组类型:%@",model.title];
        return;
    }
    [_ImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.author_face] forState:(UIControlStateNormal)];
    _ImageBtn.layer.masksToBounds = YES;
    _ImageBtn.layer.cornerRadius = _ImageBtn.bounds.size.width/2;
    
    
//    if ([model.item_type isEqualToString:@"collection"]) {
//        self.intro.text = [NSString stringWithFormat:@"Style:%@",model.title];
//        self.address.text = [NSString stringWithFormat:@"详情介绍:%@",model.title_sub];
//        self.autorName.text = [NSString stringWithFormat:@"设计者:%@",model.author_nick];
//        [self.image sd_setImageWithURL:[NSURL URLWithString:model.cover_pic]];
//        [_ImageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.author_face] forState:(UIControlStateNormal)];
//        
//        _ImageBtn.layer.masksToBounds = YES;
//        _ImageBtn.layer.cornerRadius = _ImageBtn.bounds.size.width/2;
//        
//        
//    }
//    else{
//        [self.image sd_setImageWithURL:[NSURL URLWithString:model.pic]];
//        [_ImageBtn sd_setBackgroundImageWithURL:nil forState:(UIControlStateNormal)];
//        self.autorName.text = nil;
//        self.address.text = nil;
//        self.intro.text = [NSString stringWithFormat:@"分组类型:%@",model.title];
//        
//    }
}


- (IBAction)autorButton:(id)sender {
   
}
- (IBAction)praiseButton:(id)sender {
}
@end
