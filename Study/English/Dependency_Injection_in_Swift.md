## Dependency Injection in Swift

#### 원문링크 ([cocoacasts](https://cocoacasts.com/dependency-injection-in-swift))

<개인적으로 오역이 있을 수 있는 단어나, 원문이 반드시 필요한 문장은 같이 기입해 두려고 합니다.>



많은 개발자들은 *의존성 주입(Dependency Injection)* 이라는 단어를 듣는순간 위축되곤 한다. 의존성주입은 어려운 패턴이고, 초심자를 위한 개념도 아니다.  이것이 당신으로 하여금 어렵게 느끼게 한다. 사실 의존성 주입 패턴은 핵심적이며,  익히기에도 매우 쉬운 패턴이다. 



의존성 주입에 관해 내가 가장 좋아하는 인용문은 [James Shore](http://www.jamesshore.com/Blog/Dependency-Injection-Demystified.html)가 쓴 글이다. 이 글에는 의존성주입 개념을 둘러싼 많은 혼란들이 요약돼있다.



> "Dependency Injection" is a 25-dollar term for a 5-cent concept. - [James Shore](http://www.jamesshore.com/Blog/Dependency-Injection-Demystified.html)
>
> 의존성 주입은 5센트의 개념으로 얻을 수 있는 25달러의 가치가 있는 용어다.



나도 처음 의존성주입에 대해 들었을때 이 패턴은 당시에 내가 필요로 하는 것보다 훨씬 앞선*(too advanced)* 기술이라고 생각했다. 그래서 의존성주입이 무엇이었는지 제대로 알아보지 않고, 내 작업을 진행했다.



##### But What is Dependency Injection

나는 후에 가장 핵심적인것들(bare essentials)만 남겨놓는다면 의존성주입이라는것이 사실 아주 간단한 개념이라는 것을 알게 됐다. James Shore는 아래와 같이 의존성주입에 대한 간단명료하고, 복잡하지 않은 정의를 했다.



> Dependency injection means giving an object its instance variables. Really. That's it.
>
> 의존성 주입은 객체에 다양한 변수를 제공하는 것을 의미한다. 정말 그뿐이다.



의존성 주입을 처음 배우는 개발자들에게 가장 중요한 점은 프레임워크나 라이브러리에 의존하기전에 기본적인 것들을 배우는 것리다. 간단하게 시작해보자. 몇가지 찬스는 당신이 이미 모르는 사이에 의존성 주입을 사용하고 있다는 점이다.



의존성 주입은 객체가 의존성을 생성할 책임을 갖는 임무를 부여하는 대신에, 객체에 의존성을 주입하는 것 이상의 아무것도 없다. 혹은, James Shore의 말대로 객체에서 인스턴스 변수를 생성하는 대신 제공할 수 있다는 의미로도 이해할 수 있다. 당신에게 예를 통해 의미하는 바를 보여드리도록 하겠다.



##### An Example

이 예에서 우리는 `UIViewController` 라는 subclass를 정의했고, 이 서브클래스는 `RequestManager?`라는 옵셔널 타입의 `requestManager` 선언된 속성을 갖고있다.

```swift
import UIKit

class ViewController: UIViewController {
    var requestManager: RequestManager?
}
```

우리는 두가지방식(의존성 주입하고 안하고)중 하나로 `requestManager`속성값을 set할 수 있다.



* Without Dependency Injection

첫번째 옵션은 `ViewController` 클래스에게 `RequestManager` 인스턴스를  초기화하라는 임무를 주는 것이다. 우리는 속성을 지연속성으로 만들거나, view controller 생성자의 request manager를 초기화할 수 있다.

하지만 이는 요점은 아니다. 요점은 view controller가 `RequestManager` 인스턴스를 생성하는 책임을 맡게 됐다는 점이다.

```swift
import UIKit

class ViewController: UIViewController {
    lazy var requestManager: RequestManager? = RequestManager()
}
```

이 책임이 의미하는 바는, 단지 `ViewController` 클래스가 `RequestManager` 클래스의 행동을 알고 있다는 것을 의미하지는 않는다. `ViewController` 클래스는 `RequestManager` 클래스의 초기화에 대해서도 알고 있다는 것을 의미한다. 이것은 미묘해서 알아채기 힘들지만 중요한 정보(detail)이다.



* With Dependency Injection

다른 옵션도 있다. 우리는 `ViewController` 인스턴스에  `RequestManager` 인스턴스를 주입할 수 있다. 비록 표면적으로는 앞서 의존성을 주입한 것과 결과가 다르지 않지만, 이는 명백하게 차이가 있다. request manager에 의존성을 주입함으로써, view controller는 request manager가 어떻게 초기화하는지 알지 못한다.

```swift
// Initialize View Controller
let viewController = ViewController()

// Configure View Controller
viewController.requestManager = RequestManager()
```

많은 개발자들은 의존성 주입이 다루기 힘들다는점과, 불필요한 복잡성 때문에 의존성 주입을 사용하지 않는다.(discard). 하지만 만약 당신이 의존성 주입의 이점을 이해하게(consider) 된다면 의존성 주입이 매력적으로 느껴질 것이다.



##### Another Example

당신에게 내가 앞서 강조했던 것(의존성 주입의 장점을 이해하게 된다면 매력적으로 느끼게 될것)에 대해 다른 예시를 제시하려고 한다. 아래 예를 보자.

