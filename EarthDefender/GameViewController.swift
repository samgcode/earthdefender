import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let levelService: LevelService = LevelService.sharedInstance
        
        let scene = levelService.loadTitleScene(size: view.bounds.size)
        
        let skView = view as! SKView
        var showDebugInfo = false
        #if DEBUG
            showDebugInfo = true
        #endif
        skView.showsFPS = showDebugInfo
        skView.showsNodeCount = showDebugInfo
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
