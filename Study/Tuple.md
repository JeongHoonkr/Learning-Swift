## Tuple

* 정의 

  > - 논리적 연관성이 있는 둘 이상의 값을 콤마(,)로 구분하여 묶은 일종의 유한 집합값의 리스트로써
  >
  > ​        index를 갖는 순서 리스트의 구조를 보인다 (array와 유사)
  >
  > - 여러조건을 달리하여 처리하는 조건문
  > - 여러 종류의 값을 리턴하는 함수등, 서로 다른 타입을 나타내는데 효과적
  >
  > ​       ex) (String, Int, Double)



* 기본문법

  ```swift
  // 1. 튜플 만들기, 타입만 지정해줘도 되고 함수처럼 값의 이름을 지어줄 수도 있다.
  // 1-1. 다양한 타입을 섞어 사용할 수 있다.
  let myInfo: (name: String, favoriteNum: Int, weight: Double) = ("최정훈", 7, 53.5)
  let someoneInfo: (name: String, favoriteNum: Int, weight: Double) = ("한그림", 12, 51.6)

  // 1-2. 값의 이름을 지정안해줘도 무방하나 직관적이지 않음, 이 경우 index값으로 접근가능
  let ints = (1, 2, 3, 4, 5)
  ints.0

  // 2. 값 할당시 타입을 명시해줄수도 있고, 타입생략도 가능하다
  let currentTime = (Int(15), String("\(35)분"), 15)

  // 3. 두개의 튜플을 하나의 튜플에 묶기
  // 3-1. 하나의 튜플을 두개의 튜플에 나눠넣기
  // 3-2. manInfo has myInfo, womanInfo has someoneInfo
  let twoPersonInfo = (myInfo, someoneInfo)
  let (manInfo, womanInfo) = twoPersonInfo

  // 4. 각각의 값에 접근하기
  let myinfoName = manInfo.name
  someoneInfo.weight
  ```



* 응용: 튜플과 스위치

  **<_ 와일드카드 사용>**  : '_' 언더바를 사용하는 것으로 해당 부분에 어떤값이 와도 상관없다는 말, 함수 등 여러 곳에서 사용

   본 스위치문의 케이스에서는 와일드카드를 제외한 나머지 코드만 대조하겠다는 용도로 사용

  ```swift
  let firstErrorCode = 404
  let secondErrorCode = 200
  let errorCodes = (firstErrorCode, secondErrorCode)

  switch errorCodes {
  case (404, 404) :
      print ("No items found.")
  case (404, _) :
      print ("First item not found.")
  case (_, 404) :
      print ("Second item not found.")
  default :
      print ("All tiems found.")
  }
  ```



​       <응용>  Tuple과 Switch문 사용

* ```swift
  for (roomName, capacities) in roomCapacity {
      let roomDescription: String
      switch roomName {
      case "Basky" :
          roomDescription = "\(roomName)은 스터디룸이며, 정원은 \(capacities)명입니다."
      case "Rivera", "kanlo" :
          roomDescription = "\(roomName)은 티 세미나룸이며, 정원은 \(capacities)명입니다."
      case "kanlo" :
          roomDescription = "\(roomName)은 그룹 세미나룸이며, 정원은 \(capacities)명입니다."
      case let caseCapacity where capacities > 30 :
          roomDescription = "\(roomName)의 정원은 \(capacities)명이며 별도의 사용신청이 필요합니다."
      default:
          roomDescription = "\(roomName)의 정보를 다시 확인해 주십시요."
      }
  }
  ```

  ​

