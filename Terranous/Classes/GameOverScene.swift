//
//  GameOverSCcene.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    // MARK: - Private class properties
    private var gameOverSceneNode = SKNode()
    private var scoreBoard = ScoreBoard()
    
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    convenience init(size: CGSize, stars: Int, score: Int) {
        self.init(size: size)
        
        self.setupGameOverScene(stars, score: score)
    }
    
    override func didMoveToView(view: SKView) {
        if GameSettings.sharedInstance.getMusicEnabled() {
            GameAudio.sharedInstance.playBackgroundMusic(Music.Menu)
        }
    }
    
    // MARK: - Setup Functions
    private func setupGameOverScene(stars: Int, score: Int) {
        self.backgroundColor = SKColorFromRGB(Colors.Background)
        
        self.addChild(self.gameOverSceneNode)
        
        let background = Background()
        self.gameOverSceneNode.addChild(background)
        
        self.scoreBoard = ScoreBoard(stars: stars, score: score)
        self.gameOverSceneNode.addChild(self.scoreBoard)
    }
    
    // MARK: - Touch Events
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch:UITouch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        if self.scoreBoard.retryButton.containsPoint(touchLocation) {
            self.scoreBoard.retryButton.tappedRetry()
            self.retryGame()
        }
        
        if self.scoreBoard.settingsButton.containsPoint(touchLocation) {
            self.scoreBoard.settingsButton.tappedSettingsButton()
            
            let settingsOverlay = SettingsOverlay()
            self.gameOverSceneNode.addChild(settingsOverlay)
        }
    }
    
    // MARK: - Actions Functions
    private func retryGame() {
        let scene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
        
        self.view?.presentScene(scene, transition: transition)
    }
}