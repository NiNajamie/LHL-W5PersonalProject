//
//  Shop.h
//  LHL-W5PersonalProject
//
//  Created by Asuka Nakagawa on 2016-06-01.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import <Realm/Realm.h>


//RLM_ARRAY_TYPE(Detail)

@interface Shop : RLMObject

@property (nonatomic) NSString *name;
// location, image

@end
