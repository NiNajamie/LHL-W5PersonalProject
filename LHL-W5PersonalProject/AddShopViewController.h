//
//  AddShopViewController.h
//  LHL-W5PersonalProject
//
//  Created by Asuka Nakagawa on 2016-06-01.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "Shop.h"
#import <CoreLocation/CoreLocation.h>

@interface AddShopViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic) Shop *shop;

@property (weak, nonatomic) IBOutlet UIButton *startCameraButton;
@property (weak, nonatomic) IBOutlet UIImageView *cameraView;

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longtitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *getCurrentLocationButton;


@end
