## JSON문자열 분석기 5단계 v02



##### 핵심 피드백

- Any타입을 다른 타입으로 대체하기



##### 생각했던점

> - 5단계까지 오면서 String, Bool, Int, Object, Array를 담기 위해 여러가지 타입을 담을 수 있는 Any를 썼다.
>
>   그런데 결국 각 타입들이 하는 공통적인 행동들이 있었고, 이 행동을 프로토콜의 메서드로 정의하고,
>
>   각각의 타입이 이를 채택하게 해서 Any를 프로토콜로 대체할 수 있었다.
>
> - 이렇게 수정하니 기존에 함수 내부에서 객체와 배열로 나눠서 결과를 반환할때 if-else로 쓰던것을
>
>   프로토콜 메서드 한줄로 바꿀 수 있었다.
>
> 추상화! 추상화는 3단계부터 해보고 싶었는데, 혼자 생각이 나지 않아서 적용은 못했었다. 이번에 JSON형태 출력하는
>
> 과제를 진행하면서 적용했는데, 나름대로 실체가 있었던 좌표계산기의 삼각형 사각형때와는 다르게 상상속에 있는 출력기능을 추상화하려다 보니 즉 익숙치 않아서 추상화가 머릿속에 그려지지 않았던것 같다.
>
> 또한 실제로 프로토콜과 익스텐션을 코드화하고 기존의 코드에 적용해볼때 어려움이 있었다.



##### 1. 프로토콜 선언하기

* ([5단계 첫구현](https://github.com/JeongHoonkr/Studying-Record/blob/master/Study/CodeSquadLv2%20Project/JSONparser/JSON%205%EB%8B%A8%EA%B3%84.md)) 코드에서 타입갯수 카운팅과 타입형태 출력기능을 프로토콜로 선언해서 배열과 딕셔너리 타입을 확장해서

  적용한것처럼, 각 타입별 공통 행동을 추상화해서 프로토콜 선언 

* 프로토콜에 정의할 공통 메서드 : JSONType

  * **형변환 기능** : 스트링으로 들어온 값을 String, Bool, Int, [String], [String:JsonType]로 바꿔주는 메서드

    `func getJsontype () -> JSONType`

  * 각 타입별 값을 **객체와 배열속에서 JSON형태로 각값이 출력되게 하는 메서드**

    `func makeValueFromObject () -> String`

    `func makeValueFromArray () -> String`



##### 2. 각 타입에 1번 프로토콜을 채택하게 하기

* [채택한 코드](https://github.com/JeongHoonkr/swift-jsonparser/blob/1d785c53dbe3bd46f26423cae775a6c708f04c4b/JSONParser/JSONParser/JsonCommon.swift) (Protocol선언 후 각 타입을 extention한 페이지)

> 기존에 채택하기 전에는 객체와 배열내부의 값을 JSON형태로 출력되게 하기 위해 if-else로 타입별로 구현을 해줬었다.
>
> 아래처럼 각 타입별로 하는 행동을 각 타입을 extention해서 내부에 구현을 해주는 것이다.
>
> 이 부분은 5단계에서 처음 프로토콜을 쓸때처럼 쉽게 추상화할 생각을 못했던 부분이었다.



**2-1. 채택 후 코드 변화**

> 메서드의 기존 Any타입을 모두 JSONType으로 변경하고 각 타입이 채택한 메서드를 활용하여 if-else코드 간소화

```swift
// Any타입을 JSONType으로 확장하기 전 if - else
 
 if $0 is String {
             result += insertIndentation() + String(describing: $0) + "," + makeNewLine()
            } else if let jsonObjectType = $0 as? Dictionary<String,Any> {
                result += makeObjectTypeForPrinting(jsonObjectType) + "," + makeNewLine()
            } else if let arrayTypeInArray = $0 as? Array<String> {
                result += makeArrayTypeForPrinting(arrayTypeInArray)
            } else {
                result += String(describing: $0)
}

// 각 타입 extention 후 코드는 아래처럼 한줄로 가능해졌다.
result += $0.makeValueFromArray()
```

* 5단계 v01 코드와 동일하게 extention사용시 주의점을 남긴다.

> 확장시 주의할 점 : 기존에 있는 타입을 확장할 때 주의할 점은 기존의 있는 기능과 충돌이 나거나, 겹치거나, 비슷하거나, 기존에 사용하던 기능에 영향을 미칠 수 있는지 고려해야 합니다. (다행히 스위프트는 extension으로 덮어쓰는건 안되지만 주의할 필요가 있어요) - 출처 : JK의 jack리뷰 -



##### 3. 뒤늦게 발견한 문제점

 (1) String값을 배열데이터로 변환하여 반환할때 [JSONType]이 아니라 [String]으로 반환하고 있었다.

> `String, Bool, Int, [String], [String:JsonType]` 각 타입들을 프로토콜로 추상화 해놓고, 배열 및 객체에
>
> 담아놓고서는 **실제로 배열 데이터가 생성될때 내부의 모든 타입은 String이었던 것**이다......... ㅡ,.ㅡ ....... 이걸 뒤늦게 알았다......

```swift
// 아래 함수는 중첩배열을 포함한 배열에서 String값을 정규식 문법에 맞게 각 값을 뽑아서 배열로 반환하는 함수인데
// 이것만 만들어 놓고 배열 데이터로 변환하고 있다고 생각하고, 내부의 타입도 모두 각자 자기의 타입을 갖고 있다고 생각했던 것이다.
private static func getJsonArray(_ inputValue: String) -> Array<String> {
        var elementsFromArray : Array<String> = []
        var initialValue = inputValue
        initialValue = removeFirstAndLastCharacter(initialValue)
        elementsFromArray.append(contentsOf: getObjectOfArray(from: initialValue))
        initialValue = removeMatchedObjectfromString(from: initialValue)
        elementsFromArray.append(contentsOf: getArrayOfArray(from: initialValue))
        initialValue = removeMatchedArrayfromString(from: initialValue)
        elementsFromArray.append(contentsOf: getValueFromArray(from: initialValue))
        return elementsFromArray
}
```



 (2) 객채 내의 벨류를 생성할때  밸류 타입이 배열이면 들어온 String 그 자체를 반환해버리고 있었다.

```swift
func generateValueInObject(stringNotyetValue: String) -> JSONType {
  // 중략
		if stringNotyetValue.hasPrefix("[") && stringNotyetValue.hasSuffix("]") { return stringNotyetValue }
  // 중략
}
```



##### 3-1. 문제해결

> * `Array<String>` 이 아니라 `Array<JSONType>`을 반환하는 함수
>
>   3-(1) 의 ``getJsonArray``의 이름을 `getJsonElementArray` 로 바꾸고 해당이름으로 구현

```swift
private static func getJSONArray(elements: Array<String>) -> [JSONType] {
        var jsonArray = [JSONType]()
        for element in elements {
            jsonArray.append(getEachValue(stringNotyetValue: element))
        }
        return jsonArray
}
```



> 아래 코드의 `getEachValue {}` 함수는 3-(2) 코드를 해결하면서 새로 보완한 함수로 객체와 배열 모두 사용한다.
>
> - String타입을 본래 타입으로 형변환해서 딕셔너리의 벨류, 배열의 값으로 반환

```swift
 private static func getEachValue(stringNotyetValue: String) -> JSONType {
        if stringNotyetValue.hasPrefix("[") && stringNotyetValue.hasSuffix("]") { return getJSONArray(elements: getJsonElementArray(stringNotyetValue)) }
        else if stringNotyetValue.hasPrefix("{") { return getJsonObject(stringNotyetValue)}
        else if stringNotyetValue.starts(with: "\"") { return stringNotyetValue.replacingOccurrences(of: "\"", with: "")}
        else if let interger = Int(stringNotyetValue) { return interger }
        else if let boolean = Bool(stringNotyetValue) { return boolean }
        else { return ""}
}
```

