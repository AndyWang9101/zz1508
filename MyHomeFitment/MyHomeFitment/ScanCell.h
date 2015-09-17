//
//  ScanCell.h
//  MyHomeFitment
//
//  Created by qianfeng on 15/9/10.
//  Copyright (c) 2015年 ZhangShaoQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanModel.h"
#import <UIKit/UIView.h>
@interface ScanCell : UITableViewCell



- (void)showDataWithModel:(ScanModel *)model;
@property (strong, nonatomic) IBOutlet UIButton *ImageBtn;

@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *intro;
- (IBAction)autorButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *autorName;
@property (strong, nonatomic) IBOutlet UIImageView *image;


- (IBAction)praiseButton:(id)sender;
@end
