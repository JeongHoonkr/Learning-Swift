## CardGame Step5_v02



##### 핵심리뷰

- 프로토콜을 채택한 타입이 있을 경우 메서드의 매개변수로 해당 프로토콜을 넘겨서, 메서드를 단순화할 수 있다.
- 특정 알고리즘 구현 후 동작여부를 다양하게 확인해야 한다.
- 위의 확인은 테스트케이스 사례를 다양화해서 수행할 수 있다.



##### 어려웠던 내용

> - 포커규칙을 구현하는것도 어려웠지만, 이를 검증하는 과정에서 수정하고, 구현된 로직을 최적화하는것이
>
>   쉽지 않았다.
>
>   -> 제대로 돌아가지 않는 부분을 확인하기 위해 카드순서를 달리하거나, 안되는 경우 및 복합순위인 경우를
>
>   테스트에 추가해서 진행하였다.



##### 개선한 문제점들

- **OutputView의 출력메서드의 중복**

> Outputview에는 게임결과, 카드, 점수 등 다양한 내용을 출력하기 위해 여러가지 출력메서드가 있었다.
>
> 그동안 해왔던 방식으로 특별한 문제점을 느끼지 못했었다.



> 아래는 수정전 OutputView의 전체코드다.
>
> 최초에 출력메서드의 반복되는 매개변수가 있어 이를 인스턴스 변수 및 인스턴스 메서드로 변경해준바 있다.
>
> 그리고 앞서 말했듯이 다양한 목적의 출력메서드가 있다.

```swift
// 속성
struct OutputView {
    private let playingGame: PlayingGame
    private let dealer: Dealer
    init(_ playingGame: PlayingGame, _ dealer: Dealer) {
        self.playingGame = playingGame
        self.dealer = dealer
    }
    enum Message: CustomStringConvertible{
        case ofResetCard
        case ofEndOfProgram
        case ofInsufficientCard
        case ofSucceedChargingCard
        var description: String {
            switch self {
            case .ofResetCard:
                return "카드가 초기화되었습니다.\n총 52장의 카드가 있습니다."
            case .ofEndOfProgram:
                return "프로그램이 종료되었습니다."
            case .ofInsufficientCard:
                return "❗️카드수가 부족합니다.❗️, 프로그램이 종료됩니다.."
            case .ofSucceedChargingCard:
                return "카드 52장이 충전되었습니다."
            }
        }
    }
    
    static func printOfEndOfProgramMessage() {
        print (Message.ofEndOfProgram)
    }
    
    static func printOfInsufficientCard() {
        print (Message.ofInsufficientCard)
    }
    
     func printWinner() {
        print (playingGame.decideWinner().getWinnerInfo())
    }
    
     func printRemainingCards() {
        print(dealer.noticeRemainCard())
    }
    
     func printCardsOfPlayers() {
        playingGame.cardSetOfPlayers()
    }
}
```



> 이 출력메서드들은 String데이터 타입을 받아 프린트해주는 것인데 
>
> `CustomStringConvertible`은 자기 자신을 표현하는 문자열을 정의하는것으로써 String을 인자로 넘겨도
>
> `CustomStringConvertible`을 넘기는 것과 동일한 효과가 있다.
>
> 따라서 상기 메서드중 대부분은 하나로 간소화할 수 있고, 최종적으로 OutputView코드는 아래와 같이 변경되었다.
>
> > *enum부분은 메세지관련 파일을 따로 만들어 모아놓았다.*
>
> 이건 private하게 한 의미가 없는 것이다.

```swift
struct OutputView {
    // 플레이어의 카드를 출력하는 메서드
    static func printCardsOfPlayers(_ playingGame: PlayingGame) {
        playingGame.printAllPlayersCards(result:
            ( {(name: String, cards: [Card]) -> () in
                print ("\(name)", terminator : "[")
                for index in 0 ..< cards.count {
                    sleep(1)
                    print(cards[index].description, terminator: " ")
                }
                print ("]")
            })
        )
    }
    
    // 남은카드, 게임의 승자관련된 정보를 출력하는 메서드
    // 메인에서 해당 정보를 갖고있는 메서드를 호출하여 인자로 전달받는다.
    static func printContents (message: CustomStringConvertible) {
        print(message)
    }
}
```



* 테스트케이스는 성공 및 실패 케이스 포함 생각할 수 있는 모든 케이스를 넣는다고 생각하자.

```swift
// 아래는 테스트메서드중 몇가지를 뽑아본 것이다.
func test_isOnePair() {}
func test_onePairAndStraight_isNotOnePair() {}
func test_isTwoPair() {}
func test_threeOnePair_isNotTriple() {}
func test_tripleAndFourCard_isFourCard() {}
func test_tripleAndFourCard_isNotFullHouse() {}
```



**싱글톤이라는 것을 처음 사용해보았다.**

* 카드덱을 생성자로 받는 Dealer객체의 인스턴스가 프로그램 실행중에 계속 초기화 되는 문제가 있었다.
* 이곳저곳 아무리 보고 수정을 해봐도 계속 초기화가 되었다.

> 결국 이 문제를 해결하기 위해 싱글톤이라는것을 적용해보았다.
>
> 싱글톤은 반드시 하나의 인스턴스만 존재하게 만드는 것이다.

```swift
class Dealer {
    static let shared: Dealer = Dealer()
}
```

> 위와같이 구현하고 호스트코드에서 ```let dealer = Dealer.shared``` 선언하고
>
> dealer상수를 사용하면 된다.