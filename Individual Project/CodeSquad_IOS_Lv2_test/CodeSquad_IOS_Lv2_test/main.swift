//
//  main.swift
//  testTest
//  Created by Choi Jeong Hoon on 2017. 10. 11..
//  Copyright © 2017년 JH Factory. All rights reserved.


import Foundation


// 속성
var (answerSheet,correctAnswer):([Int],[Int]) = ([],[])
var (strike, ball):(Int, Int) = (0,0)
var inputNum: Int!

// 랜덤함수 만들기
func makeRandomNum () -> [Int] {
    while correctAnswer.count < 3 {
        let randomNum: Int = Int(arc4random_uniform(8) + 1)
        if !correctAnswer.contains(randomNum) {
            correctAnswer.append(randomNum)
        }
    }
    return correctAnswer
}
// 초기화
func reset () {
    answerSheet = []
    strike = 0
    ball = 0
}

correctAnswer = makeRandomNum()
print(correctAnswer)
print("베이스볼 게임을 시작합니다")
print("숫자를 입력해주세요")

// 숫자 입력받기  : 이 부분을 분리할 수 있는 방법 찾기
while strike != 3 {
    if let numStr = readLine() {
        inputNum = Int(numStr)
        var modifiedInputNum: Int = inputNum
        while modifiedInputNum > 0 {
            answerSheet.insert(modifiedInputNum % 10, at: 0)
            modifiedInputNum /= 10
        }
        for i in 0..<answerSheet.count {
            if correctAnswer[i] == answerSheet[i] {
                strike += 1
            }
            else if correctAnswer.contains(answerSheet[i]) {
                ball += 1
            }
        }
        if strike == 3 {
            print ("3개의 숫자를 모두 맞히셨습니다! 게임 종료")
        } else {
            print ("\(strike)Strike, \(ball)ball")
            reset()
        }
    }
}

/*
 프로그래밍 구현 제약사항
 
 함수(또는 메소드)의 크기가 최대 10라인을 넘지 않도록 구현한다.                               succeed
 함수(또는 메소드)가 한 가지 일만 하도록 최대한 작게 만들어라.                                succeed
 indent(인덴트, 들여쓰기) depth를 최대한 작게 만들어라. depth가 1인 상태가 가장 좋다.          failed
 
 힌트
 컴퓨터가 3개의 값을 선택할 때 각 언어별 random 함수(또는 메소드) 또는 shuffle 함수(또는 메소드)를 이용하면 편한다.                     used
 반복문을 2중(반복문 안의 반복문)으로 사용하면 한번에 고려할 부분이 많다. 2중 반복문을 1중 반복문 2개로 나누어 처리하는 방법은 없는지 고려해 본다.  n/a
 depth를 줄이는 좋은 방법은 함수(또는 메소드)를 분리하면 된다. using
 */
