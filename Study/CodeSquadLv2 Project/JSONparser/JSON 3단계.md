## JSON문자열 분석기 3단계



##### 요구사항 

- 사용자가 입력한 JSON 데이터 문자열 문법 검사를 담당하는 GrammarChecker 구조체를 추가한다.

- JSON 표준 문법에 맞는지 검사한다.

- 현재 지원하는 기능들 외에 구조에 대해서도 판단하도록 구현한다.

  - 예를 들어, JSON 객체 내에 배열이나 객체가 중첩해서 포함된 경우는 걸러낸다.
  - 스위프트 파운데이션에 포함된 정규 표현식 담당 클래스를 활용한다.

  ​

##### 어려웠던 점

> 정규식 표현은 1-2단계에서 써와서 구성상 특별히 어려웠던 점은 없었다.
>
> 다만 3단계부터 테스트케이스를 하게됐는데, 테스트설계(?)라고 해야할까. 아직 테스트코드 짜는것은 익숙치 않다.
>
> 습관화하려고 하지만 사실 첫단계부터 하게되지는 않는다. 분명 고쳐야할 점이다.



##### 사용해봤던 문법들 (리뷰받은 내용)

(1) 옵셔널체이닝 사용 

> 강제언래핑이 좋지않다는 것은 인지하고 있지만 코드를 짜다보면 돌아가게 하는데 급급한것 같다.

```swift
// 강제언래핑
else if  $0.first! == "\"" {stringValue.append($0)}

// 옵셔널체이닝을 사용해서 언래핑
else if  let firstString = $0.first, firstString == "\"" {stringValue.append($0)}
```



(2) `hasPrefix` 와 `hasSuffix` 사용 

```swift
// 복잡해보였던 기존 코드
if $0.starts(with: "{") && $0[$0.index(before: $0.endIndex)] == "}" { objects.append($0) }

// hasPrefix, hasSuffix사용해서 직관적으로 바뀐 코드
if $0.hasPrefix("{") && $0.hasSuffix("}") { objects.append($0) }
```



(3) enum의 localizedDescription 사용

> 사다리 게임에서 처음 Error프로토콜을 enum에 채택해서 String 로벨류로 에러를 나타냈던것 같다.
>
> 그런데 실제 서비스를 하게 되면 다국어 서비스가 될 수도 있고, 여러가지 케이스르 번갈아가며 표시하게 될 수 있기 때문에 
>
> 코드에 바로 하드코딩하지 않고 localizedDescription을 써보라는 리뷰를 받게 되었다.

```swift
// 기존코드
struct SyntaxChecker {
    enum ErrorMessage: String, Error {
        case ofInvalidInput = "입력값이 유효하지 않습니다."
      
// localizedDescription 사용
struct GrammerChecker {
  	// 열거형 이름으로는 어떤 에러인지 나타낼 수 있는 용어가 좋다. 
    enum ErrorOfJasonGrammer:  Error {
        case invalidFormat
        var localizedDescription: String {
            switch self {
            case .invalidFormat :
                return "입력형식에 맞지 않습니다."
        }
    }
    // ... 코드 중략 ...
}
```

