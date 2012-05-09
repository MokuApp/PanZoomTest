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
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
//    CCLabelBMFont *menuLabel = [CCLabelBMFont labelWithString:@"123" fntFile:@"bitmapfont.fnt"];    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Cut" fontName:@"Arial" fontSize:16];
    label.color = ccBLACK;

    CCMenuItemLabel *menuItem = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(hideMenuList:)];
    
    
    //どうしてもknifeオブジェの場所にlabelを表示できなかった
    //CCLayerPanZoom *tmpLayer = (CCLayerPanZoom*)[[GameScene sharedGameScene] getChildByTag:kPanzoomTag];
    /*
    float tmpX = [[GameScene sharedGameScene] getChildByTag:kPanzoomTag].position.x;
    float tmpY = [[GameScene sharedGameScene] getChildByTag:kPanzoomTag].position.y;
    float scaleX = [[GameScene sharedGameScene] getChildByTag:kPanzoomTag].scaleX;
    float scaleY = [[GameScene sharedGameScene] getChildByTag:kPanzoomTag].scaleY;
    if (tmpX == 240.f) {
        scaleX = 1.f;
    }
    if (tmpY == 160.f) {
        scaleY = 1.f;
    }
    
    pos.x = (pos.x - tmpX) * scaleX;
    pos.y = (pos.y - tmpY) * scaleY;
    */
    
    
    menuItem.position = ccp(winSize.width / 2, 20);

    CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
    menu.position = CGPointZero;

    [self addChild:menu z:20 tag:kMenuTag];
    
    _call = YES;
    
}

-(void)hideMenuList:(id)sender
{
    
    [self removeChildByTag:kMenuTag cleanup:YES];

    CCLayerPanZoom *tmpLayer = (CCLayerPanZoom*)[[GameScene sharedGameScene] getChildByTag:kPanzoomTag];
    //CGPoint save place of garlic
    CCSprite *tmpG = (CCSprite*)[tmpLayer getChildByTag:kGarlicTag];
    CGPoint gPos = tmpG.position;
    
    //remove garlic CCSprite from PanZoomLayer in GameScene
    [tmpLayer removeChildByTag:kGarlicTag cleanup:YES];
    
    //new adding child(cut garilc) to PanZoomLayer in GameScene
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
