import Foundation
import SpriteKit

class GameOverScene: SKScene {
    var player: Player = Player.sharedInstance
    let background = SKSpriteNode(imageNamed: "EarthDefenderYouLoseScene")
    let monstersKilledLabel: SKLabelNode = SKLabelNode()
    let completedLevelsLabel: SKLabelNode = SKLabelNode()
    
    var level: Int
    
    init(size: CGSize, level: Int) {
        self.level = level
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1
        background.xScale = 0.80
        background.yScale = 1.05
        
        level -= 1
        
        monstersKilledLabel.position = CGPoint(x: 155, y: 100)
        monstersKilledLabel.zPosition = 100
        monstersKilledLabel.text = "You Killed \(player.totalMonstersKilled) monsters"
        monstersKilledLabel.fontColor = UIColor.blue
        monstersKilledLabel.fontSize = 25
        monstersKilledLabel.fontName = "AmericanTypewriter"
        
        completedLevelsLabel.position = CGPoint(x: 155, y: 60)
        completedLevelsLabel.zPosition = 100
        completedLevelsLabel.text = "You completed Level \(level)"
        completedLevelsLabel.fontColor = UIColor.green
        completedLevelsLabel.fontSize = 25
        completedLevelsLabel.fontName = "AmericanTypewriter"
        
        addChild(completedLevelsLabel)
        addChild(monstersKilledLabel)
        addChild(background)
        
        func fireWork(position: CGPoint) {
            if let particles = SKEmitterNode(fileNamed: "FireWork.sks") {
                particles.position = position
                particles.zPosition = background.zPosition + 1
                addChild(particles)
            }
        }
    }
}
//    init(size: CGSize, won:Bool) {
//        
//        super.init(size: size)
//        
//        // 1
//        backgroundColor = SKColor.white
//        
//        // 2
//        let message = won ? "You Won!" : "You Lose :["
//        
//        // 3
//        let label = SKLabelNode(fontNamed: "Chalkduster")
//        label.text = message
//        label.fontSize = 40
//        label.fontColor = SKColor.black
//        label.position = CGPoint(x: size.width/2, y: size.height/2)
//        addChild(label)
//        
//        // 4
//        run(SKAction.sequence([
//            SKAction.wait(forDuration: 3.0),
//            SKAction.run() {
//                // 5
//                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
//                let scene = GameScene(size: size)
//                self.view?.presentScene(scene, transition:reveal)
//            }
//            ]))
//        
//    }
//    
//    // 6
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

