import Foundation
import SpriteKit

class GameOverScene: SKScene {
    var font = ThemeService.getfont()
    var gameOverService: GameOverService = GameOverService.sharedInstance
    var player: Player = Player.sharedInstance
    let monstersKilledLabel: SKLabelNode = SKLabelNode()
    let completedLevelsLabel: SKLabelNode = SKLabelNode()
    let tapToStartLabel: SKLabelNode = SKLabelNode()
    let youLoseLabel: SKLabelNode = SKLabelNode()
    var currentLevel: Int
    let monstersKilled: Int
    var shotsFired: SKLabelNode = SKLabelNode()
    var scoreLabel: SKLabelNode = SKLabelNode()
    
    init(size: CGSize, currentLevel: Int, monstersKilled: Int) {
        self.currentLevel = currentLevel
        self.monstersKilled = monstersKilled
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let backgroundImage = FileNameRetriever.imageFileName(fileName: "GameOver")
        let background = SKSpriteNode(imageNamed: backgroundImage)
        background.aspectFillToSize(fillSize: (self.view?.frame.size)!)
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 1
        
        scoreLabel.text = "Score: \(player.score)"
        scoreLabel.zPosition = 100
        scoreLabel.position = CGPoint(x: 165, y: 100)
        scoreLabel.fontColor = UIColor.blue
        scoreLabel.fontSize = 30
        scoreLabel.fontName = font
        
        shotsFired.text = "Shots fired: \(player._shotsFired)"
        shotsFired.zPosition = 100
        shotsFired.position = CGPoint(x: 165, y: 200)
        shotsFired.fontColor = UIColor.cyan
        shotsFired.fontSize = 25
        shotsFired.fontName = font
        
        monstersKilledLabel.position = CGPoint(x: 155, y: 170)
        monstersKilledLabel.zPosition = 100
        monstersKilledLabel.text = "Enemys Killed: \(monstersKilled)"
        monstersKilledLabel.fontColor = UIColor.blue
        monstersKilledLabel.fontSize = 25
        monstersKilledLabel.fontName = font
        
        completedLevelsLabel.position = CGPoint(x: 155, y: 130)
        completedLevelsLabel.zPosition = 100
        completedLevelsLabel.text = "Levels completed \(currentLevel - 1)"
        completedLevelsLabel.fontColor = UIColor.green
        completedLevelsLabel.fontSize = 25
        completedLevelsLabel.fontName = font
        
        youLoseLabel.position = CGPoint(x: 165, y: 300)
        youLoseLabel.zPosition = 100
        youLoseLabel.text = "You Lose"
        youLoseLabel.fontColor = UIColor.red
        youLoseLabel.fontSize = 70
        youLoseLabel.fontName = font
        
        tapToStartLabel.position = CGPoint(x: 155, y: 60)
        tapToStartLabel.zPosition = 100
        tapToStartLabel.text = "Tap to restart"
        tapToStartLabel.fontColor = UIColor.red
        tapToStartLabel.fontSize = 25
        tapToStartLabel.fontName = font
        
        addChild(scoreLabel)
        addChild(shotsFired)
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
