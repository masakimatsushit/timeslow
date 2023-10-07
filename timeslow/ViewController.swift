//
//  ViewController.swift
//  timeslow
//
//  Created by matsushitamasaki on 2023/09/13.
//

import UIKit
import CoreHaptics

class ViewController: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate{
    
    @IBOutlet weak var scoreInt: UILabel!
    
    @IBOutlet weak var hatenaka: UIButton!
    
    @IBAction func hatenaButton(_ sender: Any) {
        
        //アラート生成
        
        //UIAlertControllerのスタイルがalert
        let alert: UIAlertController = UIAlertController(title: "画面をリズムに合わせてタップして下さい。STARTから4秒後に無音になり測定が始まるのでタップし続けて下さい。無音になってから8回のタップで測定完了し点数が表示されます。画面上ならどこをタップしてもカウントされます。リズム感の測定はタップとタップの間隔がどれだけ指定したBPMの間隔と一致しているかで判定されます。", message:  "", preferredStyle:  UIAlertController.Style.alert)
        // 確定ボタンの処理
        let confirmAction: UIAlertAction = UIAlertAction(title: "✔️", style: UIAlertAction.Style.default, handler:{
            // 確定ボタンが押された時の処理をクロージャ実装する
            (action: UIAlertAction!) -> Void in
            //実際の処理
            print("OK")
        })
        
        //UIAlertControllerにキャンセルボタンと確定ボタンをActionを追加
        
        
        alert.addAction(confirmAction)
        
        //実際にAlertを表示する
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textField.alpha == 1{
            textField.alpha = 0
            
            self.view.endEditing(true)
            if textField.text != ""{
                
                self.bpm = Int(textField.text!)!
                
                hapticController.bpm = Double(self.bpm)
                
                bpmText.text = self.bpm.description
                
            }
        }
    }
    
    
    
    
    @IBOutlet weak var bpmText: UILabel!
    // UI表示に必要なパラメーター
     var bpm: Int = 60
     private var isPlaying: Bool = false

    @IBAction func bpmmainasu(_ sender: Any) {
        distance = 0.0
        self.bpm -= 1
        bpmText.text = self.bpm.description
        if fiveseconds == true{
            
        }else{
            
            hapticController.stop()
        }
        fiveseconds = false
            hapticController.bpm = Double(self.bpm)
        startText.setTitle("START", for: .normal)
        stopTextLabel.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        isPlaying = false
        distance = 0
        count = 0
        score = 0
        time = 0.0
        scoreInt.alpha = 0
        
        timer.invalidate()
        stopTextLabel.alpha = 0
        startText.alpha = 1
        scoreLabel.alpha = 0
        stoptrue = true
    }
    
    
    
    
    @IBAction func bpmplus(_ sender: Any) {
        distance = 0.0
        self.bpm += 1
        bpmText.text = self.bpm.description
        if fiveseconds == true{
            
        }else{
            
            hapticController.stop()
        }
        fiveseconds = false
            hapticController.bpm = Double(self.bpm)
        print(hapticController.bpm)
        startText.setTitle("START", for: .normal)
        isPlaying = false
        distance = 0
        count = 0
        score = 0
        time = 0.0
        scoreInt.alpha = 0
        
        stopTextLabel.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        timer.invalidate()
        stopTextLabel.alpha = 0
        startText.alpha = 1
        scoreLabel.alpha = 0
        stoptrue = true
    }
    
    
    @IBOutlet weak var stopTextLabel: UIButton!
    
    @IBOutlet weak var startText: UIButton!
    
    // コントローラーのインスタンス
    private var hapticController = hoge()
    
    private var time:Double = 0.0
       private var timer:Timer = Timer()
    var abc = 0
    var def = 0
    
    @IBAction func bpmStart(_ sender: Any) {
        if isPlaying == false{
            stoptrue = false
            startText.alpha = 0
            scoreLabel.alpha = 0
            hapticController.bpm = Double(self.bpm)
            hapticController.play()
            isPlaying = true
            abc += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [self] in
                print("5秒経ちました。")
                def += 1
                if abc == def{
                    if stoptrue == false{
                        fiveseconds = true
                        hapticController.stop()
                        
                        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [self] _ in
                            self.time += 0.01
                        })
                        
                    }
                }
            }
            
            stopTextLabel.alpha = 1
            
        }
    }
    var fiveseconds = false
    
    
    var count = 0
    
    var stopDate:Date!
    
    var score = 0.0
    
    var stoptrue = false
    
    
    @IBAction func stopAction(_ sender: Any) {
        if fiveseconds == true{
            
        }else{
            
            hapticController.stop()
        }
        isPlaying = false
        stoptrue = true
        fiveseconds = false
        distance = 0
        timer.invalidate()
        stopTextLabel.alpha = 0
        startText.alpha = 1
        scoreLabel.alpha = 0
        count = 0
        score = 0
        time = 0.0
        distance = 0.0
        
        
        if stopTextLabel.image(for: .normal) == UIImage(systemName: "goforward"){
            
            stopTextLabel.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            scoreInt.text = ""
        }
        
    }
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @objc    func tapped2(_ sender : UITapGestureRecognizer) {
        print("tap2")
        textField.alpha = 1
        textField.becomeFirstResponder()
        
        textField.text = self.bpm.description
        stoptrue = true
        hapticController.stop()
            hapticController.bpm = Double(self.bpm)
        startText.setTitle("START", for: .normal)
        isPlaying = false
        count = 0
        score = 0
        time = 0.0
        distance = 0
        timer.invalidate()
        stopTextLabel.alpha = 0
        startText.alpha = 1
        scoreLabel.alpha = 0
        
        
        
        
        scoreInt.alpha = 0
        
        stopTextLabel.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    
    var distance = 0.0
    
    
    
    @objc    func tapped(_ sender : UITapGestureRecognizer) {
         print("タップされたよ")
        
        
        
        
        if fiveseconds == true{
            
                count += 1
                
                if count == 1{
                    distance = self.time
                    
                }
                if count == 2{
                    let gosa:Double = self.time - distance
                    distance = self.time
                    score += abs(Double(Double(round(60/Double(self.bpm) * 10000)/10000)) - gosa)*Double(self.bpm)
        
                    
                    
                    
                }
                if count == 3{
                    
                    let gosa:Double = self.time - distance
                    distance = self.time
                    score += abs(Double(Double(round(60/Double(self.bpm) * 10000)/10000)) - gosa)*Double(self.bpm)
                  
                   
                }
                
                if count == 4{
                    let gosa:Double = self.time - distance
                    distance = self.time
                    score += abs(Double(Double(round(60/Double(self.bpm) * 10000)/10000)) - gosa)*Double(self.bpm)
        
                }
                
                if count == 5{
                    let gosa:Double = self.time - distance
                    distance = self.time
                    score += abs(Double(Double(round(60/Double(self.bpm) * 10000)/10000)) - gosa)*Double(self.bpm)
        
                  
                }
                if count == 6{
                    let gosa:Double = self.time - distance
                    distance = self.time
                    score += abs(Double(Double(round(60/Double(self.bpm) * 10000)/10000)) - gosa)*Double(self.bpm)
        
                  
                    
                }
                
                if count == 7{
                    
                    let gosa:Double = self.time - distance
                    distance = self.time
                    score += abs(Double(Double(round(60/Double(self.bpm) * 10000)/10000)) - gosa)*Double(self.bpm)
                  
                   
                }
                if count == 8{
                    
                
                    print(self.time - Double(Double(round(60/Double(self.bpm) * 10000)/10000)*8))
                    
                    let gosa:Double = self.time - distance
                    distance = self.time
                    score += abs(Double(Double(round(60/Double(self.bpm) * 10000)/10000)) - gosa)*Double(self.bpm)
        
                   
                    if 100-score > 0{
                        
                        let countscore:Int = Int(100-score)
                        
                        
                        if 100-score < 50{
                            scoreLabel.text = "これからだ！訓練で裏拍を感じよう！"
                            
                        }else if 100-score < 75{
                            scoreLabel.text = "あと少し！訓練で裏拍を感じよう！"
                        }else if 100-score < 90{
                            scoreLabel.text = "凄い、、才能あるかも！"
                        }else{
                            scoreLabel.text = "天才だ、、プロ並みのリズム感！"
                        }
                        
                        scoreInt.text = "\(countscore)点"
                    }else{
                        scoreLabel.text = "これからだ！訓練で裏拍を感じよう！"
                        scoreInt.text = "0点"
                    }
                    
                    isPlaying = false
                  fiveseconds = false
                    hapticController.stop()
                    timer.invalidate()
                    
                    stopTextLabel.setImage(UIImage(systemName: "goforward"), for: .normal)
                    count = 0
                    score = 0
                    time = 0.0
                    distance = 0.0
                    scoreLabel.alpha = 1
                    scoreInt.alpha = 1
                    
                    
                }
            
        }
     }
    
    @IBOutlet weak var backView: UIView!
    
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        hatenaka.setTitle("", for: . normal)
        stopTextLabel.setTitle("", for: .normal)
        bpmText.isUserInteractionEnabled = true
        bpmText.text = self.bpm.description
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        self.view.addGestureRecognizer(tapGesture)
        stopTextLabel.alpha = 0
        scoreLabel.alpha = 0
        print(round(60/Double(self.bpm) * 10000)/10000)
        
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(tapped2(_:)))
       bpmText.addGestureRecognizer(tapGesture2)
        
        
        backView.layer.cornerRadius = 30
        
        backView.layer.shadowColor = UIColor.black.cgColor
        
        backView.layer.shadowOffset = CGSize(width: 0, height: -1)
       backView.layer.shadowOpacity = 0.1
        backView.layer.shadowRadius = 13
        
        
        
        textField.alpha = 0
        textField.keyboardType = UIKeyboardType.numberPad
        tapGesture.delegate = self
        tapGesture2.delegate = self
        
        textField.text = self.bpm.description

        circleImage.layer.shadowColor = UIColor.black.cgColor
        
        circleImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        circleImage.layer.shadowOpacity = 0.3
        circleImage.layer.shadowRadius = 1
        
        
        
        
        
    }
    
    
    var sixyokai = 0
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        hapticController.stop()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sixyokai = UserDefaults.standard.integer(forKey: "sixyokai")
        if sixyokai == 0{
            print("お多い")
            //アラート生成
            //UIAlertControllerのスタイルがalert
            let alert: UIAlertController = UIAlertController(title: "画面をリズムに合わせてタップして下さい。STARTから4秒後に無音になり測定が始まるのでタップし続けて下さい。無音になってから8回のタップで測定完了し点数が表示されます。画面上ならどこをタップしてもカウントされます。リズム感の測定はタップとタップの間隔がどれだけ指定したBPMの間隔と一致しているかで判定されます。", message:  "", preferredStyle:  UIAlertController.Style.alert)
            // 確定ボタンの処理
            let confirmAction: UIAlertAction = UIAlertAction(title: "✔️", style: UIAlertAction.Style.default, handler:{
                // 確定ボタンが押された時の処理をクロージャ実装する
                (action: UIAlertAction!) -> Void in
                //実際の処理
                print("OK")
            })
            
            //UIAlertControllerにキャンセルボタンと確定ボタンをActionを追加
            
            
            alert.addAction(confirmAction)
            
            //実際にAlertを表示する
            present(alert, animated: true, completion: nil)
        }
        sixyokai = 1
        UserDefaults.standard.set(sixyokai, forKey: "sixyokai")
        

    }
    
    @IBOutlet weak var circleImage: UIImageView!
    

}

