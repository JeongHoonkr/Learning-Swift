## Baseball Game v03

#### 1. v02와의 차이점

> ㅇㅇㅇ



#### 2. 다음과제

>



```swift
//
//  main.swift
//  testTest
//  Created by Choi Jeong Hoon on 2017. 10. 11..
//  Copyright © 2017년 JH Factory. All rights reserved.


import Foundation

/*      =========
 강사님 피드백
 =========       */
// 전역변수는 최소화하는것이 좋다. (최우선적으로 반영)      :    1개 줄임 < 나머지3개는 초기화함수에 들어가서 어떻게 뺴야할지 모르겠음
// 차라리 함수안에 파라미터값을 받아서 내부적으로 사용하는 것이 좋다.


/*      =========
 추가할 기능
 =========       */
// 1. 인풋값 체크 정교화
// 1-1. 3자릿수 미만 입력시, "3자리 숫자를 입력해주세요"     : 시도못함
// 1-1. 중복값이 들어올 경우, "중복된 숫자가 있습니다, 다시 입력해주세요" 다시 입력값 띄우기.  : 연속숫자는 체킹 가능하나, 0인덱스와 2번쨰 인덱스 체크시  체크가 안됨
// 1-2. 입력받은 숫자중 0이있을 경우 0은 입력할 수 없습니다. 다시 입력해주세요.   : 시도못함

var answerSheet: [Int] = []
var (strike, ball):(Int, Int) = (0,0)
var message: String = ""

// 2-1. 중복된 숫자들어오게 하지 않기 위한 부분 구현
func makeRandomNum () -> [Int] {
    var correctAnswer: [Int] = []
    while correctAnswer.count < 3 {
        let randomNum: Int = Int(arc4random_uniform(8) + 1)
        if !correctAnswer.contains(randomNum) {
            correctAnswer.append(randomNum)
        }
    }
    return correctAnswer
}

// 3. 초기화
func reset () {
    answerSheet = []; (strike,ball) = (0,0); message = ""
}

// 4. 랜덤숫자 생성

print(makeRandomNum())

// 5. 게임시작 알림
print("베이스볼 게임을 시작합니다")
print("숫자를 입력해주세요")

// input값 받는 함수
func generateNum () -> Int! {
    var inputNum: Int!
    if let numStr = readLine() {
        inputNum = Int(numStr)
    }
    return inputNum
}

// modified 넘버체크

// 숫자를 배열에 넣는 함수
func makingAnswerSheet (input: Int) -> [Int] {
    var modifiedNum = input
    while modifiedNum > 0 {
        answerSheet.insert(modifiedNum % 10, at: 0)
        modifiedNum /= 10
    }
    return answerSheet
}

// 정답지와 인풋값을 비교하는 함수
func compareNum (inputArray: [Int]) -> (Int, Int) {
    let checkArray: [Int] = inputArray
    var crtAnswer: [Int] = makeRandomNum()
    var (s, b): (Int,Int) = (0,0)
    for i in 0..<checkArray.count {
        if crtAnswer[i] == checkArray[i] {
            s += 1
        }
        else if crtAnswer.contains(checkArray[i]) {
            b += 1
        }
        else if !crtAnswer.contains(checkArray[i]) {
            return (s, b)    // s,b를 0.0으로 했을때는 출력값이 제대로 나오지 않았다.
        }
    }
    return (s, b)
}

/* answerSheet을 체크하는 함수
func checkDupulNum (answerArray: [Int]) {
    var answerArray = answerArray
    answerArray = answerSheet
   
    for i in 1..<answerSheet.count-1 {
        if answerArray[i-1] == answerArray[i] {
            print("\(answerArray[i])와 \(answerArray[i-1])은 같은 숫자입니다. \n동일한 숫자는 입력할 수 없습니다.")
        }
    }
}

 */

// 게임종료여부 체크하는 함수
func strikeBallCheck () -> String {
    (strike, ball) = compareNum(inputArray: answerSheet)
    switch (strike, ball) {
    case (3, 0) :
        message += "3개의 숫자를 모두 맞히셨습니다! 게임 종료"
    case (0, 0) :
        message += "일치하는 숫자가 없습니다."
        print (message)
        reset()
    case (0, _) :
        message += "숫자는 맞았습니다. 순서를 바꿔보시는게 어때요?"
        print (message)
        reset()
    default :
        message += "\(strike)Strike, \(ball)ball"
        print (message)
        reset()
    }
    return message
}

// 게임 진행 및 결과문구 출력
while strike != 3 {
    var modifiedInputNum: Int
    modifiedInputNum = generateNum()
    answerSheet = makingAnswerSheet(input: modifiedInputNum)
    (strike, ball) = compareNum(inputArray: answerSheet)
    message = strikeBallCheck()
    print (message)
}

```

