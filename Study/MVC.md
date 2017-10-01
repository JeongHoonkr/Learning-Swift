## MVC

> 모든 뷰는 MVC로 구성되어 있음

![MVC](https://github.com/JeongHoonkr/IOS5-Studying-Record/blob/master/Individual%20Project/image/MVC.png?raw=true)

##### MVC의 목적 : 프로그램의 유지보수를 쉽게! 그리고 단위테스트를 할수있게!



 Model : 데이터에 관한 로직을 담는 부분, 모델 객체는 개발하고자 하는 유형을 지정하여 데이터를 그룹화하며, 

​                하나의 모델 객체는 다른 모델과 연관되어있다.

> 계산기라는 프로그램이 있다면 값들을 계산하고 저장하는 부분



 View : 디스플레이로서 사용자의 역할을(액션으로) 받아서 컨트롤러에 전달 (전달하는 역할을 **addTarget**, **delegate**가 함)

​            (appdelegate : UI의 상태변화를 알려줌)

> 계산기의 계산된 값들이 보여지는 부분

 Controller : 모델에서 데이터를 받아 뷰에 전달, 사용자의 데이터를 addTarget이나 delegate로 뷰에서 받아 

​                      다시 모델로 전달 



**reason: '-[UITableViewController loadView] instantiated view controller with identifier "UIViewController-BYZ-38-t0r" from storyboard "Main", but didn't get a UITableView.'**



