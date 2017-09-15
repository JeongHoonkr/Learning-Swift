



import Foundation


var isAdd: Bool = true    // 더할 수 있는지 확인 <더할 수 있으면 트루, 없으면 false>


if !isAdd == true   //더할수 없는게 트루 if문
{
    print ("더할 수 있어")
}
else {
    print ("더할 수 없어")
}


isAdd = false   //  더할 수 있는지 확인하는 isAdd의 초기값이 true라고 했기 때문에 false의 값은 if문의 else출력,

if !isAdd == true   //더할수 없는게 트루 if문
{
    print ("더할 수 있어")
}
else {
    print ("더할 수 없어")
}



var isMultiple: Bool = true     // 곱할 수 있는지 확인 (곱할 수 있으면 트루, 없으면 false)

if !isMultiple == true
{
    print ("곱할 수 없어")
} else {
    print ("곱할 수 있어")
}


isMultiple = true // 곱할 수 있는지 확인하는 변수의 초기값이 true이기 때문에, !(Not)isMultiple이 트루라고 하는 첫번째 if문은 건너뛰고 else출력

//****************절취선********************

// bool값을 false로 했을때가 헷갈리는데요


var isAddSome: Bool = false   // 더할 수 있는지 확인 <더할 수 없으면 false, 있으면 true>

if isAddSome == true
{
    print ("You can not add")
}
else {
    print ("You can add")
}

isAddSome = true  // 더할수 있는지 확인하는 초기값이 false즉 더할 수 없기 때문에 더할 수 있는지 물을때 값이 true이면 더할 수 있는것???


var isPositiveNumber: Bool
var number: Int = 20

if number > 0 {
    isPositiveNumber = true
} else {
    isPositiveNumber = false
}

if isPositiveNumber {
    
} else {
    
}





