//
//  Command.m
//  CookItemBetaA
//
//  Created by tedant on 12/05/09.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "Command.h"


@implementation Command

@synthesize name;

-(id)init{
    
	if( (self=[super init])) {
        name = @"command";
    }
    return self;
}


-(void)execute
{
    
}

@end
