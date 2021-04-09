//
//  ViewController.swift
//  Calculator
//
//

import UIKit


class ViewController: UIViewController {
    
    var operatingSign: String = ""
    var screenNumber:Double = 0 //「現在螢幕上輸入完的數字」
    var memoryNumber:Double = 0 //「上次輸入上的數字」
    var calculating:Bool = false //是否有按運算符號
    var startNew: Bool = true
    
    
    @IBOutlet weak var label: UILabel!
    
    enum OperationType {
        case add
        case subtract
        case multiply
        case divide
        case mod
        case none
    }
    var operation: OperationType = .none
    //預設的運算符號：無
    
    override func viewDidLoad() {
           super.viewDidLoad()
            
       }
     
    
    //@IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) { //先將0拉進來，再將1~9的按鈕都拉近這個function
        
        
        let inputNumber = (sender.tag-1) //tag預設為0，各數字的tag比值大一（例如2 tag -> 3)
        if label.text != nil {
            
            if startNew == true{
                label.text = "\(inputNumber)"
                startNew = false
            } else {
                if label.text == "0" || operatingSign == "+" || operatingSign == "-" || operatingSign == "×" || operatingSign == "÷" || operatingSign == "%" {
                    label.text = "\(inputNumber)"
                    operatingSign = ""
                } else {
                    if (Int(label.text!) ?? 0 < 1000) {
                        label.text = label.text! + "\(inputNumber)"
                    }
                }
            }
            screenNumber = Double(label.text!) ?? 0
        }
    }
    
    @IBAction func clear(_ sender: UIButton) { //AC 將所有設定還原
        label.text = "0"
        screenNumber = 0
        memoryNumber = 0
        calculating = false
        startNew = true
        //operation = .none
    }
    
    
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var subtract: UIButton!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var divide: UIButton!
    @IBOutlet weak var mod: UIButton!
    
    
    @IBAction func add(_ sender: UIButton) {
        if memoryNumber != 0 {
                    currentAnswer()
                }
        operatingSign = "+"
        operation = .add
        calculating = true
        startNew = false
        memoryNumber = screenNumber
    }
    @IBAction func subtract(_ sender: UIButton) {
        if memoryNumber != 0 {
                    currentAnswer()
                }
        operatingSign = "-"
        operation = .subtract
        calculating = true
        startNew = false
        memoryNumber = screenNumber
    }
    @IBAction func multiply(_ sender: UIButton) {
        if memoryNumber != 0 {
                    currentAnswer()
                }
        operatingSign = "×"
        operation = .multiply
        calculating = true
        startNew = false
        memoryNumber = screenNumber
    }
    @IBAction func divide(_ sender: UIButton) {
        if memoryNumber != 0 {
                    currentAnswer()
                }
        operatingSign = "÷"
        operation = .divide
        calculating = true
        startNew = false
        memoryNumber = screenNumber
    }
    @IBAction func mod(_ sender: UIButton) { //這功能尚未做完，麻煩你了><
        //print("screen" + "\(screenNumber)")
        if memoryNumber != 0 {
                    currentAnswer()
                }
        operatingSign = "%"
        operation = .mod
        calculating = true
        startNew = false
        memoryNumber = screenNumber
    }
    
    @IBAction func dut(_ sender: UIButton) {
        
        if (label.text != nil) {
            if (startNew == true) {
                label.text = "0."
                startNew = false
            } else {
                label.text = label.text! + "."
            }
        }
    }
    
    @IBAction func result(_ sender: UIButton) {
        if calculating == true {
            //print("screen" + "\(screenNumber)")
            switch operation {
            
            case .add:
                screenNumber = memoryNumber + screenNumber
                checkAnswer(from: screenNumber)
                break
            case .subtract:
                screenNumber = memoryNumber - screenNumber
                checkAnswer(from: screenNumber)
                break
            case .multiply:
                screenNumber = memoryNumber * screenNumber
                checkAnswer(from: screenNumber)
                break
            case .divide:
                guard screenNumber != 0 else {
                    return label.text = "ERROR"
                }
                screenNumber = memoryNumber / screenNumber
                checkAnswer(from: screenNumber)
                break
            case .mod:
                screenNumber = (memoryNumber .truncatingRemainder(dividingBy: screenNumber))
                checkAnswer(from: screenNumber)
                break
            case.none:
                label.text="0"
                break
            }
            calculating = false
            startNew = true
        }
        memoryNumber = 0
    }
    
    // 檢查運算結果是否符合顯示條件
        func checkAnswer(from number: Double) {
            // 紀錄符合顯示條件的字串
            var okText: String
            
            // 如果傳入的數字無條件捨去之後和原來相等，表示數字為整數，將數字轉型為 Int 再變成字串顯示
            if floor(number) == number {
                okText = "\(Int(number))"
            // 如果傳入的數字無條件捨去之後和原來不相等，表示數字為小數，數字保留為 Double 再變成字串顯示
            } else {
                okText = "\(number)"
            }
            
            // 字串最多只顯示 4 位數，但是目前只有result變成4位數，輸入時不變，還是能輸入很多
            /*if (okText.count >= 4) {
                okText = String(okText.prefix(4))
                
            }*/
            label.text = okText
        }
    
    func currentAnswer() {
            switch operation {
            case .add:
                screenNumber = memoryNumber + screenNumber
                checkAnswer(from: screenNumber)
            case .subtract:
                screenNumber = memoryNumber - screenNumber
                checkAnswer(from: screenNumber)
            case .multiply:
                screenNumber = memoryNumber * screenNumber
                checkAnswer(from: screenNumber)
            case .divide:
                screenNumber = memoryNumber / screenNumber
                checkAnswer(from: screenNumber)
            case .mod:
                screenNumber = (memoryNumber .truncatingRemainder(dividingBy: screenNumber))
                checkAnswer(from: screenNumber)
            case .none:
                label.text = ""
            }
        }
}

