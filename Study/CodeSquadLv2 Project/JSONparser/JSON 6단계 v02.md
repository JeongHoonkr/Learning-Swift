## JSON문자열 분석기 6단계 v02



##### 핵심리뷰

- Error를 쓰는건 리턴값으로 표현하기 어려운 예외적인 상황에서 최소한으로 사용해야 한다.

- 즉 정상적인 흐름이 아니라 더이상 실행할 수 없는 어쩔수 없는 예외상황에서 써야 한다.

  ​

##### 생각했던점

> - 사다리게임 이후 프로그램의 에러처리를 할때마다 Error프로토콜을 채택하게 하고 do-try-catch를 사용해서
>
>   에러처리를 해왔다.
>
> - 그런데 너무 편한나머지 본래의 목적 이외의 처리를 위해서도 사용되고 있었다.
>
> - 특히 이곳 저곳에서 Error를 throw하다보니 if-else로 흐름제어를 한다는걸 감안해도 
>
>   호스트코드에서 try가 5개나 있었는데, 이게 많은건지, 오용은 아닌지에 대한 판단조차 하지 못하고 있었다.



##### 문제의 호스트코드

> 흐름제어가 위아래 나뉘어져 보기 힘든점은 일단 차치하고서라도 try가 여기저기 있고, 프로그램 종료도
>
> Error를 던져 처리하고 있는 것을 볼 수 있다. 심지어 이 종료를 받아 처리하기 위해 catch 코드도 추가되어 있다.

```swift
while true {
    do {
        var unanalyzedValue: String = ""
        // Mark : argument.count에 따른 인풋 분기
        if CommandLine.arguments.count <= 1 {
            unanalyzedValue = try InputView.readFromConsole()
        }
        
        if CommandLine.arguments.count >= 2 {
            let jsonFile = try ProcessInfo.processInfo.arguments.makeFileIOPath()
            unanalyzedValue = try InputView.readFromFile(in: jsonFile.0)
        }
        
        let validString = try GrammerChecker.makeValidString(values: unanalyzedValue)
        let analyzedValue = Analyzer.makeAnalyzedTypeInstance(validString)
        
         // Mark : argument.count에 따른 아웃풋 분기
        if CommandLine.arguments.count <= 1 {
            OutputView.makeConsolResult(analyzedValue)
        }
        if CommandLine.arguments.count >= 2 {
            try OutputView.writeOutputFile(analyzedValue, CommandLine.arguments[1])
            throw Message.ofEndingProgram
        }
    } catch Message.ofEndingProgram {
        break
    } catch Message.ofFailedProcessingFile {
        print (Message.ofFailedProcessingFile.description)
        break
    } catch let error as Message {
        print (error)
}
```



##### 문제의 해결

- 먼저 Error를 던지고 do-try-catch를 써야 하는 기준을 잡아야 했다. 리뷰를 통해 아래와같은 기준을 잡기로 했다. 
  * **다른 방법으로 확인하기 어려워서, 상위모듈에서 동작 흐름을 판단해야 할때**
    * 다른방법의 예 : 옵셔널처리, 기본값 주기, 다시 입력받기 등의 해당 옵셔널 처리해도 된다거나 다시 입력받으면 된다거나 다른 방법이 있을 수 있으면 안써도 된다는 겁니다)
  * 정상 흐름이 아닌 오류 상황인데, 오류의 세부적인 사항을 확인해야 하는 경우
    * 에러 상황별로 꼭 메시지를 나눠서 출력해야 하는데 객체나 값으로 표현하기 어려운 경우 제한적인 경우



* 개선방향

  * 종료조건변경

    * 기존 : quit을 throw하게해서 호스트코드에서 catch해서 프로그램 종료


    * 개선 : 옵셔널벗겨진 값 그대로 반환해서 호스트코드에서 guard문 사용해서 종료처리

      ​

  * 문법체크 후 파일분석값과, 콘솔분석값을 나눠서 함수 내부에서 호출하는 문법체크 함수의 에러 처리방식 변경

    * 기존 : Grammerchcker에서 문법에러시 Error를 throw해서 처리


    * 개선 : 문법 Error시 nil을 반환하게 해서 Guard let문으로 처리

      ​

  * arguments 처리시 에러처리방식 변경

    * 기존 : inputFile과 outputFile로 나누는 처리할때 발생하는 Error를 메인으로 throw해서 처리


    * 변경 : 오류시 에러문구를 내부에서 출력하고 nil반환 호스트코드에서 Guard let 사용

      ​

  * 파일 입력받아 처리시 에러처리방식 변경

    * 기존 : Error를 메인으로 throw해서 처리
    * 변경 : 내부에서 에러문구 출력하고 메인으로 던지지 않음

    ​

  * 파일 출력시 에러처리하는 방식 변경

    * 기존 : Error를 메인으로 throw해서 처리

    * 변경 : 내부에서 메세지 출력하고 Bool값을 리턴해서 메인에서 Guard문으로 처리

      ​          파일생성 성공시 true리턴하고 바로 아래 코드에서 break해서 코드종료, 실패시 false리턴해서 break처리

    ​

```swift
// 개선된 코드
// do catch가 사라져서 메인에서 분기했음에도 불구하고 코드가 더 짧아지고
// while문을 돌리다보니 다양한 조건에서 프로그램이 종료되어야 함에도 불구하고 코드가 길어지지 않았다.

while true {
    var unanalyzedValue: String = ElementOfString.emptyString.description
    let url = FileManager.default.homeDirectoryForCurrentUser
    if CommandLine.arguments.count <= 1 {
        unanalyzedValue = InputView.readFromConsole()
        guard unanalyzedValue != Message.ofEndingProgram.description else { break }
        guard let analyzedValue = Analyzer.makeConsoleAnalyzedResult(unanalyzedValue) else { continue }
        OutputView.makeConsoleResult(analyzedValue)
    } else {
        guard let jsonFile = InputView.makeInOutFile() else { break }
        unanalyzedValue = InputView.readFromFile(file: jsonFile.inputFile, fromPath: url)
        guard let analyzedValue = Analyzer.makeFileAnalyzedResult(unanalyzedValue) else { break }
        guard OutputView.writeOutputFile(jsonTypeData: analyzedValue, outputFile: jsonFile.outputFile, toPath: url) else { break }
        break
    }
}
```

