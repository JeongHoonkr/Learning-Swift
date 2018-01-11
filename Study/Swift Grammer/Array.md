## Array

##### 1. 정의

> Array는 순서가 있는 값들의 컬렉션이다. 
>
> **순서**라는것은  ```Set, Dictionary, Tuple``` 이 세가지 컬렉션과의 가장 큰 차이점이다.
>
> 또한 Array에는 어떤 종류의 값(즉 객체 및 비객체)과 타입을 담을 수 있다. 
>
> <단 여러종류의 타입을 담기 위해서는 ```any```라는 타입을 명시해줘야 한다.



##### 2. 배열의 생성

```swift
// 빈배열 생성
var myBasket1: [String] = []
var myBasket2 = [String]()
var myBasket3: Array<String> = []
var myBasket4 = Array<Int>()

// 값이 있는 배열 생성
var myBasket5: [String] = ["사과", "바나나"]
var myBasket6 = [5.3, 6.5] //타입유추
var myBasket7: Array<Int> = [16,5,3]
var myBasket8 = Array<Int>(1...5)
```



##### 3. 배열에의 접근과 사용  <아래 코드는 다 이어지는 코드를 항목에 맞게 나눠놓은 것이다.>

* 값 추가하기 : ```append(_:)``` 메서드 사용

```swift
var myBucketList: [String] = ["스위스 여행또가기", "앱출시해서 1등하기"]

var addList = ["단독주택 짓기", "스위스 수네가 하이킹", "강아지키우기", "눈덮힌 한라산 오르기", "눕자마자 잠들기 성공"]
for i in addList {
    myBucketList.append(i)
}
```



* 값 제거하기 : ```remove(at:)``` 메서드 사용

```swift
// remove(at:) at다음에 인덱스번호를 넣는다. 해당 인덱스값 삭제
myBucketList.remove(at: 1)
```



* 항목 세기 : ```count``` 프로퍼티 사용

```
myBucketList.count
```



* 상위 항목 찾기 : 서브스크립트 []대괄호 사용

```swift
myBucketList[0...2]
```



* 서브스크립트 활용해서 내용 구체화하기

```swift
myBucketList[0] += "2년 안에, 꼭!"
```



* += 연산자로 for in 쓰지 않고 배열과 배열 합치기

```swift
var plusList = ["개발자로 일해보기", "개발자로 경력5년쌓기"]
myBucketList += plusList
```



* 서브스크립트 활용해서 내용 교체하기

```
myBucketList[4] = "눈덮힌 브라이트로른 다시 오르기"
```



* 특정 인덱스에 추가로 값 삽입하기

```
myBucketList.insert("건강하게 살기", at: 0)
```



* 등가 확인하기 

```swift
// 배열의 등가
// 같은지를 판단할때는 '==' 연산자며 Bool값을 리턴한다.
// 중요! 배열의 같음은 값 뿐 아니라 순서도 판단한다.
// 즉 인덱스와 인덱스에 해당하는 값이 동일한지를 판단한다.
var firstNumList = [1,2,3,4,5]
var secondNumList = [5,4,3,2,1]

let isEqual1 = (firstNumList == secondNumList)

var thirdNumList = [1,2,3,4,5]
var fourthNumList = [1,2,3,4,5]

let isEqual2 = (thirdNumList == fourthNumList)


// 반면 Set과 같이 순서가 없는 컬렉션은 갑이 같다면 동일하다고 인식한다.
var firstSetList: Set = [1,2,3,4,5]
var secondSetList: Set = [5,3,2,1,4]

let isEqual3 = (firstSetList == secondSetList)


// let(상수)으로 선언된 배열은 변경할 수 없다.
```

