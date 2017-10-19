## substring



#### 1. 정의

- 문자열을 생성할때 하위문자열(부분열?)을 생성한다.
- 하위문자열은 본래의 문자열과 같은 저장소를 사용하기 때문에 하위문자얄의 작동은 빠르고 효율적이다.
- 문자열과 하위문자열은 동일한 인터페이스를 제공하기 때문에 문자열의 내용을 복사하거나 지연?시킬수 있다.



#### 2. 기본적인 사용

```swift
let greeting = "Hi there! It's nice to meet you! 👋"
let endOfSentence = greeting.index(of: "!")!
let firstSentence = greeting[...endOfSentence]
// firstSentence == "Hi there!"
```



#### 3. substring의 다양한 함수는 아래링크를 참조하자

- 내가 사용해본 함수

> ```index(of: )``` 메소드와 삼항연산자
>
> ```prefix(upTo: )``` : [원문](https://developer.apple.com/documentation/swift/string/2893967-prefix)
>
> ```trimmingCharacters(in: )``` <— 이거는 stringProtocol임



#### 4. substring과 stringprotocol의 차이

>문자열을 처리하는 데이터 타입은 String 인데 핵심적인 기본 기능은 Struct String 에 구현해놓고, Substring은 문자열 중에 일부분만 접근할 때 사용하는 타입이고, StringProtocol은 기본 기능 외에 부가 기능들을 모아놓고 따로 구현한 함수들입니다.



#### 5. substring 사용

**```endIndex```** 의 정의

![d](http://postfiles12.naver.net/MjAxNzEwMTlfMjU3/MDAxNTA4NDAxMTkzOTYy.pOnpvUWSswqijhQf5KCURVXRVKXnIIkEdVJ-InNCRLEg.z4foMADkHiCYh9DsS7ZVVfj3eIzsE6gnhJJf4bFpccEg.PNG.bb_9900/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2017-10-19_%EC%98%A4%ED%9B%84_5.19.04.png?type=w773)

```swift
// 천재 정훈을 상수로 선언
let someString = "Genius JeongHoon!"

// 공백을 추출
var whiteSpace = someString.index(of: " ") ?? someString.startIndex

// 중간문자 제거후 합치기
someString.components(separatedBy: [" "]).joined()

// 문자열 subscript활용하여 앞문자열 뺴오기
var frontofSomeString = someString[someString.startIndex..<whiteSpace]

// 문자열 subscript활용하여 뒷문자열 뺴오기
/*
 someString.endIndex는 전체 길이에 +1 인거 같습니다
 var strTest =“12345”
 strTest.count 하면 5가 나오는데 갯수는 5개이고 endIndex도 그대로 사용하는 대신 0부터 시작해서 0..<5 해서 다 출력되는게 아닌가 싶네요
 */
var rearofSomeString = someString[someString.index(after: whiteSpace)..<someString.endIndex]
print (rearofSomeString)


let exampleString: String = "!!!!@@@@"
exampleString.trimmingCharacters(in: ["!","@"])
print(exampleString) // 출력결과 = 
```



