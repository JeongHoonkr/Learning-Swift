## Fizz Buzz 풀이

* For _ in 문만 사용

  ```swift
  for i in 1...100 {
      if i % 3 == 0 {
          print ("Fizz")
      } else if i % 5 == 0 {
          print ("Buzz")
      } else if i % 3 == 0 && i % 5 == 0 {
          print ("Fizz Buzz")
      } else {
          print (i)
      }
  }
  ```



* for switch문 사용

  ```swift
  for j in 1...100 {
      switch j {
      case _ where (j % 3 == 0):
          print ("Fizz")
      case _ where (j % 5 == 0):
          print ("Buzz")
      case _ where (j % 3 == 0 && j % 5 == 0):
          print ("Fizz Buzz")
      default:
          print (j)
      }
  }
  ```

  ​

* for switch if/else사용

  ```swift
  var numberArray: [Int] = []
  for i in 1...100 {
      numberArray.append(i)
  }

  for number in numberArray {
      switch number {
      case 1...100 :
          if number % 3 == 0 {
              print ("Fizz")
          } else if number % 5 == 0 {
              print ("Buzz")
          } else if number % 3 == 0 && number % 5 == 0 {
              print ("Fizz Buzz")
          } else {
              print (number)
          }
      default :
          print ("unidentified")
      }
  }
  ```

  ​