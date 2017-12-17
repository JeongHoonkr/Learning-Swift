## 						Set

#### 1. 정의

> Array와 유사하기 때문에 2번의 사용법처럼 타입에 명시적으로 **set을 적어주지 않으면 배열로 인식한다.**
>
> 서로 연관성이 업는 *Collection Type*, 각각의 값은 반복되는 값을 허용하지 않는 고유의 값으로 순서가 없다.
>
> **요약 : 순서를 갖지 않는 컬렉션 타입**



#### 2. 기본문법

주요사용처 : 집합연산이 필요한 경우

> 아래  형태로 사용할 수 있으며, 타입추론은 작동하지 않는다.
>
> Set을 생략할경우 컴파일러는 Array로 인식한다.

```Swift
var aBag: Set<Int> = Set<Int>()
var aBag1: Set<Int> = Set([1,2,3,4,5])

var bBag: Set<Int> = ([])
var bBag1: Set<Int> = [1,2,3,4,5]

var cBag = Set<Int>()
var cBag1 = Set<Int>([1,2,3,4,5])

// 아래의 형태가 최소화된표현으로 더 축약할순 없다. 
var dBag: Set = [1,2,3,4,5]
```



#### 3. 사용가능한 메소드

(1) 두종류의 추가하는 방법

> 1. insert : (inserted: Bool, memberAfterInsert: Element)   
>
>    => 올바르게 삽입되었을 경우 true를 출력하고 추가되며 **중복된 값이 있을 경우 false를 출력하고** 
>
>    ​     **값이 추가되지 않는다.**

```Swift
var aBag = Set<String>()
var bBag: Set<String> = Set<String>()   // 문법 연습차 만들어본것

aBag.insert("사과")
aBag.insert("포도")
aBag.insert("바나나")
aBag.insert("포테이토칩")

abag.insert("사과")
// (inserted false, memberAfterInsert "사과") 이미 "사과"가 있어서 실패
```



> 2. update : 
>
> ![set의 update](http://postfiles12.naver.net/MjAxNzEwMDFfODQg/MDAxNTA2ODU3NjI0MDg0.iygaMdCTzMt4J5vugwmuZJV4P3nWLklKQe_VleMDC3sg.9-9PsefBQuoDtWP-ICvSkN50QHU9VmAuHbJc97Xm74Ug.PNG.bb_9900/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2017-10-01_%EC%98%A4%ED%9B%84_8.32.10.png?type=w2)
>
> - 값을 무조건 넣어주게 되어 있다. 즉 이미 set에 있다면 기존값을 대체한다.
> - ***String?*** 이라는 뜻은 Optional이다. 즉 String일수도 있고, 데이터가 없을 수 있다(nil)는 것
>
> - [ ]   **코드스쿼드 가면 물어보기**



(2) 특정 항목이 포함되어 있는지 확인

> contains(_:) 사용

```swift
var groceryBag: Set = ["Apples", "Pineapple", "Orange"]

let hasApples = groceryBag.contains("Orange")
let hasWatermelon = groceryBag.contains("Watermelon")
```



(3) 무작위 데이터의 정렬

> 데이터의 정렬은 .sorted() 메소드를 통해 가능

```swift
var oddDigits : Set = [1, 3, 5, 7, 9].sorted()
```



(4) 값 제거하기 

>  (4)-1.  ```remove(element)``` : 지정한 값을 삭제
>
> ![set](http://postfiles6.naver.net/MjAxNzEwMDRfMzgg/MDAxNTA3MTA3ODcwNjQ4.Kdgiu3UAzHHJ2cBJXpB2wa1LOL7idvnlXXBsH0bItx4g.ctjPfiMVXnjUohjUaJbrkJ9xJh6v_v5HXfNPVmktRk4g.PNG.bb_9900/스크린샷_2017-10-04_오후_6.00.54.png?type=w773)
>
> **<생각할거리> 위의 설명에서 주목해야 할 점은 remove메소드의 반환타입이 옵셔널이라는 점이다.**
>
> ```swift
> // remove 메소드는 컬렉션에 있는 요소를 삭제하면서 동시에 삭제된 값을 반환한다.
> // 따라서 아래와 같이 반환된값을 활용할 수 있다.
>
> var intSet: Set<Int> = [1,2,3,4,5]
> var numArray: [Int] = []
>
> for i in intSet
> {
>     // i는 값을 의미
>     numArray.append(intSet.remove(i)!)
> }
> print(numArray.sorted())
> ```
>
> 
>
> (4)-2.  ```remove (at: set<String>.Index(of: String)!)```  : Set에서 해당값이 위치한 인덱스의 값을 삭제
>
> - set<String>부분에는 해당Set의 이름이 들어간다.
>
> ![dd](http://postfiles2.naver.net/MjAxNzEwMDRfMTk1/MDAxNTA3MTEwMjU3MDU2.po5FjBqSETP849TLralHUWq2DPlPYP2g_Vy6rKGBzaQg.Afu6bvo_Pr2XPedJOmrc9vdISHh_quDUpWmxA-TWK5Mg.PNG.bb_9900/스크린샷_2017-10-04_오후_6.43.42.png?type=w773)
>
> ![ㅇㅇ](http://postfiles5.naver.net/MjAxNzEwMDRfMTUy/MDAxNTA3MTA5NTQ1Nzc5.W6YqNI_WjafQ0QJkfXm2rt4YNn7Ewj6sFlABhxulYUkg.iUyvDXyH4_rLxcdyf6iFdXGnZaPVrcNVyIXQb8IdyaMg.PNG.bb_9900/스크린샷_2017-10-04_오후_6.31.01.png?type=w2)
>
> ​      
>
> ```swift
> 복습시 위 두가지 이미지 잘 생각해보기
>
> var groceryBag: Set = ["Apples", "Pineapple", "Orange"]
> groceryBag.remove(at: groceryBag.index(of: "Orange")!)
> ```
>
> 
>
> (4)-3.  ```removeAll()``` : set에 들어있는 모든 요소 제거 (단 셋의 초기 셋팅시의 용량은 유지됨)
>
> ```swift
> groceryBag.removeAll()
> ```
>
> 



#### 4. set의 집합연산**

![set 집합연산](http://postfiles9.naver.net/MjAxNzEwMDFfMTI0/MDAxNTA2ODQzMzQ4NjM4.r-5SApp4oBU28lBirNGIbTNSOy-VZC6la1tZ47mFzwMg.oaCquCvdqPPGY2yCdran2XHQ3dS6JErrbusYK4owobEg.PNG.bb_9900/스크린샷_2017-10-01_오후_4.32.59.png?type=w773)

```
// 교집합
oddDigits.intersection(primeDigits).sorted()

// 여집합
oddDigits.symmetricDifference(primeDigits).sorted()

// 합집합
oddDigits.union(evenDigits).sorted()

// 차집합
oddDigits.subtract(primeDigits)
```



공통요소 제거하기

>  ```isDisjoint``` 사용

```swift
let myGroceryBag: Set = ["Apples", "Pineapple", "Orange"]
let yourGroceryBag: Set = ["Cereal", "Milk", "Toothpaste"]

let disjoint = myGroceryBag.isDisjoint(with: yourGroceryBag)  
// true
```

