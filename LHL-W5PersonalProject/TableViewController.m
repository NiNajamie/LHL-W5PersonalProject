//
//  TableViewController.m
//  LHL-W5PersonalProject
//
//  Created by Asuka Nakagawa on 2016-06-01.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "TableViewController.h"
#import "AddShopViewController.h"
#import "ShopDetailViewController.h"

@interface TableViewController ()

@property (nonatomic) UITextField *textField;
@property RLMResults<Shop *> *shopArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    // conbine data from Realm & shopArray which created in the class
    self.shopArray = [Shop allObjects];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.shopArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // shop has a arrayOfshops, display them
    Shop *shop = self.shopArray[indexPath.row];
    cell.textLabel.text = shop.name;
    
    return cell;
}


#pragma mark - Navigation
// can pass data using segue to destionationVC
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
      NSLog(@"hit the prepareForSegue");
    ShopDetailViewController *dvc = segue.destinationViewController;
    
    // cell is sender
    UITableViewCell *cell = (UITableViewCell*) sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // set specific cell has specific data
    Shop *shop = [self.shopArray objectAtIndex:indexPath.row];
    dvc.shop = shop;
    
    NSLog(@"%@", self.shopArray[indexPath.row]);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

@end
