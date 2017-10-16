//
//  main.swift
//  ㄴㅇㄹㄴㅇㄹ
//
//  Created by Choi Jeong Hoon on 2017. 10. 15..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation

var a: Int = 1
var totatlNum = 0

while a < 100 {
    totatlNum += a
    a += 1
}
print(totatlNum)


// 1 ~ 100까지 사이에 3의 배수가 몇개 있는지
func threeTimesNum (fromNum: Int, toNum: Int) -> Int {
    var count: Int = 0
    var numArray: [Int] = []
    for i in fromNum...toNum {
        if i % 3 == 0 {
            numArray.insert(i, at: 0)
        }
        count = numArray.count
    }
    return count
}
print(threeTimesNum(fromNum: 1, toNum: 100))

// 1 ~ 100까지의 짝수합, 101 ~ 200 까지의 짝수합, 201 ~ 300 까지의 짝수합


