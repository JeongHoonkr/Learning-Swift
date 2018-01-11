## JSON문자열 분석기 6단계 v01



##### 생각했던점

> - 6단계를 진행하면서 어려웠던 점은, **파일을 어떻게 입력받을 것인가** 부터였다.
>
>   지금 생각해 보면 이 부분에 대한 고민과 이해는 문자열 분석기 과제 전체를 해결하는 열쇠였던것 같다.
>
> - 역시 검색이 가장 중요한데 첫 검색은 *read and write file in swift* 였다.
>
> - 파일을 입력받는 방법과 관련해서는 두가지 방법이 있었다. 
>
>   [CommandLine](https://developer.apple.com/documentation/swift/commandline)
>
>   [ProcessInfo](https://developer.apple.com/documentation/foundation/processinfo)
>
>   * CommandLine은 스위프트 표준 라이브러리의 일부분이고, arguments와 arguments count만 제공한다.
>
>   * ProcessInfo는 스위프트라는 언어의 일부분이 아니고, Foundation 프레임워크의 한 부분이다. 본 과제상에서 둘중 어떤것을 사용해도 결과는 같지만 ProcessInfo로는 할 수 있는 작업이 더 많다.
>
>   * 하지만 단지 arguments만이 필요하다면 CommandLine을 쓰는것이 낫다. 그 이유는 더 단순하고, 추가적인 프레임 워크에 의존하지 않으며, 다른 스위프트 런타임에 더 적용이 용이하기 때문이다.
>
>     ​
>
> - 입력받은 파일을 내부에서 접근하고 사용하는 방법도 두가지 방법을 찾았다.
>
>   * 내가 이해한대로 정의를 적어봤다.
>   * 그리고 과제에서 사용은 Filemanager를 썼다.
>
>   [Bundle](https://developer.apple.com/documentation/foundation/bundle) : 애플리케이션 프레임워크, 플러그인, 앱관련 이미지나 파일 이렇게 앱과 직접적으로 관련되어져서 설명
>
>   [Filemanager](https://developer.apple.com/documentation/foundation/filemanager) : FileManager는 그것보다 좀 더 전반적(?)으로 파일이랑 데이터가 시스템에 분산돼있을때 앱이 파일과 폴더에 대해 검색하고, 읽고 쓰는것을 도와주는(?) 것 



##### 사용했던 표현, 문법

##### 1. arguments

* arguments는 입력값을 받으면 문자열 배열 타입으로 지정되며, 배열이기 때문에 카운팅이 가능하고, 인덱스 번호로 접근이 가능하다. 
* **주의할점은 일단 프로그램이 돌아가기 시작하면 무조건 카운팅1을 잡아먹는다는 점이다.**
  * 처음에 이부분을 이해하지 못해서, 파일생성 및 실패때 문구가 출력되게 했는데 무한출력되는 현상이 있었다.
  * 이를 해결하기 위해 파일 생성 및 실패시 다시 입력하게 하지 않고, 프로그램이 종료되게 만들었다.

- JSON입력을 위해서는 터미널에 아래와 같이 입력하게 된다. 

  ` ./JSONParser jsonFile.json testResult.json`

  * **./JSONParser** : JSON프로그램을 실행 
  * **jsonFile.json** : 읽어들일 파일
  * **testResult.json** : 저장할 파일 (존재하지 않은 파일일 경우 생성, 기존에 있는 파일일 경우 덮어쓰기)

- 위 항목은 코드상에서 arguments[0], arguments[1], arguments[2]의 인덱스값으로 접근할 수 있다.



##### 2. String.[init(contentsOf url: URL, encoding enc: String.Encoding) throws](https://developer.apple.com/documentation/swift/string/1643310-init?changes=latest_minor)

> 파일을 읽어들이기 위해 경로로 들어가서 해당 파일을 읽는데 사용했다.

- contentsOf 파라미터는 URL타입의 값을 인자로 받는다. 따라서 해당 위치에는 파일경로가 들어오는데 타입이 URL이어야 한다.  
  * 파일명과 경로는 문자열로 처리하는 방법과 URL규격으로 처리하는 방법이 있는데, 이는 보다 아래에서 적도록 하겠다.
  * URL규격의 파일을 받으면 URL클래스가 갖고있는 `appendingPathComponent` 메서드를 사용해서 파일을 덧붙혀줘야 한다.
  * 그렇게 해서 String으로 감싸서 리턴하면 기존에 콘솔로 분석할 문자열을 입력받는것과 동일한 로직을 타게된다.
- encoding 파라미터는 해당규격으로 문자열을 해석하는 것이다.
- 이 표현은 에러를 던지기 때문에 이를 처리하기 위한 코드도 넣어줘야 한다.

```swift
// 위 내용을 구현한 코드
static func readFromFile(file InputFile: String, fromPath: URL) -> String {
        var textFromFiles: String = ElementOfString.emptyString.rawValue
        do {
            textFromFiles = try String(contentsOf: fromPath.appendingPathComponent(InputFile), encoding: .utf8)
        } catch {
            print (Message.ofFailedProcessingFile)
        }
        return textFromFiles
    }
```



##### 3. [func write(to url: URL, atomically useAuxiliaryFile: Bool, encoding enc: String.Encoding) throws](https://developer.apple.com/documentation/foundation/nsstring/1407654-write)

> 파일을 쓰고 저장하기 위해 사용

* 파라미터 및 내부 작동은 위와 유사하게 작동한다.



##### 4. URL과 String규격

> * 파일 및 경로로의 접근 및 이후 작업을 위해 두가지 선택지가 있는데 **[애플은 공식문서에 URL규격을 사용할 것을 권장]()**
> * URL은 URL규격 생성후 해당 변수로 URL클래스가 갖고 있는 다양한 메서드로 파일 및 경로와 관련된 다양한 작업들 수행할 수 있는데  String규격으로도 String의 메서드로 가능은 했지만 같지만 코드가 길어지는 느낌도 든다. 그래서 권장하는 것일까. 명확한 답은 더 써봐야 알것 같다.



##### 5. enum에도 메서드를 구현할 수 있다.

> enum에 메서드를 구현해서 각각의 케이스에 해당하는 값을 넣어줄 수 있다.
>
> 이렇게 했을 때의 장점은 각각 케이스마다 해야할 행동을 if-else와 같은 표현으로 분기하지 않고, 한줄로 사용가능하다.

```swift
// enum에 함수 사용 JSONData 구조체 안에 존재
enum CountingType {
        case object
        case array
        
        func printResultOfConting (countedValue : JSONData) -> String {
            switch self {
            case .object :
                return  // 코드생략
            case .array :
                return  // 코드생략
            }
        }
    }

// enum에 함수 적용하기 전 코드
private static func printCountedResult (_ countedValue: JSONData) -> String {
        if countedValue.type == JSONData.CountingType.object {
            return // 코드생략
        } else {
            return // 코드생략
        }
}

// enum에 함수 적용 후 코드
private static func printCountedResult (_ countedValue: JSONData) -> String {
        return countedValue.type.printResultOfConting(countedValue: countedValue)
}
```

