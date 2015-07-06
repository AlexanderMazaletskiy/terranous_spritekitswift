//
//  MenuScene.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    // MARK: - Private class properties
    private let menuSceneNode = SKNode()
    private let settingsNode = SKNode()
    private var startButton = SKSpriteNode()
    private var title = TitleOverlay()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        if GameSettings.sharedInstance.getMusicEnabled() {
            GameAudio.sharedInstance.playBackgroundMusic(Music.Menu)
        }
        
        self.setupMenuScene()
    }
    
    // MARK: - Setup
    private func setupMenuScene() {
        self.backgroundColor = SKColorFromRGB(Colors.Background)
        
        self.addChild(self.menuSceneNode)
        
        let background = Background()
        self.menuSceneNode.addChild(background)
        
        self.title = TitleOverlay()
        self.menuSceneNode.addChild(self.title)
        
        self.addChild(self.settingsNode)
    }
    
    // MARK: - Touch Events
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch:UITouch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        if self.title.startButton.containsPoint(touchLocation) {
            self.loadGameScene()
        }
        
        if self.title.settingsButton.containsPoint(touchLocation) {
            self.title.settingsButton.tappedSettingsButton()
            
            let settingsOverlay = SettingsOverlay()
            self.settingsNode.addChild(settingsOverlay)
        }
    }
    
    // MARK: - Switch Scenes
    private func loadGameScene() {
        self.runAction(GameAudio.sharedInstance.soundPop, completion: {
            let gameScene = GameScene(size: kViewSize)
            gameScene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.view?.presentScene(gameScene)
        })
    }
}