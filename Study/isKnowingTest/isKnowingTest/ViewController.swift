//
//  ViewController.swift
//  isKnowingTest
//
//  Created by Choi Jeong Hoon on 2017. 9. 21..
//  Copyright © 2017년 JH Factory. All rights reserved.


import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var result1: UILabel!
    @IBOutlet weak var result2: UILabel!
    @IBOutlet weak var result3: UILabel!
    @IBOutlet weak var result4: UILabel!

    let answerSheet: Breakthrough = Breakthrough()
    
    override func viewDidLoad() {  // 뷰가 보여지고 뷰에 액션을 하기전에 보여질 가장 최적의 장소
        super.viewDidLoad()
    }
    @IBAction func firstAnswer(_ sender: UIButton) {
        result1.text = String(answerSheet.reducingNum(inputNum: 11223344))
    }
    @IBAction func secondAnswer(_ sender: UIButton) {
        result2.text = String(answerSheet.chekLeapYear(inputYear: 2115))
    }
    @IBAction func thirdAnswer(_ sender: UIButton) {
        result3.text = String(answerSheet.addDigit(inputNum: 123456))
    }
    @IBAction func fourthAnswer(_ sender: UIButton) {
        result4.text = String(describing: answerSheet.randomNum())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
