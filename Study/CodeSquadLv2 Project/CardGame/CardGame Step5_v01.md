## CardGame Step5_v01



##### 핵심리뷰

- 객체관계 나누고 각 객체에 적절한 역할 부여하기
- Private하게 만들고 get/set사용하지 않기



##### 어려웠던 내용

> - Private하게 속성을 만들고 get/set 사용하지 않고 해당 Private속성이 위치한 객체에 상위모듈에서 사용되는
>
>   메서드 만들기



##### 개선한 문제점들

- **Private속성 만들고 Get/Set사용했던 것**

```swift
// 속성
private var point: Int = 0
private var name: String = ""
private var cardSet: [Card] = [Card]()
```



> private하게 해놓고 해당속성을 상위모듈에서 사용하게 하기 위해 연산프로퍼티를 만들었지만
>
> 이건 private하게 한 의미가 없는 것이다.

```swift
// 속성에 대한 연산 프로퍼티
var nameDescription: String {
    return self.name
}
    
var pointDescription: Int {
    return self.point 
}
    
var cardDescription: [Card] {
    return self.cardSet
}
```



> 두번쨰로 메서드 방식으로 만들었으나 역시 이름만 다른 getter

```swift
func getCardSetInfo () -> (cardSet: [Card], name: String) {
        return (self.cardSet, self.name)
}
```



> 결국 핵심은 Private하게 한 속성은 외부에서 접근이 안되게한 원칙을 지키고, 해당속성을 가져다가 하려고 했던 행동을
>
> 해당 속성이 위치한곳에 구현하고, 이 로직을 상위모듈에서 가져다가 쓰도록 해야 한다.



> 최종개선은 아래와 같이 하였다.
>
> <첫번째 개선>
>
> ```getWinnerInfo()``` 메서드를 만들어 name과 point속성을 감춰놓고 위너정보를 활용한 로직을 넘기게 했다.

```swift
func getWinnerInfo () -> String {
    let winnerHandName = PlayingGame.getWinnerHandName(point: self.point)
    return "🤩 승자는 \(self.name)이고 \(winnerHandName.rawValue) \(self.point)점 입니다."
}
```



> <두번째 개선>
>
> 각 플레이어가 갖고있는 카드를 출력해주기 위해선 Playe 객체r가 갖고있는 name, cardSet과
>
> PlayingGame객체가 갖고있는 players정보가 필요하고, 해당정보를 활용하여 Print를 해줘야 한다.
>
> 이를 위해 클로저를 사용했다.

```swift
// name과 cardSet을 클로저 형태로 갖고있다. 
func printEachPlayersCards(_ result: (_ name: String, _ cards: [Card]) -> ()) {
   result(self.name, self.cardSet)
}
```



```swift
// 클로저는 캡쳐된 상태로 모든 플레이어 정보를 갖고있는 PlayingGame객체에서 호출된다. 
func printAllPlayersCards (result: (_ name: String, _ cards: [Card]) -> ()) {
   players.forEach {
       $0.printEachPlayersCards(result)
   }
}
```



```swift
// 최종적으로 private한 속성들을 모두 사용하는 가장 상위모듈에서 해당 클로저를 선언하고 사용한다. 
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
```



- **결과적으로 필요하지 않았던 객체가 있었다.**

> GameInfo라는 객체가 있었다. 최초 의도는 게임 메뉴나 참가자수를 메뉴번호로 입력을 받아,
>
> 게임을 돌리기 위한 원하는 숫자로 변환해줄 용도였다. 하지만 여기도 다른 객체와 마찬가지로
>
> private하게 속성을 하다보니 이를 쓰기 위해 여러가지 코드가 추가되고 있었다.
>
> 
>
> 결과적으로는 필요하지 않은 객체였다. 이곳에서 받던 게임종류와 참가자수는 PlayingGame객체에서 처리하게 하였고
>
> GameInfo는 게임 메뉴 및 참가자관련 enum만 갖고있는 파일로 기능을 축소시켰다.
>
> 
>
> 이렇게 된 원인을 생각해보면 결국 최초 설계를 매끄럽게 하지 못했던 것 같다. 코드를 만들면서 불필요하게
>
> 복잡해지는걸 느끼고 결국 해결하게 된 것이다.
>
> 
>
> 이 부분을 해결하면서 코드가 많이 변화하였다.



* 객체의 타입메서드가 공통적으로 사용하는 매개변수가 있다면, 해당 메서드를 인스턴스 메서드로 변경하고

  객체내에 인스턴스 변수를 init으로 선언해서 이를 활용하는것이 좋다.

```swift
// 아래코드는 인스턴스메서드 및 변수로 바꾸는부분 외의 다른 부분은 모두 생략되었다.
// 기존코드
struct PlayingGame{
    static func decideWinner (_ players: [Player]) -> (name: String, point: Int) {}
    private static func getWinnerBetweenSamePointUsers (_ players: [Player]) -> Player {}
}

// 변경코드
struct PlayingGame {
    private var players:[ Player] = [Player]()
    init() {
        self.players = runGame(numberOfParticipants, kindOfGame, dealer)
    }

    func decideWinner () -> Player {
    private func selectWinnerBetweenSamePointUsers () -> Player {}

```



```swift
// 아래코드는 드라마틱한 변화가 있어 한 메서드의 전체로직을 기입했다.
// 포커규칙에 따라 플러쉬인지, 스트레이트인지 각각의 메서드가 확인하고
// checkFlushToStraight 메서드가 각각 확인한 메서드를 호출해서 최종적인 계산을 해주는 것이다.

// 기존코드
struct Hand {
    // 안그래도 복잡한 규칙이었는데 매개변수가 중복되게 다들어가다보니 더 복잡해진 모습...
    private static func checkFlushToStraight (_ cards: [Card]) -> [HandRanks] {
        if isFlush(cards) && isStraight(cards) == false && isRoyal(cards: cards) == false { hands.append(.flush) }
        else if isStraight(cards) && isFlush(cards) && isRoyal(cards: cards) == false { hands.append(.straightFlush)}
        else if isFlush(cards) && isRoyal(cards: cards) == true { hands.append(.royalFlush) }
        else if isFullHouse(cards) { hands = [HandRanks](); hands.append(.fullHouse)}
        else if isStraight(cards) { hands.append(.straight)}
return hands.sorted(by: >)
    }
    // 중략 : 이렇게 [Card]를 매개변수로 활용하는 메서드가 7개가 있었다.
}

// 변경코드
struct Hand {
    private var cards: [Card]
    init(_ cards: [Card]) {
        self.cards = cards
    }
    // 로직자체를 다소 최적화한 부분도 있지만 매개변수가 다 사라지고 인스턴스변수로 내부에서 사용하게 되면서
    // 보다 직관적으로 읽기 편해졌음을 느낄 수 있다.
    private  func checkFlushToStraight() -> [HandRanks] {
        var hands = [HandRanks]()
        if isFlush() && isRoyal( ) { hands.append(.royalFlush) }
        else if isStraight() && isFlush() { hands.append(.straightFlush)}
        else if isFlush() { hands.append(.flush) }
        else if isFullHouse() { hands.append(.fullHouse)}
        else if isStraight() { hands.append(.straight)}
        return hands
    }
    // 중략
}
```

