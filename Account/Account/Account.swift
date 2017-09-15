//
//  main.swift
//  Account
//
//  Created by Choi Jeong Hoon on 2017. 9. 14..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation




class Account
{
    let bankName: String           // 은행명은 쉽게 안바뀌기 대문에
    var amount: Int    // 계좌금액의 총합
    
    init (bankName: String, amount: Int)
    {
        self.bankName = bankName     // 좌측 뱅크네임은 인스턴스의 이름, 오른쪽 뱅크네임은 외부에서 입력된 파라메터 이름
        self.amount = amount
    }
}


