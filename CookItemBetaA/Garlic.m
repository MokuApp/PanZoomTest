//
//  Garlic.m
//  CookItemBetaA
//
//  Created by tedant on 12/05/10.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "Garlic.h"
#import "Command.h"

@implementation Garlic


+(id)initItem:(Command*)command
{
    
    return [[[self alloc] initWithGarlicImage:command] autorelease];
}

-(id)initWithGarlicImage:(Command*)command
{
    if ((self = [super initWithFile:@"garlic.png" rect:CGRectMake(0, 0, 96, 92)])) {
//        _command = command;
        [self addChild:command z:1 tag:CommandTag]; 
        tag = GARLIC_TAG;
    }
    
    return self;
}




@end
