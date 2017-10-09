## Optional (옵셔널)

#### 1. 정의

> 어떤 인스턴스에 값이 없을 수도 있다는 일종의 안내, 따라서 ```optional``` '**?**'이 적용된 인스턴스는
>
> 다음 두가지중 하나로 해석될 수 있다.
>
> 1. 인스턴스에 값이 지정되어 있고, 언제든 사용될 수 있다.
> 2. 인스턴스에 지정된 값이 없다. -> 이를 ```nil```이라 한다.
>
> 따라서 Optional이 적용되지 않은 인스턴스는 nil이 될 수 없다.
>
> 또한 Optional변수는 초기화하지 않으면 nil로 자동으로 초기화된다.

``` swift
var myAge: Int
myAge = nil
// 아래처럼 에러가 난다. 그 이유는 myAge의 타입이 인트로 지정되었기 때문이다.
// nil을 넣어주려면 
// var myAge: Int?로 즉 옵셔널 변수로 선언해야 한다.
```

![d](http://cfile21.uf.tistory.com/image/2604583858888A0C29F9C0)

> swift에서는 변수를 선언할때 기본적으로 ```non-optional```인 값을 주어야 한다.
>
> 즉 어떠한 값을 변수에게 주어야 한다는 말이다.
>
> 그래서 Int형으로 선언했다면 반드시 정수형타입의 값이 들어가야 한다.
>
> 그런데 위와 같이 ```nil```이 들어간다면 ```Int```라는 메모리공간이 초기화 될 수 없는것이다.



#### 2. 옵셔널에 대한 이해

#####   2-1. 옵셔널 타입에 String타입의 값 넣기

> 옵셔널 타입의 변수를 선언 후 "404"라는 String타입의 값을 대입해서 
>
> 아래와 같은 조건문에 넣었을 경우 해당 errorCodeString은 여전히 옵셔널타입의 값이기 때문에
>
> 원하는 String타입의 값이 나오지 않는다.

![담기](http://postfiles2.naver.net/MjAxNzEwMDNfMjU1/MDAxNTA3MDAxMTEwNjA2.fi-TWnY4offuqX_Ccd2o3ZOzGX5ewRcZ2uys5P637BQg.8er0szXz04kW3c_CJu05P2SolVSVLztICamQSrL8PfAg.PNG.bb_9900/스크린샷_2017-10-03_오후_12.23.49.png?type=w2)



#####   2-2. Optional Binding (옵셔널 바인딩) = nil인지 값이 있는지 체크해주는 의미

#####      2-2-1. **forced unwrapping**

> 이 경우 값이 있다고 확신할 수 있기 때문에 강제로 값을 가져올 수 있는데 
>
> 이를 forced unwrapping(강제언래핑)이라고 한다.
>
> "404"라는 String타입의 값을 errorCodeString에 넣어주고 "404"라는 타입의 갑만 강제로 빼오고
>
> nil이라는 값은 버리는 것이다.

```swift
if errorCodeString != nil 
{ let theError = errorCodeString!        
print (theError)}/// 출력결과 : 404
```

>그러나 위와 같은 경우는 우리가 "404"라는 String타입의 값을 넣어준 것이 분명하지만, 만약 값이 없는 즉 nil일 수있는 상황이라면 런타임 오류로 앱은 강제종료되고 말것이다. 따라서 '!'강제 언래핑은 사용시 주의해야 하며,
>
>사용자체도 자제해야 한다. 
>
>**<링고스타 강사의 말 : 개발자의 확신은 경험적으로 수많은 에러를 만들어 낸다. !가 많은 코드는 나쁜코드다.>**



#####      2-2-1-1. '!' 강제언래핑 사용의 위험성 예시 : nil로 초기화한 옵셔널 변수를 강제언래핑하기

<nil일지 아닐지 확실하지 않은 상황에서 사용시 아래와 같은 일이 발생될 수 있다.>

```swift
let myWeight: Double? = nil
let somoneWeight = myWeight!

// 실행결과 : fatal error: unexpectedly found nil while unwrapping an Optional value
```



#####      2-2-2. if let( or var)

>  옵셔널에 값이 있다면(즉 if조건이 참일때) 임시 상수나 변수에 그 값을 지정하고 코드블럭을 사용하는 것
>
> 조건문에서 임시값을 변경해야 한다면 if var를 사용하여 변수로 선언한다.

```swift
var errorCodeString: String?
errorCodeString = "404"

if errorCodeString != nil {
    if let theError = errorCodeString {
        print (theError)}
    else {
        errorCodeString = nil
    }
}
// 출력결과 : 404
```



> 또한 if let(or var)는 아래처럼 중첩하여 사용할 수 있다.

```swift
var myFavoriteStringNum: String?
myFavoriteStringNum = "12345"

if let myphoneNum = myFavoriteStringNum {
    if let myphoneNumInt = Int(myphoneNum) {
        print (myphoneNumInt)
    }
}
// 출력결과 : 12345
```

> 중첩된 if let은 아래와 같이 쉼표 ','로 구분해줄수도 있다. 이 경우 콤마는 '&&'의 의미를 갖는다.

```swift
var myFavoriteStringNum: String?
myFavoriteStringNum = "12345"

if let myphoneNum = myFavoriteStringNum, let myphoneNumInt = Int(myphoneNum)
	{ print (myphoneNumInt) }
```

   /그러나 위 두가지 경우처럼 중첩하여 사용할때 하나의 조건을 충족하지 못할 경우 body는 실행되지 않는다.



>추가판단 삽입하기

```swift
var myFavoriteStringNum: String?
myFavoriteStringNum = "12345"

if let myphoneNum = myFavoriteStringNum, let myphoneNumInt = Int(myphoneNum)
// 'myphoneNum!it == 12345' 라는 부분의 추가판단을 삽입하였다.
, myphoneNumInt == 12345
    { print (myphoneNumInt) }
```



#####      2-2-3. 암시적으로 언래핑된 옵셔널 (Implicitly unwrapped optional)

> 암시적으로 언래핑된 옵셔널은 강제언래핑과 헷갈릴 수 있는데, 암시적 언래핑은 타입에 '!'를 붙여서 타입으로써
>
> 사용하며, 강제언래핑은 값에 '!'를 붙여서 사용한다.
>
> 암시적 언래핑을 사용하는 이유는 초기화 이후 항상 가질 수 있을때에만 편의를 위해 사용한다.
>
> 즉 굳이 옵셔널로 선언해서 값을 사용할때마다 언래핑할 수고를 덜어주는 것이다.
>
> <예를들어 프로그램 구동시에는 값이 없어 nil인 변수가 프로그램이 실제 구동되면 항상 값을 가질때
>
> 암시적 언래핑 옵셔널을 사용할 수 있다.>



> 아래는 암시적 언래핑을 사용해본 예이며 아래와 같은 사실을 알 수 있다.
>
> 1.  ```nil```이 아닌 값을 갖는다는 가정을 내포하고 있다.
> 2. 하지만 nil 값을 가질 수 없는 것은 아니다. ```optional```이기 때문에 ```nil```도 될 수 있다.
> 3. 장점 : 값이 필요한 시점에 `!`을 쓰지 않아도 자동으로 언래핑된다. (if let, gurad let 무필요)
> 4. 단, 콘솔로그에 Optional()이 찍히게 하지 않고 싶다면 값에 '!'를 붙여야 한다.
> 5. 이 때  `?`를 썼을 때와 마찬가지로 nil이라면?  런타임 에러가 발생한다.
> 6. **따라서 nil 검사는 항상 해줘야 한다.**



```swift
// 암시적 언래핑 공부
// 초기값은 nil로 선언하기
// 배열에 넣어보고 값으로 사용하기
var publishingCompany : String! = nil
var writer : String! = nil
var bookTitle : String! = nil
publishingCompany = "출판한다책"
writer = "쓴다책"
bookTitle = "정복한다 스위프트"

var book: [String] = [publishingCompany, writer, bookTitle]

func makingBook () -> String {
    var theBook: String = ""
    theBook += ("\(book[0])에서 출판하고 \(book[1]) 작가님이 집필하신 \(book[2]) 11월 출판예정")
    return theBook
}
print(makingBook())

// 0-2. 값으로 사용할때 언래핑하기와 안하기
var country : String = "South Korea"
var province : String! = nil
var street : String! = "kangseok"
province = "Kyung ki do"
```

> 아래는 암시적 언래핑된 값이 nil일때 강제언래핑해서 값 그자체로 사용하고자 할때 에러 예시이다.

![nil값 접근하기](http://postfiles15.naver.net/MjAxNzEwMDNfMTMy/MDAxNTA3MDE4MzMxMTQ3.BM-RMZSoq8UfKtwWi1dzn-bdJqOUK3u5EYsUtguwhE8g.ZrX4GsSQgZ-FNntT1hL6rzQJLPu5DIPAxUOxAFNHE0sg.PNG.bb_9900/스크린샷_2017-10-03_오후_5.11.07.png?type=w2)



#####   2-3. optional chaining (옵셔널 체이닝)

> 어떤 하위 포로퍼티(옵셔널의 값)에 연속적으로(사슬처럼) 조회할 수 있는것을 의미한다. 
>
> 즉 체인에서 어떤 옵셔널에 값이 있다면 값을, 옵셔널이 nil이라면 nil자체를 리턴한다.
>
> 옵셔널 체이닝의 장점은, nil값을 호출해도 런타임에러가 발생하지 않고, 
>
> nil 값 or nil일때 설정해둔 실행문을 출력하고 
>
> 아래처럼 정상적으로 프로그램이 종료하도록 해준다는 점이다.

```swift
// 옵셔널 체이닝(+ 옵셔널 바인딩) 활용 사례

// skill 프로퍼티를 갖는 Skill 클래스 생성
class Skill
{var usefulSkill: [String] = ["박치기", "구르기"]}

class Pocketmon
{var skill: Skill?}

var pickachu: Pocketmon = Pocketmon()

// 옵셔널 체이닝 사용 = pickachu,skill? 부분
// 피카츄의 스킬이 nil이 아니라면 스킬을 바인딩 변수에 담아 if문을 실행
// 피카츄의 스킬이 nil이라면 else 구문 출력
if let pocketmonSkill = pickachu.skill?.usefulSkill {
    print ("pickachu has \(pocketmonSkill)")
} else {
    print ("pickachu has no skill")
}

// 여기선 nil이기 떄문에 else구문 출력
// if구문 출력하고 싶다면 pickachu.skill = Skill(), "pickachu has ["박치기", "구르기"]"
```



##### 3. 종합적 사용 

> 옵셔널 변수 및 암시적 언래핑 변수 선언
>
> 옵셔널 바인딩 중첩 사용
>
> 옵셔널 체이닝 사용



```swift
var rocketDamage: String?
var totalDamage: String?
var baseDamage: Int = 150
rocketDamage = "300"

// 옵셔널 바인딩 중첩
if let damage = rocketDamage, let theDamage = Int(damage), theDamage == 300
{
    totalDamage = "our planet was damaged by \(theDamage + baseDamage)"
}

// tatalDamage?에서 ?부분이 옵셔널체이닝 시작을 알림
// totalDamage가 nil이라면 announcement에 nil을 대입하고  
// 값이 있다면 그 뒤가 실행되어 대문자로 변환한 값을 대입
var announcement = totalDamage?.uppercased()
print(announcement)
```

> 위의 announcement의 타입은 아래와 같은 String? 이다.

![현재 announcement의 타입](http://postfiles4.naver.net/MjAxNzEwMDNfMjMx/MDAxNTA3MDI0ODc3OTQ3.ZMp-k-NpxJT6oWa_R2Fw5XyL739I-D4bu5px9vvEFpgg.yTNc9jP4vp6RrZ3DqljF19X7i5HkjifYHvwVW811G7Mg.PNG.bb_9900/스크린샷_2017-10-03_오후_6.59.52.png?type=w2)

> 따라서 위의 예시에서는 아무 문제가 없지만 저 변수로 다른 작업을 하고자 할때는? 
>
> 옵셔널 바인딩 작업을 해줘야 한다.
>
> 하지만 우리는 announcement 변수에 확실히 값이 들어갈것이라는 것을 알고 있다.
>
> 바로 이때 ```implicitly unwrapped```를 사용하는 것이다.

```swift
/// 수정된 부분
var announcement: String! = totalDamage?.uppercased()
print(announcement)
```



> 하지만 ```implicitly unwrapped```를 사용하지 않고 옵셔널 바인딩도하지 않고 사용할 수 있는  다른 방법이 있다.
>
> 옵셔널체이닝처럼 ?를 붙히는 것이다. 
>
> 이를 modifying in place 즉 준비된 상태로 수정하기 라고 한다. 준비된 상태라는 것은 변수나 상수를 만들지 않고
>
> 수정할 수 있다는 말이다.
>
> **이렇게 하게 되면 옵셔널 체이닝 성격도 갖기 떄문에 값이 있을때는 업데이트하고, 값이없을때는 동작하지 않는다. ** 

```swift
// 추가 수정된 부분 (선택적)
// 위에 방법이 나은것 같기도 하다 흠...
announcement?.append(" Please run away")
print(announcement)
```



> 위 사항들을 정리하면 아래와 같다.
>
> 1. 생각할거리 : totalDamage가 암시적언래핑된 값이라면 아래 내용은 어떻게 바꿔보면 될까

```swift
var rocketDamage: String?
var totalDamage: String?
var baseDamage: Int = 150
rocketDamage = "300"

if let damage = rocketDamage, let theDamage = Int(damage), theDamage == 300
{
    totalDamage = "our planet was damaged by \(theDamage + baseDamage)."
}

// 생각할거리를 토대로 바꿔보기
totalDamage?.append(" Please run away")
var announcement: String! = totalDamage?.uppercased()
print (announcement)
// 현재 상태에서의 출력결과 : OUR PLANET WAS DAMAGED BY 450. PLEASE RUN AWAY!
```



##### 3-1 추가학습 :  ```nil ```  결합 연산자

> ```var: announcement``` 의 값을 출력할때 값 그자체를 쓰면서
>
> nil일때도 어떤 행동을 하고자 한다면
>
> 옵셔널 바인딩을 통해 파싱해야 할때가 있을것이다.

```swift
var rocketDamage: String?
var totalDamage: String!
var baseDamage: Int = 150
rocketDamage = "300"

if let damage = rocketDamage, let theDamage = Int(damage), theDamage == 300
{
    totalDamage = "our planet was damaged by \(theDamage + baseDamage)."
    totalDamage.append(" please run away.")
}
/// nil일때의 행동추가를 위해 추가되는 코드
totalDamage = nil
var gotDamage: String
if let totalDamage = totalDamage {
    gotDamage = totalDamage
} else {
    gotDamage = "No damage"
}
print(gotDamage.uppercased())
```

> 이렇게 하면 단순한 연산임에도 코드가 길어진다. 이 경우!
>
> ```nil coalescing operator```를 사용하면 간단히 해결할 수 있다.



위 코드는 아래와 같이 수정할 수 있다.

코드가 다이어트된 부분을 확인할 수 있다.

```swift
var rocketDamage: String?
var totalDamage: String?
var baseDamage: Int = 150
rocketDamage = "300"

if let damage = rocketDamage, var totalDamage = totalDamage, let theDamage = Int(damage), theDamage == 300
{
    totalDamage = "our planet was damaged by \(theDamage + baseDamage)."
    totalDamage.append(" please run away.")
}
// nil coalescing operator로 수정된 부분
totalDamage = nil

// 복습시 생각할거리1 : 아래에서 gotDamage는 왜 타입추론으로 String값을 갖는걸까
// 복습시 생각할거리2 : 위의 totalDamage가 암시적언래핑 타입이라면 원하는결과를 얻기 위해 어떻게 해야할까
var gotDamage = totalDamage?.uppercased() ?? "No Damage"
print (gotDamage)
```

