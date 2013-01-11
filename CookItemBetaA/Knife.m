//
//  Knife.m
//  CookItemBetaA
//
//  Created by tedant on 12/05/10.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "Knife.h"
#import "Command.h"

@implementation Knife


+(id)initItem:(Command*)command
{
    
    return [[[self alloc] initWithKnifeImage:command] autorelease];
}

-(id)initWithKnifeImage:(Command*)command
{
    if ((self = [super initWithFile:@"knife.png"])) {
//        _command = command;
//        [self addChild:_command]; 
        [self addChild:command z:1 tag:CommandTag]; 
    }
    
    return self;
}




@end
