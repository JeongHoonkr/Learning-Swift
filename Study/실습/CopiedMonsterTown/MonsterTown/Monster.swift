//
//  Monster.swift
//  MonsterTown
//
//  Created by Choi Jeong Hoon on 2017. 11. 20..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation

class Monster {
    var town: Town?
    var name: String = "Monster"
    
    var victim: Int {
        get {
            return town?.population ?? 0
        }
        set (newVictim) {
            town?.population = newVictim
        }
        
    }
    
    func terroizeTown() {
        if town != nil {
            print ("\(name) is terrorizing a town!")
        } else {
            print ("\(name) hasn't fount a town to terrorize yet...")
        }
    }
}
