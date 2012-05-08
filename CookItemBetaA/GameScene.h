//
//  GameScene.h
//  CookItemBetaA
//
//  Created by tedant on 12/05/05.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCLayerPanZoom.h"

@class HUDLayer;

enum nodeTags
{
	kBackgroundTag,
    kGarlicTag,
    kKnifeTag,
};

enum layerTags
{
    kPanzoomTag,
};


@interface GameScene : CCLayer <CCLayerPanZoomClickDelegate> {
    
    CCLayerPanZoom *_panZoomLayer;
    CCSprite *_selectedObject;
    CCSprite *_droppedObject;
    HUDLayer *_hud;
}


+(CCScene *) scene;
+(GameScene*) sharedGameScene;

-(id) initWithHUD:(HUDLayer*)hud;


@end
