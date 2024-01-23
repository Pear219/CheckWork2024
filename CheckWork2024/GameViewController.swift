//
//  GameViewController.swift
//  CheckWork2024
//
//  Created by Emily Nozaki on 2024/01/16.
//

import UIKit

class GameViewController: UIViewController {
    
    var emojiButton: UIButton!
    var timer: Timer?
    var timeLeft = 0
    var countdownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame() //ゲーム開始時
        setupCountdownLabel()
    }
    
    //カウント
        var count :Int = 0
        var countLabel: UILabel!
    
    func setupGame() {
        timeLeft = 30
        emojiButton = UIButton(frame: CGRect(x: 100, y: 100, width: 60, height: 60))
        emojiButton.setImage((UIImage(named:"もぐら")), for: .normal)
        emojiButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        emojiButton.addTarget(self, action: #selector(emojiTapped), for: .touchUpInside)
        view.addSubview(emojiButton)
        emojiButton.isHidden = false
        
        countLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 20, height: 20))
                countLabel.text = String(count)
                view.addSubview(countLabel)
        
        startTimer()
    }
    
    func setupCountdownLabel() {
            countdownLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 100, height: 30))
            countdownLabel.textColor = .black
            countdownLabel.font = UIFont.systemFont(ofSize: 20)
            view.addSubview(countdownLabel)
            updateCountdownLabel()
        }
    
    func updateCountdownLabel() {
            countdownLabel.text = "\(timeLeft)"
        }

    
    @objc func emojiTapped() {
        
        count += 1
        countLabel.text = String(count)
        
//      emojiButton.removeFromSuperview() //superviewから消してるだけ
        emojiButton.isHidden = true

        // 0.5秒から1.2秒のランダムな秒数を生成
        let randomDelay = Double.random(in: 0.5...1.2)

        // ランダムな秒数だけ待機
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
            self.placeEmojiRandomly()
            self.emojiButton.isHidden = false
            // 待機後に実行されるコード
        }
    }
    
    func placeEmojiRandomly() {
        let x = Int.random(in: 0...Int(view.bounds.width - 60))
        let y = Int.random(in: 0...Int(view.bounds.height - 60))
        emojiButton.frame = CGRect(x: x, y: y, width: 60, height: 60)
//        view.addSubview(emojiButton) //superviewを表示させる
    }

    func tapButton() {
            }
    
    func startTimer() { //タイマー
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeLeft -= 1
            self.updateCountdownLabel()
            if self.timeLeft <= 0 {
                timer.invalidate()
                self.gameOver()
            }
        }
    }
    
    func gameOver() { //制限時間終了時
        emojiButton.removeFromSuperview()
        
        //得点
                countLabel.frame = CGRect(x: 135, y: 270, width: 200, height: 200)
                countLabel.font = UIFont.systemFont(ofSize: 200.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.dismiss(animated: true, completion: nil)
            }
        
    }
    
}
