## MVC

> 모든 뷰는 MVC로 구성되어 있음

![MVC]()





 Model : 데이터

 View : 디스플레이로서 사용자의 역할을(액션으로) 받아서 컨트롤러에 전달 (전달하는 역할을 **addTarget**, **delegate**가 함)

​            (appdelegate : UI의 상태변화를 알려줌)

 Controller : 모델에서 데이터를 받아 뷰에 전달, 사용자의 데이터를 addTarget이나 delegate로 뷰에서 받아

​                      다시 모델로 전달 