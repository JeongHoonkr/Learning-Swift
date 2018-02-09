## Map, Filter, Reduce 연습



```swift
let sampleNumbers = [1000, 2123,567,1212,5411]

// 컬렉션내 값들을 2배로 map
let doubledNumbers = sampleNumbers.map { (element: Int) -> Int in
    element * 2
}

// 컬렉션내 값들 중 2000초과 하는 값 filter
let overTwoThousandNumbers = doubledNumbers.filter { (element: Int) -> Bool in
    element > 2000
}

// 컬렉션내 값들을 하나의 값으로 축소
// for문의 사용
var result: Int = 0
for number in overTwoThousandNumbers {
    result += number
}
print ("result", result)

// reduce사용
// let 상수를 사용하였는데, 연산후에 값을 바꾸지 않으므로 상수를 쓸 수 있다.
// 앞의 for 문에서는 va 변수이기 때문에 실수로 값을 바꿀 여지가 있는데
// reduce 함수로 사용하면 이런 실수를 줄일 수 있다.
let totalNumber = overTwoThousandNumbers.reduce(1) { (accumulatedNum: Int, element: Int) -> Int in
    print("\(accumulatedNum) + \(element)")
    //1 + 4246
    //4247 + 2424
    //6671 + 10822
    return accumulatedNum + element
}
print ("total",totalNumber)
//total 17493
```

