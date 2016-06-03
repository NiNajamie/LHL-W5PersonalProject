//
//  ShopDetailViewController.h
//  LHL-W5PersonalProject
//
//  Created by Asuka Nakagawa on 2016-06-02.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Shop.h"

@interface ShopDetailViewController : UIViewController

@property (nonatomic) Shop *shop;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;

@end
