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
    
// 변수 선언부
    var preToresultValue: Double = 0.0   // 처음 입력하는 숫자 및 연산 이후 결과 출력 변수
    var linkedValue: Double = 0.0  // 중간 입력 숫자
    var op: String = ""  // 연산자 입력
    var isTyping: Bool = true  // 숫자에 숫자 입력시 더 입력이 가능한지에 대한 불값
 
// 숫자버튼 액션부
    @IBAction func numberkeyclick(btn: UIButton)
    {
        
        if isTyping == true       // 기존숫자에 숫자를 추가할 수 있음
        {
            if displayLabel.text == "0" {     // 현재 표시된 숫자가 0일경우
                displayLabel.text = ""   //빈 값을 출력
                displayLabel.text! = btn.titleLabel!.text!  // 버튼 터치한 숫자를 출력
            }
            else {
                displayLabel.text! += btn.titleLabel!.text! // 현재 표시된 숫자가 0이 아닐 경우 기존 숫자에 스트링처럼 이어줌 "1" + "2" = "3"
                linkedValue = Double(displayLabel.text!)!     // 새로 입력한 숫자를 연결 변수에 저장
            }
        } else {     // 기존 숫자에 추가할 수 없을 경우
            displayLabel.text = btn.titleLabel!.text!  // 새로 입력한 숫자를 출력
            isTyping = true
        }
    }
// 출력화면 초기화부 ("0"으로)
    @IBAction func resetButton(btn: UIButton)
    {
        if btn.titleLabel?.text! == "AC" {   // 터치하는 버튼이 "AC"일 경우
            displayLabel.text = "0"    // 출력화면에 "0"을 출력
            op = ""
            preToresultValue = 0.0
        }
    }
    
//연산버튼 저장부
    @IBAction func operate(_ sender: UIButton) {
        op = sender.titleLabel!.text!
        preToresultValue = Double(displayLabel.text!)!
        isTyping = false
    }
    
    
// 연산결과 출력부   ( = 버튼 )
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
