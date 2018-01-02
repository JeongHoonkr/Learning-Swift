## JSON문자열 분석기 4단계



##### 요구사항 

- 중첩된 형태 JSON 객체(object) 문자열을 입력하면 내부 요소들을 분석해서 배열 또는 사전(Dictionary)으로 저장하도록 구현한다.
  * JSON 값(value)에 포함될 수 있는 데이터도 배열, 객체, 문자열(String), 숫자(Number), 부울 true/false(Bool) 모두 가능하다고 가정한다.

  ​

##### 어려웠던 점

> 4단계 구현에 있어서 가장 어려웠던 점은 프로그램이 자꾸 꺼졌던 부분이다. 에러를 내면서 빌드가 안되거나, 빌드는 되는데
>
> 원하는대로 돌아가지 않는 문제가 아니었고, 그냥 특정 기호 "["를 입력했을 때 프로그램이 꺼졌었다. 문제의 원인이  
>
> JSON이었는데 JSON을 다시 하나씩 수정해보는 과정에서도 꺼져서 스트레스가 많았다.
>
> 그래서 그런지 다른 어려웠던 부분들도 상대적으로 쉽게 느껴졌다.

> 전체적인 구조가 과제의 의도와 맞지 않아, 객체간의 관계나 역할을 다시 설정해서 코드의 전체적인 얼개를 다시 짜야했는데
>
> 이 부분은 어렵지 않게 진행했다.
>
> 습관화하려고 하지만 사실 첫단계부터 하게되지는 않는다. 분명 고쳐야할 점이다.



##### 리뷰받은 내용

**(1)** 과제의 1차목표는 **문자열로 입력 받은 JSON 데이터를 스위프트 Array나 Dictionary 데이터 구조로 바꾸는 것** 이었다.

  1) 그래서 Analyzer의 역할에 대해 다시 고민하면서 전체적인 얼개를 다시 설계해보게 됐다.

  2) 3단계부터 Analyzer가 두가지 역할을 하고 있다는점을 느꼈지만 *구조를 바꾸는 것에 대한 두려움*이 있어서

​      시도해보지 않았었다. 하지만 실제로 부딪혀보니 프로그램이 꺼지는것만큼의 어려움내지 스트레스는 없었다.



> 리뷰받기전 구조

 1) InputView (인풋값 받는 역할)

 2) JsonGrammerRule (정규식문법을 static타입 속성으로 갖고있는 역할)

 3) JsonGrammerChecker (인풋값이 정규식 문법에 맞는지 확인하는 역할)

 4) CountingData (카운팅 갯수 데이터를 private하게 갖고있으며 객체 및 배열타입 생성자로 초기화하는 역할)

 5) Analyzer (입력된 인풋값을 배열 및 객체데이터로 변환해서 타입별 갯수를 확인해서 CountingData로 리턴해주는 역할)

 6) OutputView (출력하는 역할)

 7) main (호스트)



> 개선한 구조

 1-4) 기존과 동일

**CountingJsonData와 Analyzer로 분리**

 5) CountingJsonData (타입별 갯수를 카운팅해서 CountingData를 반환하는 역할)

 6) Analyzer (입력된 인풋값을 배열 및 객체데이터로 변환해서 반환하는 역할)

 7) 기존과 동일

 8) 호스트 코드 상에서도 Analyzer가 만든 객체가 보여지고, CountingJsonData로 넘기는 형태가 보이도록 수정



**(2)** **굳이 생성하지 않아도 되는 [Any] 배열을 만들었었다.**

 1) 이 이유는 딕셔너리 데이터타입을 거의 쓰지 않아서 딕셔너리에 대한 이해가 부족했기 때문이다. 

 2) 처음에 딕셔너리 형태 [String:String]만 보고 딕셔너리 데이터 하나하나가 배열에 들어있는줄 알고

​     **딕셔너리 데이터가 2개 이상이면 배열에 넣고 써야하는 줄 알았다.** 그런데 딕셔너리이니 Any로 내부타입이 되어야 하나?

​     하는 막연한 생각을 했던것 같다.

 3) 딕셔너리가 배열형태인것은 맞지만 각각의 데이터는 배열안에서 콤마로 구분이 된다.

```swift
// 예시
["power" : "middle", "isHuge" : "huge", "population" : "das", "hasNuclear" : "sdd"]
```

.     

**(3) 여전한 배열 데이터 타입의 큰 고민없는 사용**

 1) 문자열, 숫자, 부울 타입의 갯수를 카운팅할때 배열에 넣고, 그 배열의 Length를 카운팅했다. 여전히 배열 데이터타입을

​     자주 다뤄서 그런지 다른 타입을 쓸수는 없을까라는 생각보다. 일단 배열을 써보고 배열로 되면 그냥 넘어가는것 같다.

> 아래처럼 해결! 인트형 변수를 선언해서 형변환이 성공될때마다 +1 하는 방법도 있다.

**특정 데이터타입을 사용할때 어떤 이유로 선택했는지 타인에게 논리적으로 설명할 수 있도록 충분히 생각하고 사용하자**

```swift
 private static func getCountedArrayType(_ stringValues: String) -> JsonData {
       var countOfNumber: Int = 0
       var countOfBool: Int = 0
       var countOfString: Int = 0
       var countOfObject: Int = 0
       var countOfofArray: Int = 0
        let elementsOfArray = Analyzer.makeJsonArray(with: stringValues)
        _ = elementsOfArray.forEach {
            if $0.hasPrefix("{") && $0.hasSuffix("}") { countOfObject += 1}
            else if $0.hasPrefix("[") && $0.hasSuffix("]") { countOfofArray += 1 }
            else if let _ = Int($0) { countOfNumber += 1}
            else if let _ = Bool($0) { countOfBool += 1}
            else if  let firstString = $0.first, firstString == "\"" {countOfString += 1}
        }
return JsonData(countOfNumber, countOfBool, countOfString, countOfObject, countOfofArray)
```



**(4) do catch 대괄호 안에는 try하는 구문 및 직접관계있는 코드만 넣어야 한다.**

> do-try-catch는 딱 필요한 흐름만 컨트롤하도록 범위를 잡아야 한다.

 1) 수정후 실수한점 : 아래코드는 돌아가긴 하지만 주석부분을 입력하지 않으면 의도한대로 돌아가지 않는다. 

​      while구문에 넣은 이유는 문법체크가 실패했을때 반복입력이 가능하게 하려고 했던건데, 반복입력이 되지 않았다. 

​      catch해서 에려가 발견될경우에 종료되는 형태였는데 이를 `fall-through`라고 한다.

​      주석 부분의 continue를 입력해야 의도한대로 작동한다.

```swift
while true {
    let unanalyzedValue = InputView.read()
    if unanalyzedValue == "quit" { break }
    var validString: String = ""
    do {
        // 문법체크
        validString += try GrammerChecker.makeValidString(values: unanalyzedValue)
    } catch let error as GrammerChecker.ErrorOfJasonGrammer {
        print (error.localizedDescription)
        // continue 코드 추가 필요
    }
    // 분석된 Json 타입인스턴스 생성
    let analyzedValue = Analyzer.makeAnalyzedTypeInstance(validString)
    // Json타입 카운팅
    let countedValue =  CountingJsonData.makeCountedTypeInstance(analyzedValue)
    // 카운팅 출력
    OutputView.printResult(countedValue)
}
```

