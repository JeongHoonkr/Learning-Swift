## JSON문자열 분석기 6단계 v03



##### 핵심리뷰

- 호스트코드에서의 흐름제어는 단순해야 한다.

- 파일의 경로는 내부에 의존하지 않고 외부에 의존하는 것이 좋다.

  ​

##### 1. 메인코드 흐름제어의 개선 (문제코드와 개선코드의 전체코드는 여기를 참고 : [[링크]](https://github.com/JeongHoonkr/Studying-Record/blob/master/Study/CodeSquadLv2%20Project/JSONparser/JSON%206%EB%8B%A8%EA%B3%84%20v02.md))

- 문제점 : if-else흐름제어의 중복
  - 문제의 호스트코드를 보면 구조가 아래와 같다. (많이 생략되어 있다. 자세한 내부 로직은 위를 참고)

> 입력 및 출력시 argument에 따라 InputView와 OutputView에서 분기하던 것이 메인에서 분기되다보니
>
> `콘솔 및 파일 공통으로 내부에서 처리하는 로직` 을 가운데에 놓고 입출력을 위아래로 나눌 수 밖에 없었다.

```swift
while true {
    do {
      // arguments 갯수에 따라 입력받은 방식 구분
        if CommandLine.arguments.count <= 1 {}
        if CommandLine.arguments.count >= 2 {}
        
      // 콘솔 및 파일 공통으로 내부에서 처리하는 로직
      // 01 문법체크
      // 02 JSONType으로 변환
        let validString = try GrammerChecker.makeValidString(values: unanalyzedValue)
        let analyzedValue = Analyzer.makeAnalyzedTypeInstance(validString)
        
      // arguments 갯수에 따라 입력받은 방식 구분
        if CommandLine.arguments.count <= 1 {}
        if CommandLine.arguments.count >= 2 {}
      
      // throw한것들 처리하기 위한 catch문들
    } catch Message.ofEndingProgram {break} 
      catch Message.ofFailedProcessingFile {break} 
      catch let error as Message {print (error)}
```



- 해결 : `콘솔 및 파일 공통으로 내부에서 처리하는 로직`을 Analyzer로 옮겨서 콘솔 및 파일로 나누고 해당함수를 호출

> 콘솔 및 파일이 내부에서 처리하는 로직을 하나의 함수로 if-else문 내부에서 처리하고 throw가 다 사라져 코드가
>
> 간단해졌고 if-else가 위아래 중복해서 나오지 않아 arguments갯수에 따라 흐름을 파악하기가 더 쉬워졌다.

```swift
// 개선된 코드
// if-else 흐름제어를 보면 확연하게 달라져
while true {
    if CommandLine.arguments.count <= 1 {} 
  	else {}
}
```



##### 2. 파일 경로 의존성 개선 

> 파일을 읽고 쓸때 공통으로 내부에서 경로를 생성해서 의존하고 있었는데,
>
> dir은 외부에서 주입해주는 것이 더 좋은 방식이다.

* 기존 : 내부에서 아래 상수를 dir로 사용
  * `let dir = FileManager.default.homeDirectoryForCurrentUser` 
* 개선 : 함수에서 파라미터로 받게 함
  * `static func writeOutputFile(jsonTypeData:, outputFile:, toPath : URL)`
  * ` static func readFromFile(file InputFile: String, fromPath: URL) `