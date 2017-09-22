//
//  Function.swift
//  isKnowingTest
//
//  Created by Choi Jeong Hoon on 2017. 9. 22..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation



class Breakthrough {
    var resultValue1: Int = 0
    var resultValue2: Int = 0
    var resultValue3: Int = 0
    
// 연속 중복 숫자 줄이기 함수

    func reducingNum (inputNum: Int) -> Int {
        var firstArray: [Int] = []
        var secondArray: [Int] = []
        var resultValue1: Int = 0
        var inputNum = inputNum
    
    while inputNum > 0 {
        firstArray.insert(inputNum % 10, at: 0)
        inputNum /= 10   // [1,1,2,2,3,3]
    }
        print(firstArray)
    
    secondArray.insert(firstArray[0], at: 0)
    for i in 1..<firstArray.count {      //  문제점 : 처음에 firstArray만 넣어서 문제 해결 안됨
        if firstArray[i-1] != firstArray[i] {
            secondArray.append(firstArray[i])}
    }
    print(secondArray)
    
    for j in secondArray {   // [1,2,3]
        resultValue1 *= 10
        resultValue1 += j }
    print(resultValue1)
    return resultValue1
}


// 윤년 구하기

    func chekLeapYear (inputYear: Int) -> String {
        var resultValue2 : String = ""
    if inputYear % 4 == 0 && inputYear % 400 == 0 || inputYear % 100 != 0 {
        resultValue2 = "inputYear is leapyear"}
    else {
        resultValue2 = "Inputyear is not leapyear"}
    return resultValue2 }


// 자리수 더하기
    func addDigit (inputNum: Int) -> Int {
        var resultValue3: Int = 0
        var arrayFirst: [Int] = []
    var inputNum = inputNum
    while inputNum > 0 {
       arrayFirst.insert(inputNum % 10, at: 0)
       inputNum /= 10 }
    
    for i in 0..<arrayFirst.count {
        resultValue3 += i }
    return resultValue3 }
}




