//
//  ViewController.swift
//  MyCalculator
//
//  Created by Choi Jeong Hoon on 2017. 9. 11..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 오버라이드 후 부모클래스의 viewdidload 상속해야함
        
        displayLabel.text = "0"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var preToresultValue: Double = 0.0
    var linkedValue: Double = 0.0
    var op: String = ""
    var isTyping: Bool = true
    
    @IBAction func numberkeyclick(btn: UIButton)
    {
        
        if isTyping == true
        {
            
            if displayLabel.text == "0" {
                displayLabel.text = ""
                displayLabel.text! = btn.titleLabel!.text!
            }
            else {
                displayLabel.text! += btn.titleLabel!.text!
            }
            
        } else {
            displayLabel.text = btn.titleLabel!.text!
            linkedValue = Double(displayLabel.text!)!     // 연산 후 입력된 숫자를 afterValue에 담는다
            isTyping = true
            
        }
    }
    
    @IBAction func resetButton(btn: UIButton)
    {
        if btn.titleLabel?.text! == "AC" {
            displayLabel.text = "0"
        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        if sender.titleLabel!.text! == "+" {
            op = sender.titleLabel!.text!
            preToresultValue = Double(displayLabel.text!)!
            isTyping = false
        }
        if sender.titleLabel!.text! == "-" {
            op = sender.titleLabel!.text!
            preToresultValue = Double(displayLabel.text!)!
            isTyping = false
        }
        if sender.titleLabel!.text! == "x" {
            op = sender.titleLabel!.text!
            preToresultValue = Double(displayLabel.text!)!
            isTyping = false
        }
        if sender.titleLabel!.text! == "/" {
            op = sender.titleLabel!.text!
            preToresultValue = Double(displayLabel.text!)!
            isTyping = false
        }
    }

    @IBAction func total(_ sender: UIButton)  {
            if op == "+" {
                preToresultValue += linkedValue
                displayLabel.text! = String(preToresultValue)
            }
            else if op == "-" {
                preToresultValue -= linkedValue
                displayLabel.text! = String(preToresultValue)
            }
            else if op == "x" {
                preToresultValue *= linkedValue
                displayLabel.text! = String(preToresultValue)
            }
            else if op == "/" {
                preToresultValue /= linkedValue
                displayLabel.text! = String(preToresultValue)
            }
    }
 }
