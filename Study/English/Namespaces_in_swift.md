## Namespaces in Swift

#### 원문 링크 ([cocoacasts](https://cocoacasts.com/namespaces-in-swift/))



오브젝티브C클래스는 다른 라이브러리, 프레임워크와의 명칭충돌을 막기 위한 특별한 이름을 사용해야 했다. 이것이 애플이 오브젝티브c 클래스에 UIView, CGrect, 그리고 CALayer같은 접두사를 사용한 이유이다. 스위프트 모듈들은 이러한 클래스 접두사의 필요성을 쓸모없게 만든다.



스위프트 모듈은 중요한 진전이 있었지만, 많은 개발자들이 원했던것 만큼의 신축성을 갖진 못했다. 스위프트는 여전히 모듈내에서 네임스페이스 타입과 상수를 위한 해결책을 제시하지 않고 있다.



내가 스위프트로 작업할때 일반적으로 마주친 문제는 이 프로젝트를 진행하는 모든 사람들이 이해하기 쉽도록 상수를 정의하는 것이었다. 오브젝티브 씨에서는 이렇게 보일 수 있다. 모든 상수의 앞에는, 이름의 충돌을 피하기 위해 둘 혹은 세개의 문자가 붙어있으며, 그리고 상수의 이름은 프로젝트에서 사용되는 용도를 알 수 있게 기술되어있다.

```objective-c
NSString * const CCAPIBaseURL = @"https://example.com/v1";
NSString * const CCAPIToken = @"sdfiug8186qf68qsdf18389qsh4niuy1";

/*
위의 별표는 Objective-C 문법에서 *는 C 문법에 있는 포인터입니다. 모든 객체 인스턴스는 *를 붙여서 참조한다는 것을 포인터 문법으로 명시해야 합니다. <출처 : 코드스쿼드 모바일 마스터 JK>
*/

// 즉 객체 생성후 객체를 가르키는 녀석이 필요하다는 말 <출처 : 이동진님>
```

이것은 잘 작동하지만, 읽기에 쉽고 예쁘진 않다. 그러나 이렇게 사용하는것은 여전히 프로젝트 전체에 문자열 리터럴을 사용하는것보단 낫다.



##### Using Struct

비록 스위프트가 모듈내에서 네임스페이스를 지원하지 않지만, 이 문제를 우회할 수 있는 몇가지 해결책이 있다. 한가지 방법은 네임스페이스를 위한 구조체를 생성하는 것이다. 아래처럼 사용한다.

```swift	
struct API {
    static let BaseURL = "https://example.com/v1/"
    static let Token = "sdfiug8186qf68qsdf18389qsh4niuy1"
}
```



우리는 API라는 구조체를 정의했고, 하나 혹은 그 이상의 타입상수 속성을 선언했다. 나는 구조체를 사용하는 첫번째 해결책은 [Jesse Squires](https://www.jessesquires.com/blog/swift-namespaced-constants/)에 의해  처음으로 제시되었다고 생각한다. 이 방식은 잘 작동하고 사용하기 쉬우며, 상수에 접근하는 방식(syntax)이 읽기에 쉽고 직관적이다.

```swift
import Foundation

if let url = URL(string: API.BaseURL) {
    ...
}
```



그런데 한가지 달갑지 않은 부작용이 있다. 구조체는 인스턴스화 될 수 있다. 물론 이것 자체로는 문제가 없지만, 이 프로젝트에 참여하는 다른 개발자들은 혼란스러울 수 있다. 여러분은 `API`구조체의 생성자를 private하게 선언해서, 해당 구조체가 프로젝트의 다른 부분에 접근가능하지 않게 만들 수 있다.

```swift
struct API {

    private init() {}

    static let BaseURL = "https://example.com/v1/"
    static let Token = "sdfiug8186qf68qsdf18389qsh4niuy1"

}

let _ = API()
// You can see error : 'API' initializer is inaccessible due to 'private' protection level
```



##### Using Enums

다른 방식은 [트위터에서 있었던 토론](https://twitter.com/NatashaTheRobot/status/714798388345110528)에서 [Joseph Lord](https://twitter.com/jl_hfl)가 제시했고, 이 내용에 대해 [Natasha Murashev](https://www.natashatherobot.com/swift-enum-no-cases/)가 글을 작성한바 있다. Joseph은 구조체를 사용하는 대신에 enum의 사용을 제시했다. cases를 사용하지 않는 enum은 인스턴스화할 수 없지만, namespace로써의 역할을 할 수 있다.

```swift
enum API {
    static let BaseURL = "https://example.com/v1/"
    static let Token = "sdfiug8186qf68qsdf18389qsh4niuy1"
}
```

이 방법은 구조체를 사용하는 사람에게는 거의 유사한 형태로 작동한다. 주된 차이점은 여러분이 에러 없이, API enum의 인스턴스를 만들 수 없다는 점이다. 

```swift
enum API {
    static let BaseURL = "https://example.com/v1/"
    static let Token = "sdfiug8186qf68qsdf18389qsh4niuy1"
}

let _ = API() // You can see error : 'API' cannot be constructed because it has no accessible initializers
```



내가 namespace를 생성하기 위해 enum과 struct를 사용할때 매우 잘 작동했다. 여러분은 단일한 enum과 struct에서 프로젝트의 상수를 사용할 필요가 없다. 아래의 좀더 어려운 예시를 확인해보자.  여러분은 이 방식이 오브젝티브C와 비교할때 더 괜찮아 보인다는 점을 인정할 수 밖에 없을 것이다. 

```swift
enum API {
    static let BaseURL = "https://example.com/v1/"
    static let Token = "sdfiug8186qf68qsdf18389qsh4niuy1"
}

extension UserDefaults {
    enum Keys {
        static let CurrentVersion = "currentVersion"
        static let DarkModeEnabled = "darkModeEnabled"
    }
}
```

우리는 `UserDefaults` class의 extention을 생성하고, nested enum, `keys`를 를 정의했다. 이 `API`의 결과물은 매우 읽기 쉽고, `CurrentVersion`상수의 의미를 명확하게 설명한다.

```swift
// Update User Defaults
let userDefaults = UserDefaults.standard
userDefaults.set(1.0, forKey: UserDefaults.Keys.CurrentVersion)
```



##### Conclusion

이 패턴이 처음에는 다소 생소하게 느껴지겠지만, 이 방식은 매우 잘 작동한다. 이 방식은 살수를 좀 더 쉽게 다룰 수 있게 할 뿐 아니라, 매우 쉽게 사용할 수 있는 아주 단순한 패턴이다.