//
//  HUDLayer.h
//  CookItemBetaA
//
//  Created by tedant on 12/05/06.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Item.h"

@class GameScene;

enum menuTags
{
	kMenuTag,
};

@interface HUDLayer : CCLayer {
//    BOOL _call;
    BOOL isCall;
    BOOL menuIsHidden;
}

@property(nonatomic, retain) CCSprite *tabUpSprite;
@property(nonatomic, retain) CCSprite *tabSprite;
@property(nonatomic, retain) CCSprite *tabDownSprite;


@property(nonatomic) BOOL isCall;


//-(BOOL)isCall;
-(void)showMenuList:(Item*)selectedObj dropped:(Item*)droppedObj;
-(void)hideMenuList;


-(void) handleInitialTouch:(CGPoint)p;

-(CGRect) tabRect;

@end
