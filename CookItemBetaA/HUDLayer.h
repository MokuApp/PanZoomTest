//
//  HUDLayer.h
//  CookItemBetaA
//
//  Created by tedant on 12/05/06.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class GameScene;

enum menuTags
{
	kMenuTag,
};

@interface HUDLayer : CCLayer {
    BOOL _call;
    
}

-(BOOL)isCall;
-(void)showMenuList:(CGPoint)pos;
-(void)hideMenuList:(id)sender;

@end
