## 간접참조, 데이터타입, 함수호출 및 사용, String



#### 1. 간접참조 Indirection



값 자체보다 컨테이너, 연결, 별명 등을 사용해서 우회해서 참조하도록 하는 방식

```swift
func abc () -> Int {
  
  return 0
}

var b = abc()
```

> 위에서 b는 abc함수를 호출해서 담은 변수



#### 2. 데이터타입

모바일은 메모리가 항상 부족하기 때문에 데이터타입 선택에 주의해야한다



#### 3. 함수 호출 및 사용

함수내에서 '_' 언더바가 쓰이면 호출시 파라미터이름 생략가능

(함수명을 보고 호출시 파라메터를 생각할 수 있을때)

```swift
func add (_ number: Int, num2 number2: Int) -> Int {
   let sum = number + num2
  return sum
}
```



#### 4. String

> ```??``` 값이있으면 앞에것을 넣어주고 업으면 뒤에값을 넣어주는것

```swift
let name = "Marie Curie"
let firstspace = name.index(of " ") ?? name.endIndex 
// (옵셔널바이닝과 동작은 비슷하나 바인딩은아니다)
```



> a view of string

```swift
let cafe = "Cafe"
print(Array(cafe))
// 이렇게 하면 [c,a,f,e] 이렇게 나눠져서 배열에 담긴다.
```



> separator쓰는법
>
> ```print(_ items: Any..., separator: String = default, terminator: String = default)```

```swift
let hello: String = "hello"

print(3,14,89,15, separator: ",")
// print(_ items: Any..., separator: String = default, terminator: String = default)
```


