//
//  Cut.m
//  CookItemBetaA
//
//  Created by tedant on 12/05/10.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "Cut.h"


@implementation Cut


-(id)init{
    
	if( (self=[super init])) {
        name = @"Cut";
    }
    return self;
}


-(void)execute
{
    [self.parent setTextureRect:CGRectMake(0, 92, 96, 70)];
    
}

@end
