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


-(void)showMenuList:(CGPoint)pos
{
    
//    CGSize winSize = [CCDirector sharedDirector].winSize;
//    CCLabelBMFont *menuLabel = [CCLabelBMFont labelWithString:@"123" fntFile:@"bitmapfont.fnt"];    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Cut" fontName:@"Arial" fontSize:16];
    label.color = ccc3(128, 128, 128);

    CCMenuItemLabel *menuItem = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(hideMenuList:)];
    menuItem.position = pos;

    CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
    menu.position = CGPointZero;

    [self addChild:menu z:10 tag:kMenuTag];
    
    _call = YES;
    
}

-(void)hideMenuList:(id)sender
{
    
//    CCMenu *_menu = (CCMenu *)[self getChildByTag: kMenuTag];
    [self removeChildByTag:kMenuTag cleanup:YES];
//    [self.parent getChildByTag:kKnifeTag];
//    [[GameScene sharedGameScene] removeChildByTag:1 cleanup:YES];
    CCLayerPanZoom *tmpLayer = (CCLayerPanZoom*)[[GameScene sharedGameScene] getChildByTag:kPanzoomTag];
    CCSprite *tmpG = (CCSprite*)[tmpLayer getChildByTag:kGarlicTag];
    
    
    CGPoint gPos = tmpG.position;
    [tmpLayer removeChildByTag:kGarlicTag cleanup:YES];
    
    CCSprite *garlic = [CCSprite spriteWithFile: @"garlicCutA.png"];
    [tmpLayer addChild: garlic 
                          z: 1 
                        tag: kGarlicTag];
    garlic.position =  gPos;
    
    _call = NO;
    
}

-(BOOL)isCall
{
    return _call;
}

@end
