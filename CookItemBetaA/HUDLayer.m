//
//  HUDLayer.m
//  CookItemBetaA
//
//  Created by tedant on 12/05/06.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "HUDLayer.h"
#import "CCLayerPanZoom.h"
#import "GameScene.h"


@implementation HUDLayer


-(id) init
{
	if( (self=[super init])) {
        _call = NO;
        
    }
    return self;
}


-(void)showMenuList:(Item*)selectedObj dropped:(Item*)droppedObj
{
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:[selectedObj commandName] fontName:@"Arial" fontSize:16];
    label.color = ccBLACK;

    CCMenuItemLabel *menuItem = [CCMenuItemLabel itemWithLabel:label target:selectedObj selector:@selector(execute:)];    
    
    
    menuItem.position = ccp(winSize.width / 2, 20);

    CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
    menu.position = CGPointZero;

    [self addChild:menu z:20 tag:kMenuTag];
    
    _call = YES;
    
}

-(void)hideMenuList
{
    
    [self removeChildByTag:kMenuTag cleanup:YES];

    
    _call = NO;
    
}

-(BOOL)isCall
{
    return _call;
}

@end
