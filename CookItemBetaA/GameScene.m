//
//  GameScene.m
//  CookItemBetaA
//
//  Created by tedant on 12/05/05.
//  Copyright 2012 MokuApp. All rights reserved.
//

#import "GameScene.h"
#import "HUDLayer.h"


@implementation GameScene

static GameScene* instanceOfGameScene;

+(GameScene*)sharedGameScene
{
    NSAssert(instanceOfGameScene != nil, @"GameScen instance not yet initialized");
    return instanceOfGameScene;

}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HUDLayer *hud = [HUDLayer node];
    [scene addChild:hud z:10];
    
    GameScene *layer = [[[GameScene alloc] initWithHUD:hud] autorelease];
	[scene addChild: layer];
    
	return scene;
}

-(id) initWithHUD:(HUDLayer*)hud
{
	if( (self=[super init])) {
        instanceOfGameScene = self;
        _hud = hud;

        CCLayerColor* whiteLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild:whiteLayer z:-1];
	
        _panZoomLayer = [[CCLayerPanZoom node] retain];
        [self addChild:_panZoomLayer z:0 tag:kPanzoomTag];
        _panZoomLayer.delegate = self;
        
        
        CCSprite *garlic = [CCSprite spriteWithFile: @"garlic.png"];
		[_panZoomLayer addChild: garlic 
                              z: 1 
                            tag: kGarlicTag];
        
        CCSprite *knife = [CCSprite spriteWithFile: @"knife.png"];
		[_panZoomLayer addChild: knife 
                              z: 1 
                            tag: kKnifeTag];
        _selectedObject = garlic;
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGRect boundingRect = CGRectMake(0, 0, 0, 0);
        boundingRect.size = winSize;
        [_panZoomLayer setContentSize:boundingRect.size];
        
        _panZoomLayer.anchorPoint = ccp(0.5f, 0.5f);
        _panZoomLayer.position = ccp(0.5f * winSize.width, 0.5f * winSize.height);
        
        _panZoomLayer.panBoundsRect = CGRectMake(0, 0, winSize.width, winSize.height);
        
        
        garlic.position =  ccp(boundingRect.size.width * 0.7f, boundingRect.size.height * 0.5f - 56);
        knife.position =  ccp(boundingRect.size.width * 0.4f, boundingRect.size.height * 0.5f - 56);
        
        
        _panZoomLayer.minScale = 1.0f;// * winSize.width;
        _panZoomLayer.maxScale = 2.0f;// * winSize.width;
    
    
    }
    
	return self;
}

- (void) onEnter
{
    [super onEnter];
    _panZoomLayer.mode = kCCLayerPanZoomModeFrame;
}

- (void) onExit
{
    _selectedObject = nil;
    _droppedObject = nil;
    [super onExit];
}


- (void) selectObjectAtPoint: (CGPoint) point
{
    _selectedObject = nil;
    
    CCSprite *_garlic = (CCSprite *)[_panZoomLayer getChildByTag: kGarlicTag];
    CCSprite *_knife = (CCSprite *)[_panZoomLayer getChildByTag: kKnifeTag];
    
    
    // Select new test object.
    if ( CGRectContainsPoint( [_garlic boundingBox], point))
    {
        _selectedObject = _garlic;
    }
    
    if ( CGRectContainsPoint( [_knife boundingBox], point))
    {
        _selectedObject = _knife;
    }
    
    _garlic.color = ccWHITE;
    _knife.color = ccWHITE;
    _selectedObject.color = ccRED;
        
}

-(void) droppedObjectAtPoint: (CGRect) rect
{
    _droppedObject = nil;
    
    CCSprite *_knife = (CCSprite *)[_panZoomLayer getChildByTag: kKnifeTag];
    
    if ( CGRectIntersectsRect( [_knife boundingBox], rect))
    {
        _droppedObject = _knife;
    }
    
    _knife.color = ccWHITE;
    _droppedObject.color = ccBLUE;
    
}

#pragma mark CCLayerPanZoom Delegate Methods

- (void) layerPanZoom: (CCLayerPanZoom *) sender 
 touchPositionUpdated: (CGPoint) newPos
{
    
    _selectedObject.position = newPos;
    [self droppedObjectAtPoint:[_selectedObject boundingBox]];
    if (_droppedObject) {
        if (![_hud isCall]) {
            CCSprite *_knife = (CCSprite *)[_panZoomLayer getChildByTag: kKnifeTag];
            [_hud showMenuList:_knife.position];            
        }

    }

}

- (void) layerPanZoom: (CCLayerPanZoom *) sender 
	   clickedAtPoint: (CGPoint) point
             tapCount: (NSUInteger) tapCount
{
    [self selectObjectAtPoint: point];
//    [self droppedObjectAtPoint:[_selectedObject boundingBox]];
}

- (void) layerPanZoom: (CCLayerPanZoom *) sender touchMoveBeganAtPosition: (CGPoint) aPoint
{
    
    [self selectObjectAtPoint: aPoint];
    
    // Change anchorPoint & position of selectedTestObject to avoid jerky movement.
    if (_selectedObject)
    {
        CGFloat width = _selectedObject.contentSize.width;
        CGFloat height = _selectedObject.contentSize.height;
        
        CGPoint aPointInTestObjectCoordinates = [ _selectedObject convertToNodeSpace: [_panZoomLayer convertToWorldSpace: aPoint] ];
        CGPoint anchorPointInPoints = ccp( _selectedObject.anchorPoint.x * width, 
                                          _selectedObject.anchorPoint.y * height );
        CGPoint anchorShift = ccpSub(anchorPointInPoints, aPointInTestObjectCoordinates );
        _selectedObject.anchorPoint = ccp( (anchorPointInPoints.x - anchorShift.x )/ width, 
                                              (anchorPointInPoints.y - anchorShift.y) / height );
        _selectedObject.position = aPoint;
        
        
    }
//    [self droppedObjectAtPoint:[_selectedObject boundingBox]];
}



        

@end
