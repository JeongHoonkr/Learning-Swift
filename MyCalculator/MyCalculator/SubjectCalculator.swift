//
//  SubjectCalculator.swift
//  MyCalculator
//
//  Created by Choi Jeong Hoon on 2017. 9. 12..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation


class SubjectCalculator
{
    func calculation(student: Student)
    {
        var totalScore = sumAllSubject(subjects: student.subjects)
    }
    
    func sumAllSubject(subjects: [Subject]) -> Int
        
    {
        var totalScore: Int = 0
        for s in subjects
        {
          totalScore += s.score
        }
        return totalScore
    }
}













