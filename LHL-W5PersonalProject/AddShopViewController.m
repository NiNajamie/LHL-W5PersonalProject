//
//  AddShopViewController.m
//  LHL-W5PersonalProject
//
//  Created by Asuka Nakagawa on 2016-06-01.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "AddShopViewController.h"
#import "Shop.h"

@interface AddShopViewController ()<UITextFieldDelegate, UITextViewDelegate>

@property RLMResults<Shop *> *shopList;

@end

@implementation AddShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // get URL
    NSLog(@"config is %@", [[RLMRealm defaultRealm] configuration]);
    
    // sets the delegate to the current class
    self.nameTextField.delegate = self;
    
//    Shop *shop2 = [[Shop alloc] init];
//    shop2.name = self.nameTextField.text;
//    NSLog(@"_textField.text %@", self.nameTextField.text);
//    
////    // set shop's name from the userinput
////    shop2.name = _nameTextField.text;
//    
//    // save data
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        [realm addObject:shop2];
//    }];
//    // asking Realm to get all the shopList
//    self.shopList = [Shop allObjects];

}

#pragma mark - TextField Delegates
// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"Text field did begin editing");
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"Text field ended editing");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    
    Shop *shop2 = [[Shop alloc] init];
    shop2.name = self.nameTextField.text;
    NSLog(@"_textField.text %@", self.nameTextField.text);
    
    // set shop's name from the userinput
    shop2.name = _nameTextField.text;
    
    // save data
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
