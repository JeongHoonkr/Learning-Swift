## VendingMachine 5단계



##### 학습사항

- SwiftLint가 무엇인지 알고, 프로젝트에 적용하기
  - SwiftLint는 프로젝트상 문법이나 코딩스타일의 개선점을 알려줘서, 일관성을 높혀주는 역할을 한다.
  - 적용을 위해서 cocoapods를 설치하고 podfile의 편집을  통해 프로젝트에 적용했다.



**어려웠던점**

- SwiftLint도 낯선 용어였는데, 사용을 위해 cocoapods를 설치하고 적용해야 하는 부분이 어려웠다.

  > CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects.

  * 코코아팟의 정의를 찾아보면 위와 같이 나와있다.

  * 즉 프로젝트를 위해 외부 라이브러리를 이것저것 쓰게 되는데 그것들을 관리해주는 도구이다.

    (예를 들면 스카이림의 [SkyUI](https://www.nexusmods.com/skyrim/mods/3863/)라고 볼 수 있다.)



##### 적용이후

![에러](https://postfiles.pstatic.net/MjAxODAzMjlfMjU2/MDAxNTIyMzAxMDQ4ODkw.gucrLOWVCLCTwzHK8VR8pIhgs3hVkPegVQc5efZCLqYg.yrnzoSitGtyKrzZchOV_WfV6NcUjdi0ydvzMbbaVfTwg.PNG.bb_9900/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2018-03-27_%EC%98%A4%EC%A0%84_11.54.07.png?type=w773)

* warning 95개, error 14개다 뜨고 있다. 심지어 빌드조차 안되는 상태였던 것...

  > 에러는 크게 아래 유형으로 나눌 수 있었고 모두 수정해서 적용했다.

  * 코드라인마다 불필요하게 존재했던 화이트스페이스 
  * 네이밍이 가이드라인에 맞지 않았음
  * 콜론 앞뒤 공백의 존재
  * for 구문내에 if문을 바로 사용했던 것 (for where로 대체 가능)
  * 튜플 리턴값이 3개이상되면 너무 많다. (타입알리아스로 대체 가능)