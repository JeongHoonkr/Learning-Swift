## String

* 정의

  > 문자들의 열



* 기본문법 

  ```swift
  var greetingMessage: String = "How are u doing? "
  let name: [String] = ["Jeong Hoon", "Hyun Ah", "Min Ji"]
  var additionalMessage = " Did you finish your homework?"
  var messages: [String] = []

  var finalMessage: String = ""
  for names in name {
      finalMessage = greetingMessage + names + additionalMessage
      messages.append(finalMessage)
  }
  ```



* 문자열을 구성하는 문자들의 타입 : **Character**

  ```swift
  // 위의 기본문법 사용에서 이어짐

  for sentence in messages {
      for character in sentence.characters {
          print (character)
      }
  }
  ```



* 문자열의 특정문자에 접근하기

  * **스위프트에서는 서브스크립트 인덱스로 문자열의 특정문자에 접근할 수 없다.**

    **따라서 특정문자에 접근하기 위해서는 아래의 다양한 방법을 활용할 수 있다.**

    ​

    * **startIndex** :  비어있지 않은 문자열의 첫번째 문자의 위치를 말한다.

    * **endIndex** : 문자열에서 마지막으로 유효한 문자보다 한단계 더 큰 위치를 말한다.

      따라서 문자열의 구간을 배열로 설정할때 아래 예제처럼 **..<** 이렇게 설정해줘야

      해당 문자열의 마지막 인덱스까지 나타낼 수 있다.

      ```swift
      let playGround = "Hello playground"
      let start = playGround.startIndex
      // let end = playGround.index(start, offsetBy: 15)

      let lastCharacter = playGround[start..<playGround.endIndex]
      //let lastCharacter = playGround[playGround.startIndex..<playGround.endIndex]
      print(lastCharacter)
      // 생성한 문자열 : Hello playground
      ```

      ```swift
      // 0. StartIndex 및 endIndex의 활용

      // 1.startIndex를 변수에 넣어서 해당 변수로 범주 설정하기
      let myname: String = "JeongHoon Choi"
      let first = myname.startIndex
      if let firstSpace = myname.characters.index(of: " ") {
      let lastName = String(myname.characters[first..<firstSpace])
          print(lastName)
      }

      // 2. startIndex설정없이 ..<으로 첫번째 인덱스 자동으로 범주에 잡히게 하기
      let myname: String = "JeongHoon Choi"
      if let firstSpace = myname.characters.index(of: " ") {
          let lastName = String(myname.characters[..<firstSpace])
          print(lastName)
      }
      ```

    ​       

    * 특정 문자 제거하기

      > 특정 문자를 제거하기 위해서는 **trimmingCharacters**라는 메소드를 사용한다.
      >
      > (단 이 메소드는 양끝의 문자만 제거가능)

      ```swift
      var firstString = "$함박스테이크"
      var secondString = "#맛있어"
      var thirdString = "#사줄래?!"

      // 결과값 함박스테이크
      print(firstString.trimmingCharacters(in: ["$"]))

      // 결과값 맛있어
      print(secondString.trimmingCharacters(in: ["#"]))

      // 결과값 사줄래?
      print(thirdString.trimmingCharacters(in: ["#", "!"]))
      ```

      ​

      > 중간에 있는 문자를 제거하기 위해서는 **Components** 메소드를 사용한다.

      ```
      10/3일 과제
      ```

      ​

    ​

    * **특정 index의 문자찾기**

      > 특정 인덱스의 문자를 찾기 위해서는 **index(_:offsetBy:)**메소드를 사용해야 한다.

      ![index method](http://postfiles15.naver.net/MjAxNzEwMDJfMjU5/MDAxNTA2OTQ1MjMzMTU5.1F3t6X4aiVTNGZl1rCTAYDNRHyeFL8uk_WLuSo1nsuYg.VHBRKt1a9ZuVkQPvS6Ls2WHEZ4mWYS1JttaCDV-M4W0g.PNG.bb_9900/스크린샷_2017-10-02_오후_8.52.21.png?type=w2)

      ```swift
      let myname: String = "JeongHoon Choi"

      // 문자열의 첫번째 인덱스를 startIndex상수에 넣기
      let startIndex = myname.startIndex

      // 첫번째 인덱스로부터 8만큼 떨어져 있는 문자의 인덱스를 end상수에 넣기
      let end = myname.index(startIndex, offsetBy: 8)

      // end 인덱스가 담긴 문자를 eighthindex에 넣기
      let eighthIndex = myname[end]

      // 출력
      print(eighthIndex)
      // print(eignthIndex) == n
      ```



