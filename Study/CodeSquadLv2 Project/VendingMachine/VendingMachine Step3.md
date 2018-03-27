## VendingMachine 3단계



##### 핵심리뷰

- 객체가 다른 객체에 의존하는 구조는 나쁜구조이다. 의존해야만 하는 구조라면, DTO나 프로토콜을 활용해야 한다.

  ​

##### 1. OutputView에 프로토콜 의존성 주입

- 문제점 : OutputView에 Controller객체를 생성자로 넘기고 있어서, OutputView가 Controller에 의존하는 구조
  * **왜 문제인가** : **모든 객체들끼리는 의존적이지 않게 만들어야 한다.** 그렇게 해야 유지보수시 용이하다. 구조상 의존해야 한다면 아래의 두가지 방법으로 해결할 수 있다.
    * 의존하는 대상 객체를 DTO(Data Object)로 만들어서 넘긴다.
    * 객체를 프로토콜로 추상화해서 프로토콜타입을 넘긴다.

> 아래는 객체를 프로토콜 인터페이스로 추상화해서 프로토콜을 넘기게 했다. 이렇게 하면 기능변경이 생겼을때, 프로토콜에 기능을 정의하고, 해당 프로토콜을 채택한 객체가 구현하게 하면 된다.

```swift
// 기존 : Controller객체 자체를 OutputView에 넘기고 있다.
struct Outputview {
    private var controller : Controller
    init(_ controller: Controller) {
        self.controller = controller
	}
    // 중략
}

// 개선 : ControllerCore 프로토콜을 선언 및 채택하게 해서 프로토콜을 넘기기

// ControllerCore 프로토콜 선언
protocol ControllerCore {
    func userBalance() -> Int
    func withdrawlBalance() -> Int
    func shoppingHistory() -> Array<(key: Beverage, value: Int)>
    func listOfInventory() -> [Beverage : Int]
    func buyableBeverages() -> Array<(key: Beverage, value: Int)>
}

// 프로토콜 채택
class Controller: ControllerCore {
    // 중략
}

// 프로토콜을 생성자로 넘겨주기
struct Outputview {
    private var controllerCore: ControllerCore
    init(_ controllerCore: ControllerCore) {
        self.controllerCore = controllerCore
	}
    // 중략
}
```



##### 2. 함수/메소드 이름은 부작용(side-effects) 여부에 따라 명명

> ```func showListOfBuyableBeverage() -> Array<(key: Beverage, value: Int)>```
>
> 위 함수는 데이터 구조를 그대로 return하고 있기 때문에 아래와 같이 명사형으로 표현해야 한다.
>
> ```func buyableBeverages() -> Array<(key: Beverage, value: Int)>```



##### 3. indices의 활용

> indices라는 값은 배열의 유효한 값 범위를 갖기 때문에, ```contains()```를 활용해서 아래와 같이 간단하게 탐색할 수 있다.

```swift
// 기존 : 1부터 배열 전체 카운트 길이를 &&조건으로 탐색하고 있다.
func buy(productIndex: Int) -> Beverage? {
        let listOfBuyableBeveragge = self.showListOfBuyableBeverage()
        guard productIndex >= 1 && productIndex <= listOfBuyableBeveragge.count else {
            return nil
        }
        let beverage = buy(listOfBuyableBeveragge[productIndex-1].key)
        return beverage
}

// 변경 : indices를 활용해서 guard 조건식이 간단해졌다.
func buy(productIndex: Int) -> Beverage? {
        let listOfBuyableBeveragge = self.buyableBeverages()
        guard listOfBuyableBeveragge.indices.contains(productIndex-1) else {
            return nil
        }
        let beverage = buy(listOfBuyableBeveragge[productIndex-1].key)
        return beverage
}
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

- 기존 : 내부에서 아래 상수를 dir로 사용
  - `let dir = FileManager.default.homeDirectoryForCurrentUser` 
- 개선 : 함수에서 파라미터로 받게 함
  - `static func writeOutputFile(jsonTypeData:, outputFile:, toPath : URL)`
  - ` static func readFromFile(file InputFile: String, fromPath: URL) `