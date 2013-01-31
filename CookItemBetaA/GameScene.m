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

@synthesize items;

static GameScene* instanceOfGameScene = nil;

+(GameScene*)sharedGameScene
{
/*
    NSAssert(instanceOfGameScene != nil, @"GameScen instance not yet initialized");
    return instanceOfGameScene;
*/
    if (instanceOfGameScene == nil) {
        instanceOfGameScene = [GameScene alloc];
        [instanceOfGameScene init];
    }
    
    return instanceOfGameScene;
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
//	HUDLayer *hud = [HUDLayer node];
 //   [scene addChild:hud z:10];
    
 //   GameScene *layer = [[[GameScene alloc] initWithHUD:hud] autorelease];
    GameScene* layer = [GameScene node];
    
	[scene addChild: layer];
    
	return scene;
}

//-(id) initWithHUD:(HUDLayer*)hud
-(id) init
{
	if( (self=[super init])) {
        instanceOfGameScene = self;
        _hud = [HUDLayer node];
        [self addChild:_hud z:10];
        
        
        _panZoomLayer = [[CCLayerPanZoom node] retain];
        [self addChild:_panZoomLayer z:0 tag:kPanzoomTag];
        _panZoomLayer.delegate = self;
        
        
        CCSprite *background = [CCSprite spriteWithFile: @"CookingScene.png"];
        background.anchorPoint = ccp(0,0);

        [_panZoomLayer addChild: background 
                             z :0 
                            tag: BG_TAG];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGRect boundingRect = CGRectMake(0, 0, 0, 0);
        boundingRect.size = CGSizeMake(1024, 768);
        [_panZoomLayer setContentSize:boundingRect.size];
        
        _panZoomLayer.anchorPoint = ccp(0.5f, 0.5f);
        _panZoomLayer.position = ccp(0.5f * winSize.width, 0.5f * winSize.height);
        
        _panZoomLayer.panBoundsRect = CGRectMake(0, 0, winSize.width, winSize.height);
        
        
        
        _panZoomLayer.minScale = 0.5f;
        _panZoomLayer.maxScale = 1.0f;
        
        self.items = [NSArray arrayWithObjects:[Garlic initItem:[[Cut alloc ]init]],[Knife initItem:[[Command alloc] init]], nil];
        
        for (Item* tmpItem in self.items) {
            [_panZoomLayer addChild:tmpItem z:1 tag:tmpItem.tag];
            tmpItem.position =  ccp(boundingRect.size.width * 0.2f, boundingRect.size.height * 0.5f + 220);
        }
        
    
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
    

    for (Item* tmpItem in self.items) {
        if (CGRectContainsPoint([tmpItem boundingBox], point)) {
            _selectedObject = tmpItem;
            _selectedObject.color = ccBLUE;
        }else{
            tmpItem.color = ccWHITE;
        }

    }
        
}

-(void) droppedObjectRect: (CGRect) rect
{
    _droppedObject = nil;
    

    for (Item* tmpItem in self.items) {
        if ( !(_selectedObject == tmpItem) && CGRectIntersectsRect( [tmpItem boundingBox], rect)) {
            _droppedObject = tmpItem;
            _droppedObject.color = ccRED;
        }else{
            tmpItem.color = ccWHITE;
        }
    }
    
    
}

-(void)handleInitialTouch:(CGPoint)p{
    CGPoint pointHandle = [self convertToNodeSpace: [_panZoomLayer convertToWorldSpace: p] ];
    [_hud handleInitialTouch:pointHandle];
    
}

#pragma mark CCLayerPanZoom Delegate Methods

- (void) layerPanZoom: (CCLayerPanZoom *) sender 
 touchPositionUpdated: (CGPoint) newPos
{
    
    _selectedObject.position = newPos;
    [self droppedObjectRect:[_selectedObject boundingBox]];
    if (_droppedObject) {
        if (!_hud.isCall) {
            
            
            [_hud showMenuList:_selectedObject dropped:_droppedObject];
        }
    }
    else{
        [_hud hideMenuList];
    }
}

- (void) layerPanZoom: (CCLayerPanZoom *) sender 
	   clickedAtPoint: (CGPoint) point
             tapCount: (NSUInteger) tapCount
{

    [self handleInitialTouch:point];
    [self selectObjectAtPoint: point];
}

- (void) layerPanZoom: (CCLayerPanZoom *) sender touchMoveBeganAtPosition: (CGPoint) aPoint 
{


    [self handleInitialTouch:aPoint];
    
    
    [self selectObjectAtPoint: aPoint];
    
    CCLOG(@"selected obj? %@",_selectedObject);
    
    

    
    // Change anchorPoint & position of selectedTestObject to avoid jerky movement.
    if (_selectedObject)
    {
        sender.selectObject = YES;
        CGFloat width = _selectedObject.contentSize.width;
        CGFloat height = _selectedObject.contentSize.height;
        
        CGPoint aPointInTestObjectCoordinates = [ _selectedObject convertToNodeSpace: [_panZoomLayer convertToWorldSpace: aPoint] ];
        CGPoint anchorPointInPoints = ccp( _selectedObject.anchorPoint.x * width, 
                                          _selectedObject.anchorPoint.y * height );
        CGPoint anchorShift = ccpSub(anchorPointInPoints, aPointInTestObjectCoordinates );
        _selectedObject.anchorPoint = ccp( (anchorPointInPoints.x - anchorShift.x )/ width, 
                                              (anchorPointInPoints.y - anchorShift.y) / height );
        _selectedObject.position = aPoint;
        

    }else{
        sender.selectObject = NO;         
    }

}



        

@end
