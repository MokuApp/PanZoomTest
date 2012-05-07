//
//  HUDLayer.m
//  CookItemBetaA
//
//  Created by tedant on 12/05/06.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "HUDLayer.h"


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
//    CCLabelTTF *menuLabel = [CCLabelTTF labelWithString:@"Cut" fontName:@"Arial" fontSize:16];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Cut" fontName:@"Arial" fontSize:16];
    label.color = ccc3(128, 128, 128);
 //   label.position = pos;//ccp(winSize.width / 2, winSize.height / 2);

   // [self addChild:label z:10];
    
    CCMenuItemLabel *menuItem = [CCMenuItemLabel itemWithLabel:label target:self selector:@selector(hideMenuList:)];
//    menuItem.position = pos;
    
//    CCMenuItem *menuItem = [CCMenuItemImage itemFromNormalImage:@"Icon-72.png" selectedImage:@"Icon-72.png"];
    menuItem.position = pos;
    CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
    menu.position = CGPointZero;//ccp(winSize.width / 2, winSize.height / 2);//pos;
    [self addChild:menu];

    _call = YES;
    
}

-(void)hideMenuList:(id)sender
{
    
//    CCLabelTTF *_label = (CCLabelTTF *)[self getChildByTag: 5];
 //   [self removeChildByTag:5 cleanup:YES];
    _call = NO;
    
}

-(BOOL)isCall
{
    return _call;
}

@end
