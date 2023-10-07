//
//  trainingViewController.swift
//  timeslow
//
//  Created by matsushitamasaki on 2023/09/17.
//

import UIKit
import CoreHaptics

class trainingViewController: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate {

    var uraor = 0
    
    
    
    @IBAction func ordinalMusic(_ sender: Any) {
        
        
            ordinalButton.layer.borderColor = UIColor {_ in return #colorLiteral(red: 0.143012166, green: 0.143012166, blue: 0.143012166, alpha: 1)}.cgColor
            ordinalButton.setTitleColor(UIColor {_ in return #colorLiteral(red: 0.143012166, green: 0.143012166, blue: 0.143012166, alpha: 1)}, for: .normal)
            
            
           uraButton.layer.borderColor = UIColor {_ in return #colorLiteral(red: 0.5155439973, green: 0.5220336914, blue: 0.5219195485, alpha: 1)}.cgColor
            uraButton.setTitleColor(UIColor {_ in return #colorLiteral(red: 0.5155439973, green: 0.5220336914, blue: 0.5219195485, alpha: 1)}, for: .normal)
            
            uraor = 0
        hapticController.stop()
        
        
        startText2.setTitle("START", for: .normal)
        timer.invalidate()
        time = 0.0
        
        
        if isPlaying == true{
            hapticController.bpm = Double(self.bpm)
            hapticController.play()
            if uraor == 1{
                DispatchQueue.main.asyncAfter(deadline: .now() + round(60/Double(self.bpm) * 1000000000)/2000000000) {
                    self.hapticController.play2()
                }
            }
            isPlaying = true
            startText2.setTitle("STOP", for: .normal)
        }else{
            isPlaying = false
        }
        
        
    }
    
    
    
    
    @IBAction func uraMusic(_ sender: Any) {
        uraButton.layer.borderColor = UIColor {_ in return #colorLiteral(red: 0.143012166, green: 0.143012166, blue: 0.143012166, alpha: 1)}.cgColor
        uraButton.setTitleColor(UIColor {_ in return #colorLiteral(red: 0.143012166, green: 0.143012166, blue: 0.143012166, alpha: 1)}, for: .normal)
        
        
       ordinalButton.layer.borderColor = UIColor {_ in return #colorLiteral(red: 0.5155439973, green: 0.5220336914, blue: 0.5219195485, alpha: 1)}.cgColor
        ordinalButton.setTitleColor(UIColor {_ in return #colorLiteral(red: 0.5155439973, green: 0.5220336914, blue: 0.5219195485, alpha: 1)}, for: .normal)
        
        
        
        uraor = 1
        
        
        hapticController.stop()
       
        
        startText2.setTitle("START", for: .normal)
        timer.invalidate()
        time = 0.0
        
        
        if isPlaying == true{
            hapticController.bpm = Double(self.bpm)
            hapticController.play()
            if uraor == 1{
                DispatchQueue.main.asyncAfter(deadline: .now() + round(60/Double(self.bpm) * 1000000000)/2000000000) {
                    self.hapticController.play2()
                }
            }
            isPlaying = true
            startText2.setTitle("STOP", for: .normal)
        }else{
            isPlaying = false
        }
    
        
    }
    
    @IBOutlet weak var BackView: UIView!
    
    
    @IBOutlet weak var BPMText: UILabel!
    
    
    
    @IBOutlet weak var ordinalButton: UIButton!
    
    @IBOutlet weak var uraButton: UIButton!
    
    @IBOutlet weak var textField2: UITextField!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if textField2.alpha == 1{
            textField2.alpha = 0
            
            self.view.endEditing(true)
            if textField2.text != ""{
               
                self.bpm = Int(textField2.text!)!
                hapticController.bpm = Double(self.bpm)
                
              BPMText.text = self.bpm.description
           
            }
        }
       }
 
    
    
    
    // コントローラーのインスタンス
    private var hapticController = hoge()
    
     var time:Double = 0.0
       private var timer:Timer = Timer()
    
    // UI表示に必要なパラメーター
    var bpm: Int = 60
     private var isPlaying: Bool = false
    
    
    
    @IBOutlet weak var startText2: UIButton!
    
    
    @IBAction func bpmStart(_ sender: Any) {
        if isPlaying == false{
            hapticController.bpm = Double(self.bpm)
            hapticController.play()
            if uraor == 1{
                DispatchQueue.main.asyncAfter(deadline: .now() + round(60/Double(self.bpm) * 1000000000)/2000000000) {
                    self.hapticController.play2()
                }
            }
            isPlaying = true
            startText2.alpha = 0
            stopButtonyo.alpha = 1
        }
    }
    
    
    @objc    func tapped2(_ sender : UITapGestureRecognizer) {
        print("tap2")
        
        textField2.alpha = 1
        textField2.becomeFirstResponder()
        
        textField2.text = self.bpm.description
        
        hapticController.stop()
            hapticController.bpm = Double(self.bpm)
        startText2.setTitle("START", for: .normal)
        isPlaying = false
        
        time = 0.0
        
        
        
        stopButtonyo.alpha = 0
        
        startText2.alpha = 1
        
        timer.invalidate()
        
    }
    
    
    @IBAction func BPMPlus(_ sender: Any) {
        
        self.bpm += 1
        BPMText.text = self.bpm.description
        hapticController.stop()
            hapticController.bpm = Double(self.bpm)
        startText2.setTitle("START", for: .normal)
        isPlaying = false
       
        time = 0.0
        
        timer.invalidate()
        
        stopButtonyo.alpha = 0
        
        startText2.alpha = 1
        
    }
    
    
    @IBAction func BPMMainus(_ sender: Any) {
        
        self.bpm -= 1
        BPMText.text = self.bpm.description
        hapticController.stop()
            hapticController.bpm = Double(self.bpm)
        startText2.setTitle("START", for: .normal)
        isPlaying = false
       
        time = 0.0
        
        timer.invalidate()
        
        
        
        stopButtonyo.alpha = 0
        
        startText2.alpha = 1
        
        
        
    }
    
    
    @IBAction func stopButton(_ sender: Any) {
        
        
        hapticController.stop()
        
        startText2.setTitle("START", for: .normal)
        isPlaying = false
       
        time = 0.0
        
        timer.invalidate()
        
        startText2.alpha = 1
        
        stopButtonyo.alpha = 0
    }
    
    
    
    @IBOutlet weak var stopButtonyo: UIButton!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        hapticController.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stopButtonyo.alpha = 0
        
        BackView.layer.cornerRadius = 30
        
        BackView.layer.shadowColor = UIColor.black.cgColor
        
        BackView.layer.shadowOffset = CGSize(width: 0, height: -6)
       BackView.layer.shadowOpacity = 0.1
        BackView.layer.shadowRadius = 15
        
        ordinalButton.layer.cornerRadius = 6
        
        ordinalButton.layer.borderWidth = 1.5
        ordinalButton.layer.borderColor = UIColor {_ in return #colorLiteral(red: 0.143012166, green: 0.143012166, blue: 0.143012166, alpha: 1)}.cgColor
        
        uraButton.layer.cornerRadius = 6
        
        uraButton.layer.borderWidth = 1.5
        
        uraButton.layer.borderColor = UIColor {_ in return #colorLiteral(red: 0.5155439973, green: 0.5220336914, blue: 0.5219195485, alpha: 1)}.cgColor
        
        
        
        
        BPMText.isUserInteractionEnabled = true
        BPMText.text = self.bpm.description
        
        
        print(round(60/Double(self.bpm) * 10000)/10000)
        
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(tapped2(_:)))
       BPMText.addGestureRecognizer(tapGesture2)
        
        stopButtonyo.setTitle("", for: .normal)
        
        
        textField2.alpha = 0
        textField2.keyboardType = UIKeyboardType.numberPad
      
        tapGesture2.delegate = self
        
        textField2.text = self.bpm.description
        
        
        circleImage.layer.shadowColor = UIColor.black.cgColor
        
        circleImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        circleImage.layer.shadowOpacity = 0.3
        circleImage.layer.shadowRadius = 1
        
        
    }
    
    @IBOutlet weak var circleImage: UIImageView!
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
