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
    func averageCalculation(student: Student) -> Double
    {
        var totalScore: Int = 0
        let subjects = student.subjects
        
        for subjects in subjects
        {
           totalScore += subjects.score
        }
        // 평균내기
        
        return Double(totalScore)/Double(subjects.count)
    }
}







