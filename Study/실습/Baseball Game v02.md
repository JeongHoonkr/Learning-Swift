## Baseball Game v02

#### 1. v01과의 차이점

> indent를 줄이기 위해, while문안의 내용을 함수단위로 잘개 쪼개기



#### 2. 다음과제

> 2-1. 전역변수 최소화해서 함수내에 파라미터로 값받기
>
> 



```swift
//
//  main.swift
//  testTest
//  Created by Choi Jeong Hoon on 2017. 10. 11..
//  Copyright © 2017년 JH Factory. All rights reserved.


import Foundation

// 1. 속성선언
// 1-1. 정답과, 답안지 타입 및 초기값이 같기 때문에 튜플로 선언
// 1-2. 스트라이크 및 볼값도 마찬가지로 튜플로 선언
// 1-3. 암시적 옵셔널 타입의 답안지를 인트형 타입으로 저장하기 위한 변수 선언
// 1-4. 출력메세지를 위한 변수 선언
var (answerSheet,correctAnswer):([Int],[Int]) = ([],[])
var (strike, ball):(Int, Int) = (0,0)
var modifiedInputNum: Int = 0
var message: String = ""


// 2. 랜덤함수 만들기
// 2-1. 중복된 숫자들어오게 하지 않기 위한 부분 구현
func makeRandomNum () -> [Int] {
    while correctAnswer.count < 3 {
        let randomNum: Int = Int(arc4random_uniform(8) + 1)
        if !correctAnswer.contains(randomNum) {
            correctAnswer.append(randomNum)
        }
    }
    return correctAnswer
}

// 3. 초기화 부분을 while문에서 빼내어 함수로 분리
func reset () {
    answerSheet = []
    strike = 0
    ball = 0
    message = ""
}

// 4. 랜덤숫자 생성
correctAnswer = makeRandomNum()
print(correctAnswer)

// 5. 게임시작 알림
print("베이스볼 게임을 시작합니다")
print("숫자를 입력해주세요")

// 6. input값 받는 함수
func generateNum () -> Int! {
    var inputNum: Int!
    if let numStr = readLine() {
        inputNum = Int(numStr)
    }
    return inputNum
}

// 7. 숫자를 배열에 넣는 함수
func makingAnswerSheet () -> [Int] {
    while modifiedInputNum > 0 {
        answerSheet.insert(modifiedInputNum % 10, at: 0)
        modifiedInputNum /= 10
    }
    return answerSheet
}

// 8. 정답지와 인풋값을 비교하는 함수
func compareNum () -> (Int, Int) {
    let checkArray: [Int] = makingAnswerSheet()
    var (s, b): (Int,Int) = (0,0)
    for i in 0..<checkArray.count {
        if correctAnswer[i] == checkArray[i] {
            s += 1
        }
        else if correctAnswer.contains(checkArray[i]) {
            b += 1
        }
    }
    return (s, b)
}

// 9. 게임종료여부 체크하는 함수
func gameEndCheck () -> String {
    (strike, ball) = compareNum()
    if strike == 3 {
        message += "3개의 숫자를 모두 맞히셨습니다! 게임 종료"
    } else {
        message += "\(strike)Strike, \(ball)ball"
        print (message)
        reset()
    }
    return message
}

// 게임 진행 및 결과문구 출력
while strike != 3 {
    modifiedInputNum = generateNum()
    answerSheet = makingAnswerSheet()
    (strike, ball) = compareNum()
    message = gameEndCheck()
    print (message)
}

```

