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


@synthesize tabSprite,tabUpSprite,tabDownSprite,isCall;

-(id) init
{
	if((self=[super init])) {
//        _call = NO;
        self.isCall = NO;
        /*
        self.tabUpSprite = spriteWithRect(@"hud.png", CGRectMake(184, 58, 112, 22));
        tabUpSprite.position = CGPointMake(480.0/2.0, 320.0-HUD_HEIGHT-(22.0/2.0));
        
        self.tabDownSprite = spriteWithRect(@"hud.png", CGRectMake(184, 81, 112, 22));
        tabDownSprite.position = CGPointMake(480.0/2.0, 320.0-(22.0/2.0));
        [tabDownSprite setVisible:NO];
        
        self.tabSprite = spriteWithRect(@"hud.png", CGRectMake(0, 0, 480, HUD_HEIGHT));
        tabSprite.position = CGPointMake(480.0/2.0, 320.0-(HUD_HEIGHT/2.0));
        [tabSprite setVisible:YES];
        [tabSprite setOpacity:200.0f];
        */
        self.tabUpSprite = spriteWithRect(@"verticalHUD.png", CGRectMake(24, 95, 22, 112));
        tabUpSprite.position = CGPointMake(480.0-HUD_HEIGHT-(22.0/2.0), 320.0/2.0);
        
        self.tabDownSprite = spriteWithRect(@"verticalHUD.png", CGRectMake(0, 95, 22, 112));
        tabDownSprite.position = CGPointMake(480.0-(22.0/2.0), 320.0/2.0);
        [tabDownSprite setVisible:NO];
        
        self.tabSprite = spriteWithRect(@"verticalHUD.png", CGRectMake(47, 0, HUD_HEIGHT, 320));
        tabSprite.position = CGPointMake(480.0-(HUD_HEIGHT/2.0), 320.0/2.0);
        [tabSprite setVisible:YES];
        [tabSprite setOpacity:200.0f];        

        [[GameScene sharedGameScene] addChild:tabUpSprite z:HUD_Z_INDEX];
        [[GameScene sharedGameScene] addChild:tabDownSprite z:HUD_Z_INDEX];
        [[GameScene sharedGameScene] addChild:tabSprite z:HUD_Z_INDEX];
        
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
    
//    _call = YES;
    self.isCall = YES;
    
}

-(void)hideMenuList
{
    
    
    [self removeChildByTag:kMenuTag cleanup:YES];

    
//    _call = NO;
    self.isCall = NO;
    
}
/*
-(BOOL)isCall
{
    return _call;
}
*/
-(void) expandMenu {
    
    menuIsHidden = NO;
    [tabDownSprite setVisible:NO];
    [tabUpSprite setVisible:YES];
    [tabSprite setVisible:YES];
}

-(void) collapseMenu{
    
    menuIsHidden = YES;
    [tabDownSprite setVisible:YES];
    [tabUpSprite setVisible:NO];
    [tabSprite setVisible:NO];
}

-(void)handleInitialTouch:(CGPoint)p{
    
    CCLOG(@"handle point %f,%f",p.x, p.y);
    CCLOG(@"rect point %f,%f", [self tabRect].origin.x, [self tabRect].origin.y);
    
    if (CGRectContainsPoint([self tabRect], p)) {
        if (menuIsHidden) {
            [self expandMenu];
        }else{
            [self collapseMenu];
        }
    }
}

-(CGRect) tabRect{
    if (menuIsHidden) 
        return CGRectMake(480-tabUpSprite.textureRect.size.width, 
                          113, 
                          tabUpSprite.textureRect.size.width, 
                          tabUpSprite.textureRect.size.height);
    else
        return CGRectMake(480-HUD_HEIGHT-tabUpSprite.textureRect.size.width, 
                          113, 
                          tabUpSprite.textureRect.size.width, 
                          tabUpSprite.textureRect.size.height);    
}

@end
