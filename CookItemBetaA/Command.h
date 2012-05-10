//
//  Command.h
//  CookItemBetaA
//
//  Created by tedant on 12/05/09.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Command : CCNode {
    
    NSString* name;
    
}


@property (assign) NSString* name;

-(id)init;
-(void)execute;

@end
