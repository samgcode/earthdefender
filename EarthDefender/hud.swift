//
//  hud.swift
//  spritekitsimplegame
//
//  Created by Kids on 2017-03-05.
//  Copyright © 2017 kinguine anamations. All rights reserved.
//

import Foundation
import SpriteKit

class hud: SKNode {
    
    private let _player: Player
    private var _numberOfMonsters: Int
    private let _monstersLeftLabel: SKLabelNode
    private let _livesLabel: SKLabelNode
    private var _isBossLevel: Bool
    
    init(player: Player, numberOfMonsters: Int, BossLevel: Bool){
        self._player = player
        self._numberOfMonsters = numberOfMonsters
        self._isBossLevel = BossLevel
        
        let labelTextSize = CGFloat(23)
        
        _livesLabel = SKLabelNode()
        _livesLabel.fontColor = UIColor.red
        _livesLabel.fontSize = labelTextSize
        _livesLabel.fontName = "AmericanTypewriter"
        
        _monstersLeftLabel = SKLabelNode()
        _monstersLeftLabel.fontColor = UIColor.green
        _monstersLeftLabel.fontSize = labelTextSize
        _monstersLeftLabel.fontName = "AmericanTypewriter"
        
        super.init()
        
        self.updateLivesLabel(livesLeft: _player.lives)
        self.updateMonstersLabel(monstersLeft: _numberOfMonsters)
    }
    
    convenience init(inViewSize: CGSize, withPlayer: Player, numberOfMonsters: Int, isBossLevel: Bool) {
        self.init(player: withPlayer, numberOfMonsters: numberOfMonsters, BossLevel: isBossLevel)
        self.position = CGPoint(x: 0, y: 0)
        
        let hudBackground = SKShapeNode(rectOf: CGSize(width: 1000, height: 70))
        let hudYPosition = hudBackground.frame.size.height / 2.3

        hudBackground.fillColor = SKColor.white
        hudBackground.position = CGPoint(x: 0, y: inViewSize.height - hudYPosition)
        
        let labelYPosition = inViewSize.height - 50
        _livesLabel.position = CGPoint(x: inViewSize.width * 0.2, y: labelYPosition)
        _monstersLeftLabel.position = CGPoint(x: inViewSize.width * 0.7, y: labelYPosition)
        
        self.addChild(hudBackground)
        self.addChild(_livesLabel)
        self.addChild(_monstersLeftLabel)
    }
    
    private func updateMonstersLabel(monstersLeft: Int){
        if _isBossLevel == false{
            _monstersLeftLabel.text = "asteroids left: \(monstersLeft)"
        } else {
            _monstersLeftLabel.text = "boss health: \(monstersLeft)"
        }
    }
    
    private func updateLivesLabel(livesLeft: Int){
        _livesLabel.text = "lives: \(livesLeft)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func looseLife() {
        _player.decrementLives()
        updateLivesLabel(livesLeft: _player.lives)
    }
    
    func killedMonster() {
        _numberOfMonsters = _numberOfMonsters - 1
        _player.incrementMonsterCount()
        updateMonstersLabel(monstersLeft: _numberOfMonsters)
    }
    
    func currentNumberOfMonsters() -> Int {
        return _numberOfMonsters
    }

}












