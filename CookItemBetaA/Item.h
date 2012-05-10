//
//  Item.h
//  CookItemBetaA
//
//  Created by tedant on 12/05/09.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Command;

@interface Item : CCSprite {
    
    Command* _command;
    
    
}

+(id)initItem:(Command*)command;

-(void)execute:(id)sender;

-(NSString*)commandName;

@end
