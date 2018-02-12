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

당신에게 내가 앞서 강조했던 것(의존성 주입의 장점을 이해하게 된다면 매력적으로 느끼게 되는 것)에 대해 다른 예시를 제시하려고 한다. 아래 예를 보자.

```swift
protocol Serializer {
    func serialize(data: AnyObject) -> NSData?
}

class RequestSerializer: Serializer {
    func serialize(data: AnyObject) -> NSData? {
        ...
    }
}

class DataManager {
    var serializer: Serializer? = RequestSerializer()
}
```



`DataManager` 클래스는 `Serializer?` 타입의 `serializer` 속성을 갖고 있다. 이 예제에서 `Serializer`는 프로토콜이다. `DataManager` 클래스는 `Serializer` 프로토콜을 채택하는 타입을 인스턴스화하는 역할을 하고 있는데, `RequestSerializer` 클래스가 그 예(역자주 : 프로토콜을 채택하는 타입의 인스턴스)이다.



`DataManager` 클래스가 `Serializer`타입의 객체를 어떻게 인스턴스화 하는지 알아야 할까? 아래 예시는 프로토콜과 의존성 주입의 힘을 보여준다.

```swift
// Initialize Data Manager
let dataManager = DataManager()

// Configure Data Manager
dataManager.serializer = RequestSerializer()
```



##### What Do You Gain

나는 당신이 내가 제시한 예시들을 보고 의존성 주입에 대해 조금의 관심을 갖게 되었기를 바란다. 이제 나는 의존성 주입의 추가적인 장점들을 나열하려고 한다.



* Transparency

객체에 의존성을 주입함으로써 클래스나 구조체의 역할과 책임은 좀 더 명확하고 투명해진다. 뷰컨트롤러에 request manager를 주입함으로써 우리는 뷰컨트롤러가 request manager에 의존하고 있다는 것을 이해할 수 있고, 뷰컨트롤러가 요청에 대한 관리 혹은 조작(request managing and/or handling.)에 대한 책임이 있다는 점을 예상할 수 있다.  



* Testing

의존성 주입을 사용하면, 단위테스트가 훨씬 쉬워진다. 의존성 주입은 객체의 의존성을 모형객체로 대체하는것을 더 쉽게 할 수 있게 하는데, 단위테스트시 설정하는것과 객체의 행동을 독립적으로 만드는 것을 더 쉽게 한다



이 예시에서  `MockSerializer` 클래스를 정의했다. 왜냐하면 `MockSerializer` 클래스는 `Serializer` 프로토콜을 채택하고 있어서, 우리가 data manager의 `serializer` 속성에 `MockSerializer`을 할당할 수 있게 해준다.

```swift
class MockSerializer: Serializer {
    func serialize(data: AnyObject) -> NSData? {
        ...
    }
}

// Initialize Data Manager
let dataManager = DataManager()

// Configure Data Manager
dataManager.serializer = MockSerializer()
```



* Separation of Concerns

앞서 내가 언급하고 묘사했던것처럼, 의존성 주입의 추가적인 장점은 concerns의 엄격한 분리에 있다. 이전 예시에서 `DataManager` 클래스는 `RequestSerializer` 인스턴스를 인스턴스화하는데 책임을 갖고 있지 않았고, 어떻게 이 작업을 수행하는지 알 필요도 없었다.



비록 `DataManager` 클래스가 자신의 serializer의 행동에 관심을 갖고 있었지만 serializer의 인스턴스화엔 관심을 갖고 있지 않았고, 그럴 이유도 없었다. 만약 `RequestManager`가 첫번째 예에서처럼 몇가지 의존성을 갖고 있었다면 어땠을까? `ViewController` 인스턴스 또한 이 의존성들에 대해 알고 있어야 할까? 그렇게 되면 금새 엉망이 될 것이다.



* Coupling (결합도) <[결합도와 응집도 설명](http://lazineer.tistory.com/93)>

`DataManager` 클래스의 예는 프로토콜과 의존성 주입을 사용하는것이 어떻게 프로젝트의 결합도를 낮춰줄 수 있는지를 설명하고 있다. 스위프트에서 프로토콜은 믿기 힘들정도로 유용하고, 다재다능하다. 이것은 단지 프로토콜의 엄청난 기능들 중 한가지 시나리오에 불과하다.



##### Types

많은 개발자들이 세가지 종류의 의존성 주입에 대해 고려하고 있다.

1. initializer injection
2. property injection
3. method injection

그렇지만, 이들은 서로 동등하게 고려되선 안된다. 아래에 각 형태의 장점과 단점을 설명하고자 한다.



* Initializer Injection

난 개인적으로 객체의 초기화단계에서 의존성을 건내는것을 추천하는데, 왜냐하면 몇가지 장점을 갖고 있기 때문이다. 가장 중요한 장점은 초기화 단계에서 건내진 의존성들은 불변적으로 만들어지기 때문이다. 이점은 스위프트에서 의존성을 위해 속성들을 상수로 선언하는것을 쉽게 한다. 아래 예를 보자

```swift
class DataManager {
    private let serializer: Serializer
    init(serializer: Serializer) {
        self.serializer = serializer
    }
}

// Initialize Request Serializer
let serializer = RequestSerializer()

// Initialize Data Manager
let dataManager = DataManager(serializer: serializer)
```



`serializer` 속성의 값을 설정하는 유일한 방법은 초기화단계에서 인자(argument)로 건내는것 뿐이다. `init(serializer:)` 메서드는 지정 이니셜라이저이며, `DataManager` 인스턴스가 올바르게 설정될 수 있다는 점을 보증해준다. 또다른 장점은 `serializer` 속성이 변경될 수 없다는 점이다.



왜냐하면 우리는 초기화 과정에서 serializer를 인자(argument)로 건냈기 때문이다, 지정 이니셜라이저는 `DataManager`클래스의 의존성이 무엇인지 분명하게 보여준다.





* Property injection

의존성은 주입은 클래스나 구조체의 내부 혹은 전역속성을 선언함으로써도 이루어질 수 있다. 이것은 편리해보이지만, 의존성이 대체되거나 수정될 수 있다는 허점을 낳는다. 즉 의존성이 불변적인것이 아니라는 말이다.

```swift
import UIKit

class ViewController: UIViewController {
    var requestManager: RequestManager?
}

// Initialize View Controller
let viewController = ViewController()

// Configure View Controller
viewController.requestManager = RequestManager()
```

의존성 주입은 때떄로 당신이 유연성을 갖게 한다. 예를 들어 당신이 스토리보드를 사용한다면, 커스텀 이니셜라이저( == 직접 만든 이니셜라이저)를 사용할 수 없고, 생성자주입(initializer injection)을 사용할 것이다. 속성주입은 차선책이다.



* Method injection

의존성은 필요할때마다 주입될 수도 있다. 이것은 의존성을 인자로 받아들이는 메서드를 정의하는 것을 쉽게 한다. 이 예에서 생성자는 `DataManager` 클래스의 속성이 아니다. 대신에 생성자는 `serializeRequest(_:with:)` 메서드의 인자로써 주입됐다.

```swift
class DataManager {
    func serializeRequest(request: Request, with serializer: Serializer) -> NSData? {
        ...
    }
}
```

`DataManager` 클래스는 의존성에 대한 몇몇 통제를 잃었지만, 이러한 형태의 의존성주입은 유연성을 제공한다. 이런 경우에 의존성을 사용한다면, 우리는 어떤 생성자 타입을 `serializeRequest(_:with:)` 메서드의 인자로 건낼지 선택할 수 있다.

각각의 의존성 주입마다 사례를 갖고있다는 점을 강조하는 것은 중요한 일이다. 생성자주입이 다른 많은 시나리오보다 훨씬 중요한 옵션이지만, 최선이라거나 선호되는 형태는 아니다. 사용 사례들을 고려해보고나서, 어떤 타입의 의존성주입이 가장 잘 맞는지 선택해야 한다.



##### Singletons

의존성 주입은 프로젝트에서 싱글톤의 필요성을 제거하는데 사용할 수 있는 패턴이다. 나는 싱글톤 패턴의 팬이 아니며, 가능한한 싱글톤을 피하려고 한다. 비록 내가 싱글톤 패턴의 안티는 아니지만, 나는 가능한한 정말 드물게 사용하려고 한다. 의존성 주입이 결합도(coupling)를 낮추는 반면, 싱글톤 패턴은 의존성을 증가시킨다.



너무나 자주 개발자들은 싱글톤을 사용하는데, 왜냐하면 싱글톤이 종종 발생하는 귀찮은 문제들을 해결하는데 가장 쉬운 해결책이기 때문이다. 그러나 의존성 주입은 프로젝트에 명확성을 더해준다. 프로젝트의 초기화 동안 의존성을 주입함으로써 목표 클래스와 구조체가 어떤 의존성을 갖고 있는지 보다 명확하게 하고, 객체의 몇가지 책임을 드러낸다.



의존성주입은 나를 복잡한 프로젝트의 최상단에 설 수 있게 해주기에, 내가 가장 선호하는 패턴이다. (프로젝트가 복잡해질수록 큰 그림을 보기 어렵기 때문이겠지) 이 패턴은 너무나 많은 장점을 갖고 있다. 내가 생각하는 유일한 단점은 코드 몇줄이 더  필요하다는 것이다.