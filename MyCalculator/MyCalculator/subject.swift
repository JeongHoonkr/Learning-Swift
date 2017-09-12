//
//  subject.swift
//  MyCalculator
//
//  Created by Choi Jeong Hoon on 2017. 9. 12..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation




class Subject
{
    var name: String = ""
    var score: Int = 0
    var credit: Int = 1
    var grade: String = "F"
    var gradePoint: Double = 0.0
    
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
}

