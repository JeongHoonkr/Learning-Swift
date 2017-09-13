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
    
    func setScore(s: Int)
    {
        score = s
        changeGrade()
    }
    
    func changeGrade()
    {
        if score > 0 && score <= 100
        {
            if score >= 95 {
                grade = "A+"
            }
            else if score >= 80 {
                grade = "B"
            }
            else if score >= 70 {
                grade = "C"
            }
            else {
                grade = "재시험"
            }
        }
    }
}
