import Foundation
import SpriteKit

class GameOverScene: SKScene {
    var player: Player = Player.sharedInstance
    let background = SKSpriteNode(imageNamed: "EarthDefenderYouLoseScene")
    let monstersKilledLabel: SKLabelNode = SKLabelNode()
    let completedLevelsLabel: SKLabelNode = SKLabelNode()
    let tapToStartLabel: SKLabelNode = SKLabelNode()
    
    
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
        
        monstersKilledLabel.position = CGPoint(x: 155, y: 170)
        monstersKilledLabel.zPosition = 100
        monstersKilledLabel.text = "You Killed \(player.totalMonstersKilled) monsters"
        monstersKilledLabel.fontColor = UIColor.blue
        monstersKilledLabel.fontSize = 25
        monstersKilledLabel.fontName = "AmericanTypewriter"
        
        completedLevelsLabel.position = CGPoint(x: 155, y: 130)
        completedLevelsLabel.zPosition = 100
        completedLevelsLabel.text = "You completed Level \(level)"
        completedLevelsLabel.fontColor = UIColor.green
        completedLevelsLabel.fontSize = 25
        completedLevelsLabel.fontName = "AmericanTypewriter"
        
        tapToStartLabel.position = CGPoint(x: 155, y: 60)
        tapToStartLabel.zPosition = 100
        tapToStartLabel.text = "Tap to restart"
        tapToStartLabel.fontColor = UIColor.red
        tapToStartLabel.fontSize = 25
        tapToStartLabel.fontName = "AmericanTypewriter"
        
        addChild(tapToStartLabel)
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        showLevel()
    }
    
    func showLevel() {
                let levelService: LevelService = LevelService.sharedInstance
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = levelService.loadNextLevel(size: size)
                self.view?.presentScene(gameScene, transition: reveal)
        }
}
