## JSON문자열 분석기 1단계



##### 요구사항 

* 각 객체의 역할과 책임 구분
* 메소드 분리
* JSON데이터 문자열을 입력하는 InputView구조체 추가
* 단순한 JSON배열 문자열을 입력받아 내부요소들을 타입별로 분석해서 배열로 저장해서 배열 카운팅



##### 어려웠던 점

> NSRegularExpression을 처음 사용해보려고 하니 해당내용을 이해하고 쓰는데에 어려움이 있었다.
>
> 그리고 아직까지는 과제의 첫시작이 어려운 편이다.



##### 사용해봤던 문법들

(1) `if let _` : 옵셔널 바인딩시 사용

> 형변환시 생성된 상수를 사용하지 않을때 와일드카드 *-* 형태로 선언할 수 있다.

```swift
for value in stringValues {
            if let _ = Int(value) { countOfNumber += 1 }
            if let _ = Bool(value) { countOfBool += 1 }
            if value.contains("\"") { countOfString += 1 }
}
```



(2) [NSRegularExpression](https://developer.apple.com/documentation/foundation/nsregularexpression) 

> 정규표현식 일명 "regex", 특정한 패턴을 지정하는 문자열 또는 시퀀스이다.
>
> 아래처럼 `let jsonPattern = "\\[{1}.*,*\\]{1}?"`  이런 패턴을 지정할 수 있다.
>
> **NSRegularExpression**인스턴스를 생성하면 해당클래스의 다양한 메서드를 사용할 수 있다.
>
> 아래는 [matches](https://developer.apple.com/documentation/foundation/nsregularexpression/1412446-matches)를 사용하였다.

```swift
 private static func checkIsValidForJson (_ stringValue: String) throws -> Bool{
        let jsonPattern = "\\[{1}.*,*\\]{1}?"
        do {
            let regex = try NSRegularExpression(pattern: jsonPattern)
            let results = regex.matches(in: stringValue, range: NSRange(location: 0, length: stringValue.count))
            return !results.isEmpty
        } catch {
            throw error
        }
}
```



(3) read-only computed property사용

> 카운팅된 타입의 총합을 구하기 위해 사용

```swift
struct CountingData {
    private (set) var countOfNumericValue: Int
    private (set) var countOfBooleanValue: Int
    private (set) var countOfStringValue: Int
    var countOfTotalValue: Int {
        return self.countOfNumericValue + self.countOfBooleanValue + self.countOfStringValue
    }
}
```