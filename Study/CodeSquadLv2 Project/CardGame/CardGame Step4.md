## CardGame Step4



##### 핵심리뷰

* 메뉴 만들때 필요한 String값들을 enum에 넣었던 것처럼 숫자값을 디폴트값으로 넣을때 여러 숫자값을

  enum의 케이스로 만들어서 계산이 필요할때만 rawValue사용하기



##### 생각했던점

> - String과 마찬가지로 모든 타입의 값을 사용할때 직접 넣지 않고 의미있는 단위로 묶어서
>
>   각각의 case로 활용할 수 있도록 하자



##### 개선한 문제점들

- **카드게임종류와, 참가자 범주의 Int타입 케이스의 enum생성**

```swift
// 기존 코드 : 초기값 지정을 위해 인트값을 넣어줬었음
class CardGameInfo {
   private (set) var numberOfCards = 5
   private (set) var numberOfPlayers = 1

// 변경코드 : 카드게임종류와, 참가자 범주의 Int타입 케이스의 enum생성
enum CountOfCardGame: Int {
    case SevenCard = 7
    case FiveCard = 5
}

enum NumberOfParticipantsCases: Int {
	case One = 1, Two, Three, Four, InValidNumber
}
```



- **함수의 인자로 enum을 넘겨서 사용하기**

```swift
// 열거형을 만들어놓고 아래처럼 초기값에는 case의 rawValue를 사용해서 
// Int를 사용할때처럼 숫자를 바로 넣는꼴이 되버렸었다.
private (set) var numberOfCards = CountOfCardGame.SevenCard.rawValue
private (set) var numberOfPlayers = CardGameInfo.NumberOfParticipantsCases.One.rawValue


// 아래처럼 열거형을 타입으로 지정해놓고, 초기값은 케이스를 지정해주면 된다.
private (set) var numberOfCards: CountOfCardGame = .SevenCard
private (set) var numberOfPlayers: NumberOfParticipantsCases = .One

// 이렇게 해주면 실제 이 값을 사용하는 메서드에서도 아래처럼 인자로 Int값을 받지 않고 열거형을 받고
// 메서드 내에서 해당 케이스의 rawValue를 사용할 수 있다.
 mutating func makeEachCardSet (_ gameSpecies: CardGameInfo.CountOfCardGame) -> Array<Card> {
        var oneCardSet = Array<Card>()
        for _ in 0 ..< gameSpecies.rawValue {
            oneCardSet.append(pickCard())
        }
        return oneCardSet
    }
    
    mutating func makeCardTable (_ participants: CardGameInfo.NumberOfParticipantsCases, _ gameSpecies: CardGameInfo.CountOfCardGame) -> Array<Array<Card>> {
        var cardTable = Array<Array<Card>>()
        for _ in 0 ..< participants.rawValue {
            cardTable.append(makeEachCardSet(gameSpecies))
        }
        return cardTable
}

```



* 추가 개선사항 : Switch문으로 케이스 분류시 예외사항을 default nil로 지정하여 해결하기

```swift
func convert () -> CountOfCardGame? {
	switch self {
 	  case .SevenCardGame: return .SevenCard
  	  case .FiveCardGame: return .FiveCard
  	  default:
      return nil
	}
}
```



