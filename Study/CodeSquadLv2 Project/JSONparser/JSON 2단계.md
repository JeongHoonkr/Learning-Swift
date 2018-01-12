## JSON문자열 분석기 2단계



##### 요구사항 

- 1단계 유지하면서 단순한 JSON 객체(object) 문자열을 입력하면 내부 요소들을 분석해서 사전(Dictionary)으로 저장하도록 구현한다.

- SON 내부 요소를 사전(Dictionary)에 저장하고 문자열, 숫자, 부울 요소의 개수를 출력한다.

  단, JSON 배열 내부에는 객체가 포함될 수 있다고 가정한다.

  ​

##### 어려웠던 점

> 정규식표현 보다 정교화 : 단순히 대괄호만 체크하던 것에서 타입들을 체크하도록 하는 과정



##### 사용해봤던 문법들

(1) `forEach` 

> for in loop와 유사한 형태로 작동하며 map의 작동방식과도 동일하다. 그러나 map과의 차이점은 map은 리턴하는 배열을 사용할 경우 사용하며, 리턴 배열을 사용하지 않을 경우 forEach를 사용하고 리턴배열은 와일드카드를 지정한다.
> 리턴배열을 상수나 변수로 지정할 경우 아래 경고를 보게 된다.
>
> **Constant '(지정한 상수나 변수)' inferred to have type '()', which may be unexpected**
> 즉 지정된 상수나 변수가 보이드 타입을 리턴받는 다는 뜻이다.

```swift
// 기존 map사용 코드 : 리턴하는 배열을 사용하지 않아 와일드카드 지정 

_ = stringValues.map {
            if $0.starts(with: "{") { objects.append(generateObject(items: generateObjectElements($0))) }
            if let integer = Int($0) { numberValue.append(integer)}
            if let boolean = Bool($0) { boolValue.append(boolean)}
            if $0.starts(with: "\""){ stringValue.append($0)}
}

// forEach사용해서 와일드카드까지 제거
 stringValued.forEach {
            if $0.contains("{") { objects.append($0) }
            if let integer = Int($0) { numberValue.append(integer)}
            if let boolean = Bool($0) { boolValue.append(boolean)}
            if $0.starts(with: "\""){ stringValue.append($0)}
}
```

(2) `filter`

> 공백제거를 위해 whitespacesAndNewlines와 whitespace를 사용했으나 정교하게 제거되지 않아 아래처럼 수정
>
> **입력된 스트링 내부의 모든 공백 제거**

```swift 
private static func findJsonString (from validString: String) -> String{
        let splitted = validString.filter { $0 != " " }
        return splitted
}
```





##### 리뷰받은 내용

(1) 아직도 파라미터로 배열을 큰 고민업이 넘기고 있었다.

> 아래는 문자열을 타입에 따라 분류한뒤 카운팅을 하는 생성자이다.
>
> 굳이 배열을 넘기지 않고 그 이전단계의 함수에서 배열을 생성해서 카운팅할 인트값만 넘길 수도 있었다.

```swift
// 최초 배열을 넘기는 코드
init (ofNumericValue: [Int], ofBooleanValue: [Bool], ofStringValue: [String], total: Int) {
    self.type = CountingType.object
    self.ofNumericValue = ofNumericValue.count
    self.ofBooleanValue = ofBooleanValue.count
    self.ofStringValue = ofStringValue.count
    self.total = ofStringValue.count + ofBooleanValue.count + ofNumericValue.count
}
    
// 인트를 넘기도록 리팩토링
init (ofNumericValue: Int, ofBooleanValue: Int, ofStringValue: Int, total: Int) {
    self.type = CountingType.object
    self.ofNumericValue = ofNumericValue
    self.ofBooleanValue = ofBooleanValue
    self.ofStringValue = ofStringValue
    self.total = ofStringValue + ofBooleanValue + ofNumericValue
}
    
```

