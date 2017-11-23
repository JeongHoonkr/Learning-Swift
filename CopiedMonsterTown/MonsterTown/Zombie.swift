//
//  Zombie.swift
//  MonsterTown
//
//  Created by Choi Jeong Hoon on 2017. 11. 20..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation

// Moster클래스를 상속받는다.
class Zombie: Monster {
    var isWalkLively: Bool = true
    override var name: String {
        get {
             return "Another Monster"
        }
        set {
        }
    }
    
    override func terroizeTown() {
        town?.changePopulation(by: -10)
        // super는 슈퍼클래스의 메서드 구현 코드에 접근하는데 사용하는 일종의 접두어다.
        super.terroizeTown()
    }
}


