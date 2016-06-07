//
//  AddShopViewController.m
//  LHL-W5PersonalProject
//
//  Created by Asuka Nakagawa on 2016-06-01.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "AddShopViewController.h"
#import "Shop.h"
#import "TableViewController.h"
#import "UIImage+Resize.h"
@import CoreGraphics;
#import <MapKit/MapKit.h>


@interface AddShopViewController ()<UITextFieldDelegate> {
    
    NSArray *pickerSection;
}

@property RLMResults<Shop *> *shopList;

@end

// locationManager is the object that holds locationData
@implementation AddShopViewController {
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // get URL
    NSLog(@"config is %@", [[RLMRealm defaultRealm] configuration]);
    
    // sets the delegate to the current class
    self.nameTextField.delegate = self;
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
    geocoder = [[CLGeocoder alloc] init];
    
    // initialize section
    pickerSection = @[@"Main Street", @"Commercial Drive", @"South Granville", @"Broadway", @"Gastown"];
    
    // connect pickerData
    self.sectionPickerView.delegate = self;
    self.sectionPickerView.dataSource = self;
    
}

#pragma mark - UIImagePickerController Delegates
- (IBAction)startCameraPressed:(UIButton *)sender {
    
    // sourceType is where to get pic from(in this case, from PhotoLibrary)
    // UIImagePickerControllerSourceTypeSavedPhotosAlbum
    // UIImagePickerControllerSourceTypeCamera
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // check if I can use camera
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        
        NSLog(@"Image picker!");
        // create an instance
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
        cameraPicker.sourceType = sourceType;
        cameraPicker.delegate = self;
        
        [self presentViewController:cameraPicker animated:YES completion:nil];
    }
    else{
        NSLog(@"ImagePicker has error");
    }
}

// it calls when finished camera
- (void)imagePickerController: (UIImagePickerController *)imagePicker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *cameraImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.cameraView setImage:cameraImage];
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}
// it calls when canceled imagePickerController
- (void)imagePickerControllerCanceled:(UIImagePickerController *)imagePicker {
    NSLog(@"imagePickerController canceled");
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextField Delegates
// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField {
//    NSLog(@"Text field did begin editing");
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField {
//    NSLog(@"Text field ended editing");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)getCurrentLocationPressed:(UIButton *)sender {
//    NSLog(@"currentLocation Pressed");
    [locationManager startUpdatingLocation]; //this method continuously send a stream of location data.
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"didFailWithError: %@", error);

    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"ERROR" message:@"Failed to Get your location" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [errorAlert addAction:ok];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
//        self.longtitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//        self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    // stop updatingLocation
    [locationManager stopUpdatingLocation];
    
    // reverse geocoding into human readable
    NSLog(@"Resolving the address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//        NSLog(@"Found placemarks:%@, error:%@", placemarks, error);
        if (error == nil && [placemarks count] >0) {
            placemark = [placemarks lastObject];
            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@", placemark.subThoroughfare, placemark.thoroughfare, placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    
    // create empty shop object
    Shop *shop2 = [[Shop alloc] init];
    shop2.name = self.nameTextField.text;
    // set shop's name from the userinput
    shop2.name = _nameTextField.text;

    // convert-UIImage-to-NSData
    NSData *data = UIImagePNGRepresentation(self.cameraView.image);
    
    NSString *address = self.addressLabel.text;
    shop2.locationAddress = self.addressLabel.text;
    
    // access first pickerView in this VC (selectedRowInComponent:0)
    NSString *selectedSection = [pickerSection objectAtIndex:[self.sectionPickerView selectedRowInComponent:0]];
    NSLog(@"%@", selectedSection);

    shop2.section = selectedSection;
    
    shop2.image = data;
    shop2.locationAddress = address;
    
//    NSLog(@"Size of data is");
//    NSLog(@"%lu", (unsigned long)data.length);
    
    // check if the size of imageData is too large
    if ((data.length/1024) >= 1024) {
        
        // While the imageData is too large scale down the image
        while ((data.length/1024) >= 1024) {
//            NSLog(@"While start - The imagedata size is currently: %.2f KB",roundf((data.length/1024)));
            
            // Get the current image size
            CGSize currentSize = CGSizeMake(self.cameraView.image.size.width, self.cameraView.image.size.height);
            
            // Resize the image
            self.cameraView.image = [self.cameraView.image resizedImage:CGSizeMake(roundf(((currentSize.width/100)*80)), roundf(((currentSize.height/100)*80))) interpolationQuality:1];
            
            // Pass the NSData out again
            data = UIImagePNGRepresentation(self.cameraView.image);
        }
    }
//    NSLog(@"_textField.text %@", self.nameTextField.text);
    
    shop2.image = data;
    shop2.locationAddress = address;
    shop2.section = selectedSection;
    
    // save data in database
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:shop2];
        
    }];
    // ask Realm to get all the shopList
    self.shopList = [Shop allObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// the number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;
}

// the number of rows data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerSection.count;
}
 
// The data to return for the row and component (column) that's being passed in
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerSection[row];
    
}

//#pragma mark - Navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//}

@end
