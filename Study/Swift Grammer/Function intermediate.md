## Function intermediate



### 1. Guard

> * 목적 :  guard는 어떤 조건이 만족되지 않을때 중간에 탈출하기 위해 사용하기 때문에
>
> ​                  맞지 않는 코드일때 코드가 실행되지 않도록 보호해준다.
>
> * 효과 : 코드를 더 읽기 쉽게 만들어줌, if else가 중첩되어질때 guard를 쓰면
>
>   ​          indent가 줄어드는 효과가 있다.
>
> * 주의 : return을 항상 명시적으로 추가해서 함수에서 중도에 빠져나가야 한다는 것을 나타내야 한다.



```swift
// if-else문의 중복사용 해석을 위해 위아래를 여러번 읽어야 한다.
func singHappyBirthday () {
    var birthdayIsToday = true
    var invitedGuests = 3
    var isCakeCandlesOn = true
    if birthdayIsToday {
        if invitedGuests > 0 {
            if isCakeCandlesOn {
                print("생일 축하해!")
            } else {
                print("켜져있는 케익촛불이 없어")
            }
        } else {
            print("그냥 가족끼리 하는 파티야")
        }
    } else {
        print("오늘 생일인 사람 없는데?")
    }
}

// guard문의 사용
func singHappyBirthday () {
    // 아래 guard문중 하나라도 거짓일 경우 else구문 출력하고 함수에서 빠져나옴
    let birthdayIsToday = true
    let invitedGuests = 2
    let isCakeCandlesOn = true
    guard birthdayIsToday else {print("오늘 생일인 사람 없는데?") return}
    guard invitedGuests > 0 else {print("그냥 가족끼리 하는 파티야") return }
    guard isCakeCandlesOn else {print("켜져있는 케잌촛불이 없어") return }
    
    // guard문의 조건이 모두 참일때 실행
    print ("생일 축하해!")
}
singHappyBirthday()
```



### 2. 일급함수의 특성 <클로저를 이해하기 위한 첫번째 준비>

#####  (1) 변수나 상수에 함수 대입하기

>말 그대로 변수나 상수에 함수를 집어넣는다는것
>
>이때 함수의 타입은 파라미터와 리턴값의 타입으로 결정된다.
>
>**함수가 대입된 상수는 함수처럼 인자값을 받아 실행이 가능하고, 값도 반환할 수 있다**

```swift
func sortedEvenNumbers (numbers: [Int]) -> (evens: [Int], odds: [Int]) {
	var evens = Array<Int>()
	var odds = Array<Int>()
	for number in numbers {
		if number % 2 == 0 {
			evens.append(number)
		} else {
			odds.append(number)
		}
	}
	return (evens, odds)
}

let getEvenOdds: (Array<Int>) -> (Array<Int>, Array<Int>) = sortedEvenNumbers(numbers:)
// sortedEvenNumbers(numbers:) : 이 부분을 함수의 식별자(인자까지 포함된 전체이름)라고 한다.
// 함수의 타입 표시형식 : (매개변수타입1, 매개변수타입2...매개변수타입n) -> 반환타입
// 함수의 정의에서는 매개변수가 없거나 반환이 없을떄 생략이 가능하지만 타입으로 표시할때는 아래와 같이 적어야 한다.
// ([Int], [Int]) -> void, (void) -> void
// 이렇게 타입을 생략할 수도 있다. let getEvenOdds = sortedEvenNumbers
print(getEvenOdds(numbers:[1,5,7,9,10]))
```

> 상기 내용은 변수나 상수에, 함수의 결과값을 단순대입은 아래내용과 의미가 다르다.

```swift
let getEvenOdds = sortedEvenNumbers([1,5,7,9,10])
// print()문이 없어도 결과값을 플레이그라운드에서 확인 가능
```



#####  (2) 함수의 반환타입으로 함수를 사용하기

> <기본형태> : func hoon() -> void -> String
>
> * 해석1 :     <- 인자타입  |  반환타입 ->    
> * 해석2:                    <- 인자타입  |  반환타입 ->
>
> 각 화살표 기준으로 왼쪽이 인자타입이고 오른쪽이 반환타입이다.  

```swift
func plus (a: Int, b: Int) -> Int {
    return a + b
}

func minus (a: Int, b: Int) -> Int {
    return a - b
}

func times (a: Int, b: Int) -> Int {
    return a * b
}

func divide (a: Int, b: Int) -> Int {
    return a / b
}

func calc (_ operand: String) -> (Int, Int) -> Int {
    switch operand {
    case "+" : return plus
    case "-" : return minus
    case "*" : return times
    case "/" : return divide
    default : return plus
    }
}

let operation: (Int, Int) -> Int = calc("+")
operation(3, 5)
```



#####  (3) 함수의 인자값으로 함수를 사용할 수 있음

> 함수의 인자값으로 함수를 사용한다는것은 인자값이 함수타입으로 정의된다는 것을 말한다.
>
> 자바스크립트의 콜백함수와 마찬가지로 실행하고자 하는 구문을 담은 함수를 인자값으로 넣는 것을 의미한다.

```swift
func plusAB(a: Int, b: Int) -> Int {
    return a + b
}

func operation (inputNumA: Int, inputNumB: Int, plus: (Int, Int) -> Int) -> Int {
    return plus(inputNumA, inputNumB)
}

print(operation(inputNumA: 5, inputNumB: 4, plus: plusAB))
```



> 콜백함수 및 [defer](http://gogorchg.tistory.com/entry/iOS-Swift-defer-블록)의 사용
>
> ```defer```는 작성순서에 관계없이 마지막에 실행된다.
>
> 주요 사용용도는 함수를 종료하기 전에 처리해야 할 변수나 상수중 처리시점이 모두 달라서 적절한 처리 시점을
>
> 잡기 어려울때 사용한다.

```swift
func okHoonGenius () {
    print ("맞아요 정훈은 똑똑해요")
}

func InputAgain () {
    print ("정훈을 과소평가하지 마세요.")
}

func  guessHoonIQ (iq inputNum: Double, right yesMessage: () -> Void, wrong noMessage: () -> Void) {
    defer {
        print ("훈의 아이큐 맞추기!")
    }

    if inputNum > 130  {
        okHoonGenius()
    } else {
        InputAgain()
    }
}

guessHoonIQ(iq: 140, right: okHoonGenius, wrong: InputAgain)
```

> 클로저 맛보기! 
>
> 위와 같이 인자값으로 사용하기 위해 매번 함수를 작성하는것은 번거로운 일이다. 
>
> 이를 해결하는 방법으로 익명함수인 클로저를 사용할 수 있다.
>
> 위 코드의 호출부분을 클로저로 변경하면 아래와 같다.

```swift
guessHoonIQ(iq: 140,
            right: {
                () -> Void in
                print ("맞아요 정훈은 똑똑해요")
            },
            wrong:  {
                () -> Void in
                print ("정훈을 과소평가하지 마세요.")
            }
)
```





### 3. 중첩함수 <클로저를 이해하기 위한 두번째 준비>

> * 중첩함수는 함수내에 다른 함수를 작성해서 사용하는것을 말한다. 
>
> * 이를 중첩함수(Nested Function)라 하고 함수내에 작성된 함수를 내부함수라하고, 
>
>   내부함수를 포함하는 바깥함수를 외부함수라 한다.
>
> * 내부함수는 외부함수를 거치지 않으면 접근할 수 없으며, 이를 은닉성이라 한다.

```swift
func outer() -> (Int) -> String {
    func inner(inputNum: Int) -> String {
        return "\(inputNum)을 리턴합니다."
    }
    return inner
}

// outer함수가 실행되고 그 결과로 inner가 function1에 대입된다.
let function1 = outer()

// inner함수에 10을 대입한것과 동일하다.
let function2 = function1(10)
```

> 내부함수가 외부함수의 지역상수나 변수를 참조할 경우
>
> - 클로저의 특성을 알기전까지의 이해 : value상수는 result상수의 실행이 완료될때 제거되어야 하고
>
>   result(10) 부분은 오류여야 함
>
> - But 코드는 정상동작하며 80을 반환함
>
> - 본격클로저가 아니기 때문에 이정도로만 이해 : 클로저는 **내부함수 + 함수의 주변환경(값)**

```swift
func basic (param: Int) -> (Int) -> Int {
    let value = param + 20
    func append (add: Int) -> Int {
        return value + add
    }
    return append
}

let result = basic(param: 50) // (Int) -> Int
```

>위 코드중 ```let result = basic(param: 50)``` 이 부분이 실행되면 클로저가 만들어짐
>
>기존에 value라는 객체자체가 사용되던 append함수의 코드가 basic(param: 50)의 실행으로 얻게된 값인 70으로
>
>바뀐것

```swift
// result에 저장되는 클로저의 형태
func append (add: Int) -> Int {
    return 70 + add
}

////
result(10) // 80
```



