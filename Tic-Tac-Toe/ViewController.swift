//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Shahzod Ashirov on 2/25/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var xobtns: [UIButton]!
    @IBOutlet weak var currentPlayerLbl: UILabel!
    @IBOutlet weak var restartBtn: UIButton!
    
    
    var fps: String = "X" // First Player Sign
    var sps: String = "O" /// Second Player Sign
    
    var isFirstPlayer: Bool = true
    
    
    var winners: [[Int]] = [
        [0,1,2], [3,4,5], [6,7,8],
        [0,4,8], [0,3,6], [1,4,7],
        [2,5,8], [2,4,6]
    ]
    
    var fpp: [Int] = [] //First Player Picks
    var spp: [Int] = [] //Second Player Picks
    
    var supperWinners: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for btn in xobtns {
            btn.setTitle(nil, for: .normal)
        }
        
        
        
        
    }
    
    
    
    @IBAction func btnsPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        if isFirstPlayer {
            fpp.append(sender.tag)
        } else {
            spp.append(sender.tag)
        }
        
        print("First Player: ",fpp)
        print("Second Player: ",spp)
        
        isFirstPlayer ? sender.setTitle(fps, for: .normal) : sender.setTitle(sps, for: .normal)
        isFirstPlayer = !isFirstPlayer
        
        currentPlayerLbl.text = isFirstPlayer ? "Player 1" : "Player 2"
        
        
        // Kallani ishlatish vaqti keldi
        
        if fpp.count >= 3 || spp.count >= 3 {
            // Biz javoblarni tekshirishni boshlaymiz
            
            if isThisCombinationWinner(combination: fpp) {
                // FIRST PLAYER WON
                for b in xobtns {
                    b.isEnabled = false
                }
                currentPlayerLbl.text = "X won!"
                
                for btn in xobtns {
                    if supperWinners.contains(btn.tag) {
                        //Animatsiya qilamiz
                        UIView.animate(withDuration: 3) {
                            btn.transform = .init(scaleX: 2, y: 2)
                        } completion: { (_) in
                            UIView.animate(withDuration: 3) {
                                btn.transform = .identity
                            }
                        }
                        
                    } else {
                        btn.setTitle(nil, for: .normal)
                    }
                }
                
                
                return
            }
            
            if isThisCombinationWinner(combination: spp) {
                // SECOND PLAYER WON
                for b in xobtns {
                    b.isEnabled = false
                }
                currentPlayerLbl.text = "O won!"
                for btn in xobtns {
                    if supperWinners.contains(btn.tag) {
                        //Animatsiya qilamiz
                        UIView.animate(withDuration: 3) {
                            btn.transform = .init(scaleX: 2, y: 2)
                        } completion: { (_) in
                            btn.transform = .identity
                        }
                        
                    } else {
                        btn.setTitle(nil, for: .normal)
                    }
                }
                
                
                return
            }
            
            if (fpp+spp).count == 9 {
                currentPlayerLbl.text = "TIE 😎"
            }
            
            
            
            
            
        }

        
//        if isFirstPlayer {
////            sender.setTitle(fps, for: .normal)
//            isFirstPlayer = false
//        } else {
//            sender.setTitle(sps, for: .normal)
////            isFirstPlayer = true
//        }
    }
    

    @IBAction func restartBtnPressed(_ sender: UIButton) {
        for btn in xobtns {
            btn.setTitle(nil, for: .normal)
            btn.isEnabled = true
        }
        isFirstPlayer = true
        currentPlayerLbl.text = "Player 1"
        
        fpp.removeAll()
        spp.removeAll()
        supperWinners.removeAll()
    }
    
    
    
    
    func isThisCombinationWinner(combination: [Int]) -> Bool {
        if winners.contains(combination) {
            return true
        }
        
        for winner in winners {
            var arr: [Int] = []
            for w in winner where combination.contains(w) {
                arr.append(w)
            }
            
            if arr.count == 3 {
                supperWinners = arr
                return true
            }
            
            supperWinners = []
        }
        return false
    }
    
    
    
}

