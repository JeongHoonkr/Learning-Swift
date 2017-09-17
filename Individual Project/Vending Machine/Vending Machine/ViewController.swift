//
//  ViewController.swift
//  Vending Machine
//
//  Created by Choi Jeong Hoon on 2017. 9. 17..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 0.   UI 타이틀 및 텍스트
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var basketMoney: UILabel!
    @IBOutlet weak var currentBalance: UILabel!
    @IBOutlet weak var greetingMsg: UILabel!
    
    
    override func viewDidLoad() {
        
    // 1.   초기 화면 뿌려질 부분
        super.viewDidLoad()
        currentBalance.text = "0"
        appTitle.text = "천원 마켓"
        basketMoney.text = "\(estimatedBuying)"
        greetingMsg.text = "다 먹고 싶죠? (궁금)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 2.   변수 선언
    var balance: Int = 0
    var charged: Int = 1000
    var estimatedBuying: Int = 0
    var pricePerItem: Int = 1000
    
    
    // 3.   물건 선택
    // 3-1. 터치시마다 장바구니 금액 증가 및 최초 터치시 메세지 변경
    @IBAction func items (btn: UIButton)
    {
        estimatedBuying += pricePerItem
        basketMoney.text = String(estimatedBuying)
        greetingMsg.text = "다 먹고 싶죠? (방긋)"
    }
    
    // 4.   물건 구매 (조건 충족 필요)
    // 4-1. 잔액이 장바구니 금액보다 크거나 같고 (and) 장바구니 금액이 0이 아닐때
    //      잔액에서 장바구니 금액만큼 차감
    //      장바구니 금액은 장바구니 금액만큼 차감
    //      장바구니 금액은 초기화해서 출력
    // 4-2. 잔액이 장바구니 금액보다 작을때 "돈 가져오세요" 출력
    // 4-3. 장바구니 금액이 0일때는 "아직 안고르셨음" 출력
    @IBAction func purchase (btn: UIButton) {
        if  balance >= estimatedBuying && estimatedBuying != 0 {
            balance -= estimatedBuying
            self.basketMoney.text = "\(estimatedBuying - estimatedBuying)"
            self.currentBalance.text = String(balance)
            self.greetingMsg.text = "또 올거죠? (애원)"
            estimatedBuying = 0
            
        } else if balance < estimatedBuying && estimatedBuying != 0 {
            self.greetingMsg.text = "돈 가져오세요 (빠직)"}
          else if estimatedBuying == 0 {
            self.greetingMsg.text = "아직 안고르셨음 (민망)"
        }
        
    }
    
    // 5. 잔액 충전 : 터치시마다 천원씩 증가
    @IBAction func charge (btn: UIButton) {
        balance += charged
        self.currentBalance.text = String(balance)
    }
    
    // 6. 구매 초기화 : 터치시 장바구니 금액 및 환영메세지 초기화
    @IBAction func reset (btn: UIButton) {
        estimatedBuying = 0
        self.basketMoney.text = String(estimatedBuying)
        self.greetingMsg.text = "다 먹고 싶죠? (의미심장)"
    }
}
