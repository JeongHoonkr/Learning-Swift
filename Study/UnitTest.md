## UnitTest (단위테스트)



### 1. 정의

* 컴퓨터 프로그래밍 소스코드의 특정모듈이 의도된 대로 정확히 작동하는지 검증하는 절차다.
* 작성된 모든 함수와 메서드에 대한 테스트 케이스를 작성하는 절차를 말한다.



### 2. 테스트란 무엇인가

* ##### 일반적으로, 테스트는 다음을 포함해야 한다.

  - 핵심기능 : 모델 클래스와 메소드, 컨트롤러와의 상호작용
  - 가장 일반적인 UI 흐름도(workflows)
  - 경계 조건(boundary conditions)
  - 버그 수정

* ##### 버그 수정FIRST : 테스트에 대한 모범사례 (Best Practices for Testing)

  두문자어 `FIRST`는 단위 테스트를 위한 간결한 기준(criteria) 세트를 효과적으로 설명한다. 해당 기준은 다음과 같다.

  * `Fast`(빠르게) : 테스트는 빨리 실행되야 한다. 그래서 사람들이 신경쓰지 않는다.
  * `Independent/Isolated`(독립적/분리된) : 테스트는 따로 설정이나 분리를 해서는 안된다.
  * `Repeatable`(반복가능한) : 테스트 수행할때마다 동일한 결과를 얻어야 한다. 외부의 데이터 공급자나 동시성(concurrency) 문제로 인해 일시적으로 오류가 발생 할수 있다.
  * `Self-validating`(자체 검증) : 테스트는 완전히 자동화 되어야 한다. 로그 파일에 대한 프로그래머의 해석보다는 패스(pass)또는 실패(fail)를 출력해야 한다.
  * `Timely`(적시에) : 이상적인 테스트는 테스트한 생산 코드를 작성하기 전에 작성해야 한다.



### 3. 테스트파일 생성시 나타나는 메소드 살펴보기

* setUp() == 초기화코드

  : This method is called **before** the invocation of each test method in the class

​       : 테스트시 필요한 항목이나 특정상태를 생성하는 작업을 수행한다. 

​         (객체 인스턴스 만들기, db초기화, 규칙작성 등)

* tearDown() == 해체코드

  : This method is called **after** the invocation of each test method in the class.

  : 테스트가 끝날때 앱 상태를 초기상태로 복원해주는 메소드

    (파일닫기, 연결, 새로만든 항목들 제거, 트랜잭션(?) 콜백 호출 등)



```swift
class SetUpAndTearDownExampleTestCase: XCTestCase {
    
    override class func setUp() { // 1.
        super.setUp()
        // This is the setUp() class method.
        // It is called before the first test method begins.
        // Set up any overall initial state here.
    }
    
    override func setUp() { // 2.
        super.setUp()
        // This is the setUp() instance method.
        // It is called before each test method begins.
        // Set up any per-test state here.
    }
    
    func testMethod1() { // 3.
        // This is the first test method.
        // Your testing code goes here.
        addTeardownBlock { // 4.
            // Called when testMethod1() ends.
        }
    }
    
    func testMethod2() { // 5.
        // This is the second test method.
        // Your testing code goes here.
        addTeardownBlock { // 6.
            // Called when testMethod2() ends.
        }
        addTeardownBlock { // 7.
            // Called when testMethod2() ends.
        }
    }
    
    override func tearDown() { // 8.
        // This is the tearDown() instance method.
        // It is called after each test method completes.
        // Perform any per-test cleanup here.
        super.tearDown()
    }
    
    override class func tearDown() { // 9.
        // This is the tearDown() class method.
        // It is called after all test methods complete.
        // Perform any overall cleanup here.
        super.tearDown()
    }
    
}
```

