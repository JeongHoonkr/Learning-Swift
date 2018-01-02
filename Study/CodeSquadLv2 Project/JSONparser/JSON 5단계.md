## JSON문자열 분석기 5단계



##### 요구사항

* 변환한 문자열은 [JSON 문법 검사 사이트](https://jsonlint.com)처럼 배열은 한 줄로 붙여서 표현하고, 객체는 키-값을 다음줄로 내려서 표현한다.

```swift
// 프로그램 안내 문구
분석할 JSON 데이터를 입력하세요.

// 실제 입력값 예시
{ "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "children" : ["hana", "hayul", "haun"] }

// 입력값이 카운팅되어 출력되는 예시
총 4개의 객체 데이터 중에 문자열 3개, 숫자 1개, 배열 1개가 포함되어 있습니다.

// 본과제 : 콘솔에 아래처럼 출력되어야 함
{
    "name": "KIM JUNG",
    "alias": "JK",
    "level": 5,
    "children": ["hana", "hayul", "haun"]
}
```



##### 어려웠던 점

> 처음 PR보낼때는 5단계는 구성이 어려웠고, 콘솔에 요구사항대로 출력하는것도 어려웠다. 아직 텍스트를 자유롭게 다루지 못해서 그런것 같다.
>
> 추상화! 추상화는 3단계부터 해보고 싶었는데, 혼자 생각이 나지 않아서 적용은 못했었다. 이번에 JSON형태 출력하는
>
> 과제를 진행하면서 적용했는데, 나름대로 실체가 있었던 좌표계산기의 삼각형 사각형때와는 다르게 상상속에 있는 출력기능을 추상화하려다 보니 즉 익숙치 않아서 추상화가 머릿속에 그려지지 않았던것 같다.
>
> 또한 실제로 프로토콜과 익스텐션을 코드화하고 기존의 코드에 적용해볼때 어려움이 있었다.



##### 리뷰받은 내용

**(1)** 문자열 문구를 직접 하드코딩하지 않는 방법 고민하기

  1) 콘솔로 작업하고 InputView를 만들면서 의례적으로 프로그램 시작문구를 문자열로 직접 코딩했었다.

  2) enum을 사용하면 아래처럼 하드코딩하지 않고 개선할 수 있다.

  2) 3단계부터 Analyzer가 두가지 역할을 하고 있다는점을 느꼈지만 *구조를 바꾸는 것에 대한 두려움*이 있어서

​      시도해보지 않았었다. 하지만 실제로 부딪혀보니 프로그램이 꺼지는것만큼의 어려움내지 스트레스는 없었다.



```swift
struct InputView {
     enum FrontMessage {
        case ofWelcoming
        case ofEndingProgram
        var description: String {
            switch self {
            case .ofWelcoming :
                return "분석할 JSON 데이터를 입력하세요. quit입력시 종료됩니다"
            case .ofEndingProgram :
                return "quit"
            }
        }
    }
    static func read() -> String {
        print (FrontMessage.ofWelcoming.description)
        if let unanalyzedValue = readLine() {
            guard unanalyzedValue == FrontMessage.ofEndingProgram.description 
          else { 				
            return unanalyzedValue 
          }
        }
        return FrontMessage.ofEndingProgram.description
    }
}
```



(2) if-else구문 없애기 ( = 추상화 하기 )

 1) 기존 코드

> 문자열을 배열과 객체 형태의 데이터타입으로 변환해놓고 Any배열에 담아서 아래함수 인자로 넘어오고
>
> if-else를 사용해서 배열과 딕셔너리 타입으로 형변환해서 각각에 해당하는 프린트 함수를 불러오는 방식이었다.

 ```swift
static func makeJsonTypeforPrinting(jsonType: Any) -> String{
      if let jsonObjectType = jsonType as? Dictionary<String,Any> {
          return  makeObjectTypeForPrinting(jsonObjectType)
      } else {
          return  makeArrayTypeForPrinting(jsonType as! Array<String>)
      }
 ```



 2) 개선된 코드

> **프로토콜 사용 공통메서드 추상화**
>
> - 타입갯수 카운팅, 타입형태 출력기능을 추상화한 프로토콜 선언

```swift
// 출력 데이터 추상화 (카운팅 및 Json타입 형태)
// 객체 및 배열이 공통적으로 사용하는 메서드를 기준으로 추상화했다. 
protocol JsonDataCommon {
    func readyforPrinting () -> String
    func getCountedType () -> JsonData
}
```



> **Array와 Dictionary를 확장**
>
> * 특히 확장 부분은 생각을 했었는데 처음에 바로 안됐던 이유가 **``self as!`` 형태로 쓸 수 있다는 점**을 생각못했기
>
>   때문이다.

```swift
// 딕셔너리 데이터타입 자체를 확장해서 위의 프로토콜을 채택하게 했다.
extension Dictionary: JsonDataCommon {
    func getCountedType() -> JsonData {
        return CountingJsonData.getCountedObjectType(self as! Dictionary<String, Any>)
    }
    
    func readyforPrinting() -> String{
        return JsonPrintingMaker.makeObjectTypeForPrinting(self as! Dictionary<String, Any>)
    }
}

extension Array: JsonDataCommon {
    func getCountedType() -> JsonData {
        return CountingJsonData.getCountedArrayType(self as!  [String])
    }
    
    func readyforPrinting() -> String{
        return JsonPrintingMaker.makeArrayTypeForPrinting(self as! [String])
    }
}
```



> 위 프로토콜과 익스텐션의 사용
>
> * 첫째 **프로토콜을 함수의 인자로 사용할 수 있다**. 함수의 인자로 넘겨서 해당 인자를 사용할때 점을 찍어서
>
>   메서드를 호출해서 사용할 수 있다. 
>
> * 또한 이미 Array와 Dictionary를 extension해서 위 프로토콜을 채택해놓았고 해당 타입의 세부데이터를 및 사용될 메서드도 명시해놓았기 때문에 기존 코드처럼 if-else로 구분할  필요가 없고 형변환할 필요가 없다.!

**타입별 갯수 출력 부분 함수 호출부 리팩토링**

```swift
// 기존 if-else 코드
static func makeCountedTypeInstance (_ input: Any) -> JsonData {
        switch input {
        case is Dictionary<String,Any> :
            return getCountedObjectType(input as! [String : Any])
        default:
            return getCountedArrayType(input as! [String])
        }
}

// 추상화 사용 리팩토링된 코드
    static func makeCountedTypeInstance (jsonType: JsonDataCommon) -> JsonData {
        return jsonType.getCountedType()
    }
```



**타입별 JSON형태로 출력 함수 호출부 리팩토링**

```swift
 // 기존 if-else코드
static func makeJsonTypeforPrinting(jsonType: Any) -> String{
       if let jsonObjectType = jsonType as? Dictionary<String,Any> {
           return  makeObjectTypeForPrinting(jsonObjectType)
       } else {
           return  makeArrayTypeForPrinting(jsonType as! Array<String>)
       }
}

// 추상화 사용 리팩토링된 코드
static func makeJsonTypeforPrinting(jsonType: JsonDataCommon) -> String {
        return jsonType.readyforPrinting()
}
```

