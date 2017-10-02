## Dictionary

* 정의

  > 데이터를 key와 value의 쌍으로 담아 두는 컬렉션 타입으로 키와 값은 서로 짝을 맞춰 딕셔너리에 저장된다.
  >
  > ex) key는 금고열쇠, value는 금괴







     ```swift

var roomCapacity: [String: Int] = ["Baksy": 4, "Rivera": 40, "kanlo" : 8, "Picasso": 10, "Cezenne": 24,"Matisse": 30]

// dictionary의 key와 value 모두 switch에서 대조값으로 적용 가능하다
// switch의 case에는 value만 와야 한다고 되어 있는데 딕셔너리의 key가 value로 인식되나보다
// key와 value는 쌍으로 이루어져야 하는건 동일하다
for (roomName, capacities) in roomCapacity {
    let roomDescription: String
    switch roomName {
    case "Basky" :
        roomDescription = "\(roomName)은 스터디룸이며, 정원은 \(capacities)명입니다."
    case "Rivera", "kanlo" :
        roomDescription = "\(roomName)은 티 세미나룸이며, 정원은 \(capacities)명입니다."
    case "kanlo" :
        roomDescription = "\(roomName)은 그룹 세미나룸이며, 정원은 \(capacities)명입니다."
    case let caseCapacity where capacities > 30 :
        roomDescription = "\(roomName)의 정원은 \(capacities)명이며 별도의 사용신청이 필요합니다."
    default:
        roomDescription = "\(roomName)의 정보를 다시 확인해 주십시요."
    }
}

     ```

