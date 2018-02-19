## Value Types And Reference Types in Swift

#### 원문링크 ([cocoacasts](https://cocoacasts.com/value-types-and-reference-types-in-swift))

<개인적으로 오역이 있을 수 있는 단어나, 원문이 반드시 필요한 문장은 같이 기입해 두려고 합니다.>



우리 대부분은 객체지향 프로그래밍에 대해 생각할때 직감적으로 클래스에 대해 생각한다. 그러나 스위프트에서는 조금 다를 것이다. 당신이 클래스를 계속 사용할 수는 있지만, 스위프트는 당신이 소프트웨어 개발에 대해 생각하고 있는 것들을 바꿀 수 있는 몇가지 특별한 방식을 갖고 있다. 만약 당신이 좀 더 고전적인 객체지향 프로그래밍 언어 - *루비 or 오브젝티브C* - 를 사용하다가 스위프트로 왔다면, 이 내용은 아마도 당신이 스위프트로 작업을 함에 있어서 가장 큰 사고방식의 전환이 될 것이다.



##### Value Types And Reference Types

우리가 이 이슈에서 곱씹어볼 개념(concept)은 값타입과 참조타입의 차이 혹은 값 건내기와 참조 건내기(passing by value and passing bt reference)이다.



스위프트에서 클래스의 인스턴스는 참조로 건내진다. 이런 방식은 루비나 오브젝티브C에서 클래스가 구현되는 방식과 유사하다. 이는 클래스의 인스턴스가 복사본을 소유하는 여러명의 소유자를 갖고 있을 수 있음을 의미한다. 구조체나 열거형의 인스턴스는 값으로 건내진다. 구조체와 열거형의 모든 인스턴스는  데이터의 유일한 복사본을 갖는다. 그리고 동일한 내용이 튜플에도 적용된다.



앞으로 다뤄볼 내용에서 나는 객체로서의 클래스의 인스턴스와 값으로서의 구조체와 열거형의 인스턴스를 다룰 것이다. 이 방식은 불필요한 복잡성을 피할 수 있게 한다.



##### An Example

당신이 상기의 개념을 이해하는 것이 중요하기 대문에, 한가지 예를 들어보려고 한다.

```swift
class Employee {
    var name = ""
}

var employee1 = Employee()
employee1.name = "Tom"

var employee2 = employee1
employee2.name = "Fred"

print(employee1.name) // Fred
print(employee2.name) // Fred
```

우리는 `Employee` 라는 클래스를 선언하고 `employee1` 라는 인스턴스를 생성했다. 우리는 `employee1`의 이름을 **Tom**으로 정했다. 그리고 우리는 다른 `employee2` 라는 다른 변수를 선언하고, `employee1` 를 할당했다. 우리는 `employee2`의 이름을 **Fred**로하고, `Employee` 두 인스턴스의 이름을 프린트했다. 클래스의 인스턴스가 참조로 전달되기 때문에, 두 인스턴스의 이름속성 값은 동일하게 **Fred**가 됐다. 감이 왔는지? 아니면 결과가 놀라운지?

```swift
struct Employee {
    var name = ""
}

var employee1 = Employee()
employee1.name = "Tom"

var employee2 = employee1
employee2.name = "Fred"

print(employee1.name) // Tom
print(employee2.name) // Fred
```

두번쨰 예에서 우리는 `Employee` 라는 구조체를 선언하고, 첫번쨰 예에서의 단계를 반복했다. print문의 결과는 다르다. `class`를 `struct`로 대체함으로써 예시의 결과는 눈에 띄게 변했다. 클래스 객체의 인스턴스는 다수의 소유자를 가질 수 있고(참조로 전달될때, 참조가 가능한 개수의 제약이 없다 : 역자), 구조체의 인스턴스는 단 하나의 인스턴스만 가질 수 있다. 구조체의 인스턴스가 함수에 할당되거나 건내지면(as parameter : 역자첨언), 그 값은 복사된다. 구조체의 고유한 인스턴스는 구조체의 인스턴스를 참조하는 대신에 건내진다.



`employee1`이 `employee2`변수에 할당되는 순간 `employee1`의 복사본이 만들어지고, 이 복사본이 `employee2`에 할당되는 것이다. `employee1`과   `employee2`의 값은 그들이 복사본들이라는 사실을 빼고는 서로 아무런 관련이 없다.



##### Benefits of Value Types

스위프트에서는 값타입을 광범위하게 사용한다. 스위프트에서는 문자열, 배열, 사전, 숫자등이 값타입이다. 이는 우연이 아니다. 만약 당신이 값타입의 장점을 이해한다면, 당신은 자동적으로 왜 이런 타입들이 스위프트의 **표준 라이브러리**에서 값타입으로 정의되었는지 이해할 수 있을 것이다. 값타입의 장점은 무엇일까?



* Storing Immutable Data

값타입은 데이터를 저장하는데 있어 아주 좋다. 심지어 불변 데이터를 저장하는데에 있어서도 최적의 타입이다. 당신이 사용자의 은행계좌 잔액을 저장하는 구조체를 만들었다고 가정해보자. 만약 당신이 함수에 (as parameter: 역자) 잔액을 건냈다면, 함수는 자신이 잔액을 사용하는 동안에 잔액이 변경되리라고는 생각하지 않을 것이다. 잔액을 값타입으로 건냄으로써 함수는 잔액의 유일한 복사본을 전달받고, 그 잔액이 어디로부터 왔는지는 개의치 않는다.



* Manipulating Data

값타입은 그들이 저장한 데이터를 조작하지 않는다. 그것