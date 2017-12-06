## 클로저 Closure



정의 : 일정 기능을 하는 코드를 하나의 블록으로 모아놓은 것 ( 함수랑 비슷하다. 사실 함수는 클로저의 한 형태라고 한다.)



함수 중심 프로그래밍

in 앞이 매개변수 in 뒤가 함수 구현부분



클로저 

클로저 : 타입 = { 구현 }

클로저 = { (타입) -> in 구현}

외부의 값을 내부에 캡쳐(값복사)해서 담고 닫아버리고, 밖에 값이 바뀌어도 영향받지 않는다

(오브젝티브 씨는 캡쳐해서 구현, 참조X)



스위프트의 클로저는 값을 참조해서 구현해서 변경가능한 간접참조이나

캡쳐처럼 사용할 수도 있다. 



클로저를 리턴 함수 : 함수도 하나의 객체로 생각

```swift
함수(또는 클로저)를 인자값 또는 리턴값으로 사용하는 함수
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
let reversedNames = names.sorted(by: {
    (s1: String, s2: String) -> Bool in
        return s1 > s2
    })

let reversedNames = names.sorted { s1, s2 in s1 > s2 }
//["Ewa", "Daniella", "Chris", "Barry", "Alex"]
```



map : 모든 요소를 스트링으로 바꿔서 어레이로 바꿔서 넘겨주기

```swift
 let numbers = [1, 2, 3]
 let strings = numbers.map( { element in String(element) } )
 print(strings) //["1", "2", "3"]

 [ x1, x2, ... , xn].map(f) -> [f(x1), f(x2), ... , f(xn)]
```



filter for문돎녀서 조건에 맞는것을 어레이에 담기 : 하지만 무조건 다 돌아야 한다, 멈출수없다



reduce : reduce하면 현재선언되어 있는 차원보다 하나가 줄어듬

배원의 차원 [ [1,2], [3,4] ]  = 2차원배열

```swift
let number = [1,2,3,4,5,6,7,8,9,10]
let filter = number.reduce(0, { $0 + $1 })
// 배열을 벗기게됨
print(filter)
```



flatmap



참조를 통해 한다리건너 해결할수 있느 문제가 많다.

클래스와 스트럭쳐 자기만의 



copy on write