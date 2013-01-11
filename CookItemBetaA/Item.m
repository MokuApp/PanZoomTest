//
//  Item.m
//  CookItemBetaA
//
//  Created by tedant on 12/05/09.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "Item.h"
#import "Command.h"


@implementation Item



-(void)execute:(id)sender
{
    //[_command execute];
    [[self getChildByTag:CommandTag] execute];
    
}

-(NSString*)commandName
{
    return [[self getChildByTag:CommandTag] name];
}

@end
