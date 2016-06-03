//
//  ShopDetailViewController.m
//  LHL-W5PersonalProject
//
//  Created by Asuka Nakagawa on 2016-06-02.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "ShopDetailViewController.h"

@interface ShopDetailViewController ()

@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"hit change field :%@", self.shop.name);
    self.nameLabel.text = self.shop.name;
    NSLog(@"self.nameLabel.text: %@", self.nameLabel.text);
    
    self.addressLabel.text = self.shop.locationAddress;
    
    NSData *dataImage = self.shop.image;
    UIImage *image = [UIImage imageWithData:dataImage];

    self.imageView.image = image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
