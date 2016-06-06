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

@interface TableViewController () {
    NSMutableDictionary *_shopDict;
}

@property (nonatomic) UITextField *textField;
@property RLMResults<Shop *> *shopArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _shopDict = [@{@"Main Street":[Shop allobjects], @"South Granville":[Shop allObjects], @"Commercial Drive":[Shop allObjects]} mutableCopy];

    RLMResults <Shop *> *mainShops = [Shop objectsWhere:@"section = 'Main Street'"];
    RLMResults <Shop *> *granvilleShops = [Shop objectsWhere:@"section = 'South Granville'"];
    RLMResults <Shop *> *commercialShops = [Shop objectsWhere:@"section = 'Commercial Drive'"];

    _shopDict = [@{@"Main Street":mainShops, @"South Granville":granvilleShops, @"Commercial Drive":commercialShops} mutableCopy];

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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_shopDict.allKeys count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionString = [_shopDict allKeys][section]; // instead of hard coding a number of index, using[section]
    NSArray *shopsInSection = [_shopDict objectForKey:sectionString];
    return [shopsInSection count];
}

// 0,0
// 0,1
// 0,2
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    //
    NSString *sectionString = [_shopDict allKeys][indexPath.section];
    NSArray *shopsInSection = [_shopDict objectForKey:sectionString];

    // shop has a arrayOfshops, display them
    Shop *shop = shopsInSection[indexPath.row];
    cell.textLabel.text = shop.name;
    
    
    return cell;
}

// dislay sectionTitle
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section  {
    return [_shopDict allKeys][section];
}


#pragma mark - Navigation
// pass data using segue to destionationVC
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"detailShopIdentifier"]) {
        
//        NSLog(@"hit the prepareForSegue");
        ShopDetailViewController *dvc = segue.destinationViewController;
    
        // cell is sender
        UITableViewCell *cell = (UITableViewCell*) sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

        NSLog(@"self.shopArray[indexPath.row]:%@", self.shopArray[indexPath.row]);

        // set specific cell has specific data
        Shop *shop = [self.shopArray objectAtIndex:indexPath.row];
        dvc.shop = shop;
    
    }
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
