## Dictionary

#### 1. 정의

> 데이터를 key와 value의 쌍으로 담아 두는 자료형으로 순서가 없다.
>
> ex) key는 금고열쇠, value는 금괴



#### 2. 특징

> key의 자료형과 value의 자료형은 다를 수도 있으며, 특히 value의 자료형에는 
>
> 어떤 타입이든 가능한 any로 선언할 수 있다.



#### 3. 선언 및 초기화하기

```swift
let dic1: Dictionary<Int, Double> = [:]
let dic2 = Dictionary<String, String>()
let dic3: [String : Any] = [:]
let dic4 = [Int : String]()
let dic5 = [20171001 : "일요일",
            20171002 : "월요일",
            20171003 : "화요일",
            20171004 : "수요일",
            20171005 : "목요일" ]
let dic6: [String : Any] = [ "Name"     : "정훈"
                             "favoriteNum" : [5,2,3]
                             "Gpa"      : 4.1 ]
```



#### 4. 접근 및 변경하기

   **(1) 접근하기** : Dictionary에의 접근은 대괄호 '[]' 서브스크립트 문법으로 접근 가능하다. **(key로만 접근가능)**

```swift
var movieRatings = ["시카고" : 8, "인터스텔라" : 9, "변호인" : 10]
var chicagoRating = movieRatings["시카고"]
```

![dd](http://postfiles14.naver.net/MjAxNzEwMDRfMTE1/MDAxNTA3MTE4ODU4NzY1.Yr6uhAYMOHSIAeJMwoTaAeTozNeDHlZ6-dZm0FnI4ZQg.fqVc3c_2UXMC1Nfun77llXEF6LU5zItpQ5boLPRBj68g.PNG.bb_9900/스크린샷_2017-10-04_오후_9.07.07.png?type=w773)

> 분명 movieRatings의 타입은 [String : Int]인데 왜 chicagoRating은 optional Int일까?
>
> 그 이유는 Dictionary는 요청받은 값이 존재하지 않을 가능성을 염두해둔 반환값을 nil로 갖고 있기 때문이다.
>
> 따라서 Dictionary타입에서 파싱해온 값을 사용할때는 옵셔널바인딩을 해줘야 한다.

```swift
var movieRatings = ["시카고" : 8, "인터스텔라" : 9, "변호인" : 10]
let firstRating = movieRatings["시카고"]
let secondRating = movieRatings["인터스텔라"]

var totalRating: Int = 0
if let rating1 = firstRating, let rating2 = secondRating {
    totalRating = rating1 + rating2
}
print(totalRating) // 값은 17
                   // 바인딩하지 않으면 더하기 연산조차 할 수 없고, 개별적으로 프린트시 옵셔널에 감싸여있다.
```



   **(2) 수정하기** 

​       (2)-1. 단순수정 : 접근하기로 접근 후 값을 변경해주면 된다.

```swift
movieRatings["시카고"] = 9
```



​       (2)-3. ```updateValue(value,  forkey: )``` 사용

> ***updateValue메소드는*** 해당키에 해당하는 값이 있다면 딕셔너리의 값은 최신화하고 
>
> ***옵셔널타입의 이전값을 반환한다.*** (remove가 삭제시 삭제전 값을 반환하는 것과 동일하다.)
>
> 반면 해당키가 딕셔너리에 존재하지 않는다면 nil을 반환한다.

```swift
var movieRatings = ["시카고" : 8, "인터스텔라" : 9, "변호인" : 10]
let firstRating = movieRatings["시카고"]
let secondRating = movieRatings["인터스텔라"]

let oldRatingofChicago: Int? = movieRatings.updateValue(9, forKey: "시카고")
// 아래의 '남한산성'이라는 키는 movieRatings의 딕셔너리에 없는 키다. 따라서 반환값은 nil이다.
// let unknownRating: Int? = movieRatings.updateValue(9, forKey: "남한산성")

var comparitiveRating: String = ""
if let oldRating = oldRatingofChicago, let newRating = movieRatings["시카고"] {
    comparitiveRating = "시카고 평점 = 과거 :  \(oldRating)점, 최신 :  \(newRating)점"
}
```



   **(3) 추가 및 제거하기**

​        (3)-1. 추가하기 : 서브스크립트 문법활용하여 추가

```swift
movieRatings["킹스맨2"] = 7
```



​       (3)-2. 제거하기 : ```removeValue(forkey:)``` 메소드로 제거	

> (2)-3과 마찬가지로 해당키가 존재한다면 딕셔너리의 키에 해당하는 값을 삭제하고
>
> ***삭제값은 옵셔널 타입으로 반환한다***. 반면 해당키가 존재하지 않는다면 nil을 반환한다. 
>
> <참고 : 삭제값을 저장하는것은 선택사항이다.>

```swift
let kingsman2OldValue = movieRatings.removeValue(forKey: "킹스맨2")
```



​       (3)-3. 제거하기 : 키의 값을 nil로 설정하기

```swift
// 추가하고 삭제하기
// 삭제된 값을 저장할 필요가 없다면 이 방법이 더 간단해 보인다.
movieRatings["킹스맨2"] = nil
```



#### 5. 루프 적용하기

> 1. 딕셔너리의 키와 값에 해당하는 임시 상수를 구성하고 이들을 for in문에 튜플 형태로 두기
> 2. 딕셔너리는 키와 값에 해당하는 프로퍼티를 따로 갖고 있기 때문에 for문에 각각 넣어 사용할 수도 있다. 

```swift
var movieRatings = ["시카고" : 8, "인터스텔라" : 9, "변호인" : 10]

movieRatings["킹스맨2"] = 7

// 1. 키와 값을 튜플에 넣어 루프 적용
for (movieName, rating) in movieRatings {
    print ("\(movieName)의 평점은 \(rating)점 입니다.")
}

// 2. 키만 넣어 루프 적용
for movie in movieRatings.keys {
    print ("오늘 본 영화는 \(movie) 입니다.")
}

// 3. 값만 넣어 루프 적용
for rating in movieRatings.values {
    print ("난 그 영화에 \(rating)점 준다.")
```



#### 6. 딕셔너리를 배열로 변환하기

> ```Array()``` 문법구조를 활용

```swift
let watchedMovieLisdt = Array(movieRatings.keys)

// 아래는 처음 내가 생각했던 방법이다. , 위에가 훨씬.... 간단하다 ㅋㅋ
var movieListISaw: [String] = []
for movie in movieRatings.keys {
    movieListISaw.append(movie)
}
print(movieListISaw)
```



#### 7. 딕셔너리 활용 예시

```swift
var roomCapacity: [String: Int] = ["Basky": 4, "Kanlo" : 5, "Picasso": 10, "Cezenne": 22,"Matisse": 30, "Rivera": 40]

// dictionary의 key와 value 모두 switch에서 대조값으로 적용 가능하다
// switch의 case에는 value만 와야 한다고 되어 있는데 딕셔너리의 key가 value로 인식되나보다
// key와 value는 쌍으로 이루어져야 하는건 동일하다

func identifyingRoom () -> [String] {
    var roomDescription: String = ""
    var result: [String] = []
    for (roomName, capacities) in roomCapacity {
        switch roomName {
        case "Basky", "Kanlo" :
            roomDescription = "\(roomName)은 스터디룸이며, 정원은 \(capacities)명입니다."
        case "Picasso", "Cezenne" :
            roomDescription = "\(roomName)은 티 세미나룸이며, 정원은 \(capacities)명입니다."
        case "Matisse" :
            roomDescription = "\(roomName)은 그룹 세미나룸이며, 정원은 \(capacities)명입니다."
        case _ where capacities > 30 :
           roomDescription = "\(roomName)의 정원은 \(capacities)명이며 별도의 사용신청이 필요합니다."
        default:
            roomDescription = "\(roomName)의 정보를 다시 확인해 주십시요."
        }
        result.append(roomDescription)
    }
    return result
}

identifyingRoom()
```

