import Foundation
import SpriteKit

class GameOverScene: SKScene {
    var gameOverService: GameOverService = GameOverService.sharedInstance
    let background = SKSpriteNode(imageNamed: "earthDefenderbackground")
    let monstersKilledLabel: SKLabelNode = SKLabelNode()
    let completedLevelsLabel: SKLabelNode = SKLabelNode()
    let tapToStartLabel: SKLabelNode = SKLabelNode()
    let youLoseLabel: SKLabelNode = SKLabelNode()
    var currentLevel: Int
    let monstersKilled: Int
    
    init(size: CGSize, currentLevel: Int, monstersKilled: Int) {
        self.currentLevel = currentLevel
        self.monstersKilled = monstersKilled
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: 125, y: 290)
        background.zPosition = 1
        background.xScale = 0.85
        background.yScale = 1.05
        
        monstersKilledLabel.position = CGPoint(x: 155, y: 170)
        monstersKilledLabel.zPosition = 100
        monstersKilledLabel.text = "Monsters Killed: \(monstersKilled)"
        monstersKilledLabel.fontColor = UIColor.blue
        monstersKilledLabel.fontSize = 25
        monstersKilledLabel.fontName = "AmericanTypewriter"
        
        completedLevelsLabel.position = CGPoint(x: 155, y: 130)
        completedLevelsLabel.zPosition = 100
        completedLevelsLabel.text = "Levels completed \(currentLevel - 1)"
        completedLevelsLabel.fontColor = UIColor.green
        completedLevelsLabel.fontSize = 25
        completedLevelsLabel.fontName = "AmericanTypewriter"
        
        youLoseLabel.position = CGPoint(x: 155, y: 220)
        youLoseLabel.zPosition = 100
        youLoseLabel.text = "You Lose"
        youLoseLabel.fontColor = UIColor.red
        youLoseLabel.fontSize = 70
        youLoseLabel.fontName = "AmericanTypewriter"
        
        tapToStartLabel.position = CGPoint(x: 155, y: 60)
        tapToStartLabel.zPosition = 100
        tapToStartLabel.text = "Tap to restart"
        tapToStartLabel.fontColor = UIColor.red
        tapToStartLabel.fontSize = 25
        tapToStartLabel.fontName = "AmericanTypewriter"
        
        addChild(youLoseLabel)
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
        gameOverService.resetCouters()
        showLevel()
    }
    
    func showLevel() {
        let levelService: LevelService = LevelService.sharedInstance
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameScene = levelService.loadNextLevel(size: size)
        self.view?.presentScene(gameScene, transition: reveal)
    }
}
