//
//  Town.swift
//  MonsterTown
//
//  Created by Choi Jeong Hoon on 2017. 11. 20..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation

struct Town {
    let region = "South"
    var population = 5_422 {
        didSet {
            print ("The population has changed to \(population) from \(oldValue)")
        }
    }
    var numberOfStoplights = 4
    
    enum Size {
        case small
        case medium
        case large
    }
    
    // 지연저장형 프로퍼티 : 값이 필요해야 계산한다는 뜻으로 인스턴스 초기화 이후로 계산이 미뤄진다.
    // 인스턴스가 만들어져야 알 수 있는 타입의 외적 요소에 프로퍼티가 의존하는 경우 사용
    
    // townSize에 lazy가 붙어서 컴파일러는 이 프로퍼티에 self에 해당하는 값이 만들어질 필요가 없으며
    // 그 대신 townSize가 처음 엑세스될때 (값이 없던 경우에) 만들어저야 한다고 파악한다.
    var townSize: Size {
        get {
            switch self.population {
            case 0 ... 10_000 :
                return Size.small
            case 10_001 ... 100_000 :
                return Size.medium
            default:
                return Size.large
            }
        }
    }
    
    func printDescription () {
        print ("Population : \(population), numberOfStoplights : \(numberOfStoplights)")
    }
    // 구조체와 열거형은 값 타입이라서 인스턴스의 프로퍼티 값을 변경할 메서드에는 mutating키워드가 붙어야 한다.
    mutating func changePopulation (by amount: Int) {
        population += amount
    }
    
}
