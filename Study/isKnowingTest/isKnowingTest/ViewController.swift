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
    
    // 변수 선언은 반드시 이곳에 해줘야 하는지 알았음
    
    // 함수 위치를 여기에 써도 되는지 viewDidLoad안에 써도 되는지? 다른 파일에 넣어도 되는지 헷갈렸음
    // 함수를 다른 스위프트 파일에 넣어도 오류가 안남
    // 헷갈렸던 점 화면에 결과값 표시해주기
    // 최초시도 : 함수 호출해서 인풋값 넣지 않고, result text에 바로 resultValue대입 = 초기값 0 출력
    // 두번째 시도 : resultValue아래에 함수호출 = 초기값 0 출력
    // 해결 : result.text위에서 함수호출
    
    override func viewDidLoad() {
        
        var answerSheet: Breakthrough = Breakthrough()
        var firstResult = answerSheet.reducingNum(inputNum: 11223344)
        var secondResult = answerSheet.chekLeapYear(inputYear: 2100)
        var thirdResult = answerSheet.addDigit(inputNum: 123455)
      
        
    }
    
    // 처음에 버튼 눌렀을때 텍스트 뿌려주는 방법을 생각하기 힘들었음
    
    @IBAction func firstAnswer(_ sender: UIButton) {
        result1.text = String()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



