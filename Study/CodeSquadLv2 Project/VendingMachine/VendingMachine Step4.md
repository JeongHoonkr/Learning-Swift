## VendingMachine 4단계



##### 핵심리뷰

- 배열이나 사전에 데이터를 담거나 찾는 코드를 객체로 만들어서 활용하기
  * 생각 : 활용한다는 것은 해당 데이터타입으로부터 파생되는 행동들을 객체에 담는것



**어려웠던점**

* 기존 구조상에서 배열 데이터타입의 객체를 새로 만들어서 해당 객체를 기존 구조내에서 활용하는 방법이 어려웠다.

  > 아래와 같이 해결했다.

  * 먼저 Inventory객체에 ControllerCore객체에서 [Beverage]데이터타입을 활용하던 메서드를 모두 옮김

    😞 두 객체의 역할이 완전히 같아졌다. 그래서! 👇🏻

  * ControllerCore의 역할을 자판기 각객체의 행동들을 연결해주는 것으로 한정해서 생각해보기로 함

    👉🏻 이렇게 생각하니 메소드도 더 쪼개지고, 어떻게 객체의 행동을 연결해야 할지 감이 잡혔다.

    ​

##### 1. Inventory객체 생성 (함께 Money 및 ShoppingLists객체도 생성)

- 기존 : [Beverage]라는 Beverage클래스의 배열 데이터타입을 사용

  * 이 데이터타입 활용하는 행동들은 UserMode 및 AdminMode각각이 수행하고 있었다.

  - **왜 문제인가** : **특정객체가 무거워지고**, 해당객체의 메서드도 데이터타입 내부를 탐색하고, 담는 등의 행동 구현을 하다보면 복잡해진다.

- 개선 : Inventory객체를 만들어서, 객체 내부에서 [Beverage] 데이터타입관련 행동들을 수행하도록 위임

  * 다른객체에서 메소드로 접근해서 결과만 처리하도록 함

> 많은 변화가 있었지만 대표적인 변화는 유저의 음료구매 관련 메서드이다.
>
> 음료구매 메서드 내부에서 사용하는 데이터타입은 크게 배열 [Beverage]와 사전 [Beverage:Int]이었다.
>
> * 구매가능한 음료배열을 상수로 받기
> * 구매하려는 음료가 구매가능한 음료배열에 존재하는지 확인하는 guard문 구현
> * 존재하는 음료 확인되면 상수에 담기
> * [Beverage] 데이터타입을 ```enumerated()```해서 offset과 element에 접근가능하게 구현
> * 음료구매에 따라 사용자의 잔액, 자판기의 수입, 구매이력 증감 구현
> * 구매한 음료리턴
>
> 함수 내부에서 

```swift
// 몇가지 변화가 있지만 대표적으로 변화된 메서드는 유저의 음료구매 메서드이다.
// 
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