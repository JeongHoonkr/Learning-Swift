//
//  Customer.swift
//  Account
//
//  Created by Choi Jeong Hoon on 2017. 9. 14..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation


class Celsius
{
    var temperature: Double

    
    init (fromFahrenheit fahrenheit: Double)
    {
        self.temperature = (fahrenheit - 32.0) / 1.8     // self를 안붙혀도 에러가 안남
        
    }

}

let boilingOfWater = Celsius(fromFahrenheit: 195.0)

print(boilingOfWater)
