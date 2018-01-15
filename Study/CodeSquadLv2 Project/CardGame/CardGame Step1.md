## CardGame Step1



##### 핵심리뷰

- 상위모듈에 객체의 속성을 넘기기보다는, 객체자체에 메소드로 구현하거나, 객제 자체를 매개변수로 넘기는 것이 좋다.

  ​

##### 생각했던점

> - CardGame에서 어떤 역할로 객체를 구분할 것인지 정하기
> - CustomStringConvertivle사용해보기



##### 리뷰코드

> * 카드 한장을 출력하기 위해 카드객체의 oneCard라는 속성을 넘겨주고 있었는데
>
>   상위모듈에 넘길때는 객체자체를 넘기는것이 좋다.
>
> * 또한 객체자체를 넘길 경우 .description(Card를 확장한 속성)을 호출해서 출력하기 때문에 .description을
>
>   명시할 필요는 없다.



```swift
// 이전 코드
class OutputView {
    static func printCard (result: String) {
        print (result)
    }
}

// 변경코드
class OutputView {
    static func printCard (card: Card) {
        print (card)
    }
}
```

