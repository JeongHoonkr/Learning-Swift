## 						Set

* **정의**

  > Array와 유사하기 때문에 2번의 사용법처럼 타입에 명시적으로 set을 적어주지 않으면 배열로 인식한다.
  >
  > 서로 연관성이 업는 *Collection Type*, 각각의 값은 반복되는 값을 허용하지 않는 고유의 값으로 순서가 없다.
  >
  > **요약 : 순서를 갖지 않는 컬렉션 타입**



- **기본문법**

  주요사용처 : 집합연산이 필요한 경우

> 아래 두가지 형태로 사용할 수 있으며, 축약문법이 없다.

```Swift
var aBag = Set<String>()
var bBag: Set<String> = Set<String>()
```



> 처음에 초기값을 넣어줄 수도 있다

```swift
var yourBag: Set<String> = ["아이브로셔", "립밤", "교재"]
// var yourBag: Set = ["아이브로셔", "립밤", "교재"]  <- <String> 생략가능
```



3. **사용가능한 메소드**

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

   ​

   > 2. update : 
   >
   > ![set의 update](http://postfiles12.naver.net/MjAxNzEwMDFfODQg/MDAxNTA2ODU3NjI0MDg0.iygaMdCTzMt4J5vugwmuZJV4P3nWLklKQe_VleMDC3sg.9-9PsefBQuoDtWP-ICvSkN50QHU9VmAuHbJc97Xm74Ug.PNG.bb_9900/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2017-10-01_%EC%98%A4%ED%9B%84_8.32.10.png?type=w2)
   >
   > - 값을 무조건 넣어주게 되어 있다. 즉 이미 set에 있다면 기존값을 대체한다.
   > - ***String?*** 이라는 뜻은 Optional이다. 즉 String일수도 있고, 데이터가 없을 수 있다(nil)는 것
   >
   > - [ ]   **코드스쿼드 가면 물어보기**

   ​

   (2) 특정 항목이 포함되어 있는지 확인

   > contains(_:) 사용

   ```swift
   var groceryBag: Set = ["Apples", "Pineapple", "Orange"]

   let hasApples = groceryBag.contains("Orange")
   let hasPineapple = groceryBag.contains("Watermelon")
   ```

   ​

   (3) 무작위 데이터의 정렬

   > 데이터의 정렬은 .sorted() 메소드를 통해 가능

   ```swift
   var oddDigits : Set = [1, 3, 5, 7, 9].sorted()
   ```



​        (4) 값 제거하기 < 추가예정>



​	(5) 공통요소 제거하기

* > isDisjoint 사용

  ```swift
  let myGroceryBag: Set = ["Apples", "Pineapple", "Orange"]
  let yourGroceryBag: Set = ["Cereal", "Milk", "Toothpaste"]

  let disjoint = myGroceryBag.isDisjoint(with: yourGroceryBag)  
  // true
  ```



4. **set의 집합연산**

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

