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
    var pricePerItem: Int?
    
    // * rawValue활용해 보기
    
    enum menuOfVendingMachine: Int {
        case candybar=1, chips, cookie, dietsoda, fruitjuice, gum, poptart, sandwich, water
    }
    let someMenu = menuOfVendingMachine.candybar.rawValue
    
    
    // 3.   물건 선택
    // 3-1. 터치시마다 장바구니 금액 증가 및 최초 터치시 메세지 변경
    @IBAction func items (btn: UIButton)
    { switch btn.tag {
        case 1 :
                pricePerItem = 500
                guard let optionalInt = pricePerItem else { return }
                estimatedBuying += optionalInt
                basketMoney.text = String(estimatedBuying)
        case 2 :
                pricePerItem = 1500
                guard let optionalInt = pricePerItem else { return }
                estimatedBuying += optionalInt
                basketMoney.text = String(estimatedBuying)
        case 3 :
                pricePerItem = 1000
                guard let optionalInt = pricePerItem else { return }
                estimatedBuying += optionalInt
                basketMoney.text = String(estimatedBuying)
        case 4 :
                pricePerItem = 2000
                guard let optionalInt = pricePerItem else { return }
                estimatedBuying += optionalInt
                basketMoney.text = String(estimatedBuying)
        case 5 :
                pricePerItem = 1500
                guard let optionalInt = pricePerItem else { return }
                estimatedBuying += optionalInt
                basketMoney.text = String(estimatedBuying)
        case 6 :
                pricePerItem = 500
                guard let optionalInt = pricePerItem else { return }
                estimatedBuying += optionalInt
                basketMoney.text = String(estimatedBuying)
        case 7 :
                pricePerItem = 1000
                guard let optionalInt = pricePerItem else { return }
                estimatedBuying += optionalInt
                basketMoney.text = String(estimatedBuying)
        case 8 :
                pricePerItem = 500
                guard let optionalInt = pricePerItem else { return }
                estimatedBuying += optionalInt
                basketMoney.text = String(estimatedBuying)
        case 9 :
                pricePerItem = 1500
                guard let optionalInt = pricePerItem else { return }
                estimatedBuying += optionalInt
                basketMoney.text = String(estimatedBuying)
        
    // 질문할것 : ?? 무조건 9가지 조건에 해당되는데 왜 디폴트값을 넣으라고 하는건지
        default :
                basketMoney.text = "\(estimatedBuying)"}
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
    
    // 5. 잔액 충전 : 터치시마다 천원/이천원씩 증가
    @IBAction func charge (btn: UIButton) {
        switch btn.tag {
            case 1 :
                balance += charged
                self.currentBalance.text = String(balance)
            case 2 :
                balance += (charged * 2)
                self.currentBalance.text = String(balance)
            default : currentBalance.text = "0"}
    }
    
    // 6. 구매 초기화 : 터치시 장바구니 금액 및 환영메세지 초기화
    @IBAction func reset (btn: UIButton) {
        estimatedBuying = 0
        self.basketMoney.text = String(estimatedBuying)
        self.greetingMsg.text = "다 먹고 싶죠? (의미심장)"
    }
}
