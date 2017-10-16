## Baseball Game v01



```swift
// 1. 속성선언
// 1-1. 정답과, 답안지 타입 및 초기값이 같기 때문에 튜플로 선언
// 1-2. 스트라이크 및 볼값도 마찬가지로 튜플로 선언
// 1-3. 입력받은 값을 Int로 변환한 값이 옵셔널이기 때문에 이값을 받을 옵셔널 변수 선언
var (answerSheet,correctAnswer):([Int],[Int]) = ([],[])
var (strike, ball):(Int, Int) = (0,0)
var inputNum: Int!

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
}

// 4. 랜덤숫자 생성
correctAnswer = makeRandomNum()
print(correctAnswer)

// 5. 게임시작 알림
print("베이스볼 게임을 시작합니다")
print("숫자를 입력해주세요")

// 6.  볼게임 메인연산
// 6-1. readLine은 반환값이 String?이기 떄문에 옵셔널 바인딩 사용
// 6-2. Int로 형변환 되면 다시 옵셔널타입이 되기때문에 암시적 옵셔널 변수에 넣기
// 6-3. 정답지와 비교를 위해 변환된 값을 답안지 배열에 넣기
// 6-4. 정답지와의 비교연산
// 6-5. 게임종료 조건 설정 (스트라이크3개면 게임종료, 아니면 스트라이크 볼 현황을 출력하고 리셋 및 다시입력 요구
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
```

