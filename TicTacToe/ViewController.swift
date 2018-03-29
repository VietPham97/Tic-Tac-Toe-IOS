import UIKit

class ViewController: UIViewController
{
    var activeGame = true
    var activePlayer = 1 // 1 is nought, 2 is crosses
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0] // 0 - empty, 1 - noughts, 2 - crosses
    
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], // horizontal
                               [0, 3, 6], [1, 4, 7], [2, 5, 8], // vertical
                               [0, 4, 8], [2, 4, 6]]            // diagonal
   
    @IBOutlet var playAgainButton: UIButton!
    @IBOutlet var winnerLabel: UILabel!
    
    @IBAction func playAgain(_ sender: UIButton)
    {
        activeGame = true
        activePlayer = 1
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        for i in 1..<10
        {
            if let button = view.viewWithTag(i) as? UIButton
            {
                button.setImage(nil, for: [])
            }
            
            hideWinnerLabel()
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton)
    {
        let activePosition = sender.tag - 1
        
        if gameState[activePosition] == 0 && activeGame
        {
            gameState[activePosition] = activePlayer
            
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
            }
            
            for combination in winningCombinations
            {
                if gameState[combination[0]] != 0
                {
                    if gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]
                    {
                        // we have a winner
                        activeGame = false
                        winnerLabel.isHidden = false
                        playAgainButton.isHidden = false
                        
                        winnerLabel.text = gameState[combination[0]] == 1 ? "Noughts has won!" : "Crosses has won!"
                        
                        UIView.animate(withDuration: 1, animations: {
                            self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                            self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x + 500, y: self.playAgainButton.center.y)
                        })
                    }
                }
            }
        }
        
        //print(sender.tag)
    }
    
    func hideWinnerLabel()
    {
        winnerLabel.isHidden = true
        playAgainButton.isHidden = true
        
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideWinnerLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

