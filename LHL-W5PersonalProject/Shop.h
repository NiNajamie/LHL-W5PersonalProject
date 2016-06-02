//
//  Shop.h
//  LHL-W5PersonalProject
//
//  Created by Asuka Nakagawa on 2016-06-01.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

@interface Shop : RLMObject

@property (nonatomic, assign) NSString *name;
@property (nonatomic) NSData *image; // need to convert-uiimage-to-nsdata
// location

//@property RLMArray<Shop *> *shopArray;


@end
