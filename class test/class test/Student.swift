//
//  Student.swift
//  class test
//
//  Created by Choi Jeong Hoon on 2017. 9. 13..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation



class Student
{
    let name: String
    var grade: String
    var id: Int
    var subjects: [Subject]

    init(name: String, grade: String, id: Int, subjects: [Subject]) {
        self.name = name
        self.grade = grade
        self.id = id
        self.subjects = subjects
    }
    
    
    func studying ()
    {
        
    }
}


