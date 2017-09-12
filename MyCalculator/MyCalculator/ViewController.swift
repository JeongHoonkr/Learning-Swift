//
//  ViewController.swift
//  MyCalculator
//
//  Created by Choi Jeong Hoon on 2017. 9. 11..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    let cal = SubjectCalculator()
    
    let math = Subject(name: "수학", score: 100)
    let english = Subject(name: "영어", score: 50)
    
    
    let s1 = Student(name: "최정훈", id: 1225)
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
// Dispose of any resources that can be recreated.

    }


}

/*
 
 */
