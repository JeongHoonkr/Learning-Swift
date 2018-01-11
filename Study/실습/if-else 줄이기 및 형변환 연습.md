## IF-else 줄이기 및 형변환 연습



#### 1. 단순 if-else구문일경우

```swift
if matchValue != [] {
   return true
} else {
   return false
}

// 아래처럼 단순화할 수 있다.
return !matchValue.isEmpty
return matchedValue != []
```



#### 2. 형변환 시도들

```swift
// 아래 형변환함수에 들어갈 값을 리턴하는 함수
// getJsonObject(inputValue) -> returnType = Dictionary<String,Any>
// getJsonArray(inputValue) -> returnType = [String]
static func makeAnalyzedTypeInstance (_ inputValue: String) -> Any {
   return inputValue.first == "{" ? getJsonObject(inputValue) : getJsonArray(inputValue)
}

// !를 사용하지 않아보려고 4가지 시도를 해보다가 PR보낸건 마지막 4번

// 1. switch case let 사용
// 단점 : default에 의미없는 ""를 넣어야 함
switch input {
case let some as [String]  :
  return getCountedArrayType(some)
case let som as Dictionary<String,Any> :
  return getCountedObjectType(som)
default : // 사용하지 않을 의미없는 코드를 적어야함
}

// 2. if let형변환후 else 내부에서 형변환 후 nil체크로 사용
// 단점 : 어쨋튼 objValue에 대입할떄 !를 찍어야함
if let dicValue = input as? [String] {
    return getCountedArrayType(dicValue)
} else  {
    var objValue =  Dictionary<String,Any> ()
    if ((input as? Dictionary<String,Any>) != nil) {
        objValue = input as! Dictionary<String, Any>
    }
    return getCountedObjectType(objValue)
}

// 3. 위와 비슷하나 if let, else if let 사용
// 단점 : 마지못해 else를 써서 1번과 같이 의미없는 코드를 써야함
if let dicValue = input as? [String] {
    return getCountedArrayType(dicValue)
} else if let objValue = input as? Dictionary<String,Any> {
    return getCountedObjectType(objValue)
} else {
    // 쓰지 않을 의미없는 코드를 넣어야 Missing return을 안봄
}

// 4. 1~3 해보고 최종 제출한것
// 사유 : !를 보기 싫지만 어차피 Parsing되어 들어올것은 [String:Any]와 [String] 두가지 뿐이니 ! 붙혀도 크래쉬날일 없기 때문
switch input {
case is Dictionary<String,Any> :
    return getCountedObjectType(input as! [String : Any])
default:
    return getCountedArrayType(input as! [String])
}
```

