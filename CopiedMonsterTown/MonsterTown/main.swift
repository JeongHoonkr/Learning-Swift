//
//  main.swift
//  MonsterTown
//
//  Created by Choi Jeong Hoon on 2017. 11. 16..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation

var myTown = Town()
// 지연 프로퍼티는 첫 엑세스 때 한 번만 계산되고, 이후에는 다시 계산되지 않는다.
let myTownSize = myTown.townSize
print(myTownSize)
myTown.changePopulation(by: 1_000_000)
print("Size: \(myTown.townSize), population: \(myTown.population)")
let zombie = Zombie()
zombie.town = myTown
zombie.terroizeTown()
zombie.town?.printDescription()
print ("Victim: \(zombie.victim)")
zombie.victim = 500
print ("victim: \(zombie.victim)")


