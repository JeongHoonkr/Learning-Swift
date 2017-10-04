# Switch

* 정의 

  > 여러 조건을 달리하여 처리하는 조건문 



* if-else와의 차이점

  > if-else는 조건을 true로 판단했는지에 따라 코드를 달리 실행하는 반면,
  >
  > switch는 특정 값에 따라 경우의 수를 나눠 판단한다. 즉 특정값과 일치하는 경우에 해당 코드를 실행하는 것이다.



* 기본문법

  ```
  switch aValue {
  case someValueToCompare:
      // 이 값에 다른 코드를 실행
  case anotherValueToCompare:
      // 이 값에 따른 코드를 실행
  default:
      // 앞에서 일치하는 경우가 하나도 없을때 실행
  }
  ```

  * default는 반드시 있어야 하는 요소는 아니지만, 모든 경우가 일일히 대조될 경우는 반드시 있어야 한다.

    즉 만약 avalue의 값이 모든 경우와 일치할 경우는 필요없지만 그렇지 않을 경우는 default값이 있어야 한다.

* 사용

  ``` SWIFT
  var statusCode: Set<Int> = [400, 401, 402, 403, 404, 405, 406]
  var errorString: String = "The request failed : "

  for number in statusCode {
      switch number {
        // 1. switch에서는 case에 하나의값 || 여러개의 값 || 구간값이 올 수 있다.
        // 1-1. 하나의 값
      case 400:
          "bad request"
        // 1-2. 구간값
      case 401...405:
          "Unauthorized"
          "Critical"
      case 406:
          errorString += "It's Not Error,"
          // 2. fallthrough : 제어권 전달문 = fallthrough가 있는 case의 코드를 실행하고
          //    아래에 있는 코드도 일치여부와 상관없이 무조건 실행
          fallthrough
      default:
          errorString += "Please reboot server"
      }
  }
  ```



* where의 사용

  >  조건의 범주를 추가하기

  ```swift
  var statusCode: Int = 204
  var errorString: String = "The request failed with the error."

  switch statusCode {
  case 100, 101:
    // 값 바인딩 사용 : 바인딩이란 각종 변수값들이 실제값으로 묶이는 것이다.
      errorString += " Informational, \(statusCode)."
  case 203:
      errorString += " Successful but no content, 204."
  case 300...307:
      errorString += " Redirectionm \(statusCode)."
  case 400...417:
      errorString += " Client error, \(statusCode)."
  case 500...505:
      errorString += " Server error, \(statusCode)."
  case let unknownCode where (unknownCode >= 204 && unknownCode < 300 || unknownCode > 307 && unknownCode < 400 || unknownCode > 417 && unknownCode < 500 || unknownCode > 505) :
      errorString += "\(unknownCode) is not a known error code"
  default:
      errorString = "\(statusCode) is not a known error code"
  }
  ```



* 조건이 하나뿐이고 default를 고려하지 않아도 될때 switch를 대체하는 if-case (where문의 범위효과)

     ```swift
  let age: Int = 25
  if case 18...35 = age, age >= 21 {
      print ("cool" + ", You can drink Alchole")
  }
     ```

  ​

* Switch 응용

    ```swift
  let point = (x: 1, y: 4)

  switch point {
  case let q1 where ((point.x > 0) && (point.y > 0)) :
      print("\(q1) is in quadrant 1")
      fallthrough
  case (_, 4):
      print("\(point) sits on the x-axis")
  case let q2 where (point.x < 0) && (point.y > 0):
      print("\(q2) is in quadrant 2")
  case let q3 where (point.x < 0) && (point.y > 0):
      print("\(q3) is in quadrant 3")
  case let q4 where (point.x > 0) && (point.y > 0):
      print("\(q4) is in quadrant 4")

  case (0, _):
      print("\(point) sits on the y-axis")
      
  default:
      print ("Case not covered")
  }
    ```

  ​