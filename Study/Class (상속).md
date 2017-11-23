## Class에서의 상속



##### 1. 상속이란?

* 구조체와 차별되는 클래스만의 특징 중 가장 핵심적인것
* 상속이란 한 클래스(부모클래스)에서 이미 생성된 프로퍼티와 메서드를  다른 클래스(자식클래스)가 그대로 가져다가 사용할 수 있는 것을 말하며 가져와서 재정의(override)해서 사용할 수 있다.
* 상속은 인스턴스가 생성되는 시점이 아니라, 컴파일러가 컴파일 하는 동안 판단한다.



##### 2. 재정의(override)란?

* 부모클래스의 메서드 혹은 프로퍼티를 상속받은 후 그대로 사용하지 않고, 필요에 의해 다시 구현하여 사용하는 것

* 프로퍼티 오버라이딩

> 핵심 : 프로퍼티 오버라이딩은 상위 클래스의 기능을 하위클래스가 확장, 또는 변경하는 방식으로 진행되는
>
> 것이며, 제한하는 방식으로 진행되어서는 안된다.

* 저장프로퍼티를 저장프로퍼티로 오버라이딩하는 것은 허용되지 않으며 의미도 없다.

![dd](http://postfiles12.naver.net/MjAxNzExMjNfMTUg/MDAxNTExNDE1NjY2MTIz.mA_Qs6N4biYkX6DSuuryOt9_3ZCMG4uOxnviCZYEBVsg.GTVDDUtLSMvPGkYo_l_oIDpvQaLlfa3zhnlnbTRju9sg.PNG.bb_9900/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2017-11-23_%EC%98%A4%ED%9B%84_2.40.18.png?type=w773)

```swift
// 이렇게 값만 할당하는 것으로 충분하기 떄문이다.
class Person {
    var name = "사람"
}

class JeongHoon: Person {
}

var jeongHoon = JeongHoon()
jeongHoon.name = "정훈"
```

* 저장프로퍼티는 기본적으로 getter,setter를 내부적으로 갖고있기 때문에, 

  재정의시 get,set을 갖고 있는 연산프로퍼티로 재정의해야 한다.

* get,set이 모두 있는 연산프로퍼티는 동일한 연산프로퍼티로 재정의해야 한다.

* 단 get만있는 연산프로퍼티를 get,set모두 갖는 연산프로퍼티로 재정의 가능하다.

* 속성 접근제한을 private(set) 으로 get만 가능하게 했으면 getter만 override 하면 된다.

```swift
// 자식클래스 차 (비클을 상속)
class Car: Vehicle {
    var gear = 0
    var engineLevel = 0
    
    // get(읽기) set(쓰기)에 모두 열려있는 저장프로퍼티기 때문에 연산프로퍼티로 동일하게 get,set으로 재정의
    override var currentSpeed: Double {
        get {
            return Double(self.engineLevel * 50)
        }
        set {
            // 아무것도 하지 않아도 필요
        }
    }
    
    // get만 있었던 연산프로퍼티는 get, set으로 확장가능
    override var description: String {
        get {
            return "Car : engineLevel = \(self.engineLevel), so currentSpeed = \(self.currentSpeed)"
        }
        set {
            print ("New Car is \(newValue)")
        }
    }
}

var jeongHoonCar = Car()

jeongHoonCar.engineLevel = 5
jeongHoonCar.description = "SmartForTwo"

print(jeongHoonCar.description)
```



>저장형 프로퍼티는 자식클래스에서 재정의는 불가능 하지만, init 할 때 값을 새로 할당하는것은 가능합니다. 1번 해결을 위해 연산 프로퍼티를 사용해도 되지만 단순 값 할당이라면 이와 같이 해도 될 것 같네요.





> 아래와 같이 부모클래스(superClass)에서 그냥 var로 선언하고 setter 부분을 { } 라고 쓰면 
>
> setter 동작을 없애버린게 되서 값이 저장이 안된다.

```
class JeongHoonBank: Bank {
    override var name: String {
        get {
            return "정훈뱅크"
        }
        set {
        }
    }
}

class Bank {
    var name: String = "Korea Bank"
}


var bank = JeongHoonBank()


bank.name = "정훈님뱅크"
print(bank.name) // 정훈뱅크로 찍힘
```

