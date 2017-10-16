//
//  main.swift
//  CodeSquadLv2Test
//
//  Created by Choi Jeong Hoon on 2017. 10. 11..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation


func randomnumber(low: Int, high: Int) - >Int {
    
    let range = high - (low-1)
    
    return (Int(arc4random()) % range) + (low - 1)
}

let answer =  randomnumber(low: 0, high: 100)

var turn  =  1

while (true) {
    
    print("Guess #\(turn): enter a number between 0 and 100")
    
    if let userinput = readLine() {
        
        if let guess:Int = Int(userinput) {
            
            // Putting this here will only increase the guess count if their input in a number.
            turn += 1
            
            if guess < answer {
                
                print("choose a higher number")
                
                continue
            }
            
            if guess > answer {
                
                print ("choose a smaller number")
                
                continue
            }
            
            if guess == answer {
                
                print("wohoo you won")
                
                break
            }
        }
    }
}
