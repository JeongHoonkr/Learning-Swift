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
        U
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
    var balance: Int?
    var charged: Int = 1000
    var estimatedBuying: Int = 0
    var pricePerItem: Int?
    
    
    
    // * rawValue활용해 보기
    
    enum MenuOfVendingMachine: Int {
        case candybar=1, chips, cookie, dietsoda, fruitjuice, gum, poptart, sandwich, water
    }
    
    // 3.   물건 선택
    // 3-1. 터치시마다 장바구니 금액 증가 및 최초 터치시 메세지 변경
    @IBAction func items (btn: UIButton)
    {
        
        let itemType = MenuOfVendingMachine(rawValue: btn.tag)
        if let itemNewtype = itemType{
            switch itemNewtype {
                
            case .candybar :
                pricePerItem = 500
            case .chips :
                pricePerItem = 1500
            case .cookie :
                pricePerItem = 1000
            case .dietsoda :
                pricePerItem = 2000
            case .fruitjuice :
                pricePerItem = 1500
            case .gum :
                pricePerItem = 500
            case .poptart :
                pricePerItem = 1000
            case .sandwich:
                pricePerItem = 500
            case .water :
                pricePerItem = 1500
                
            default:                 // default가 왜 절대 실행되지 않는다고 나오는지
                break
            }
        }
        guard let optionalInt = pricePerItem else { return }
        estimatedBuying += optionalInt
        basketMoney.text = String(estimatedBuying)
        
    }
    // 4.   물건 구매 (조건 충족 필요)
    // 4-1. 잔액이 장바구니 금액보다 크거나 같고 (and) 장바구니 금액이 0이 아닐때
    //      잔액에서 장바구니 금액만큼 차감
    //      장바구니 금액은 장바구니 금액만큼 차감
    //      장바구니 금액은 초기화해서 출력
    // 4-2. 잔액이 장바구니 금액보다 작을때 "돈 가져오세요" 출력
    // 4-3. 장바구니 금액이 0일때는 "아직 안고르셨음" 출력
    
    @IBAction func purchase (btn: UIButton) {
        if var balanced = balance {
            if  balanced >= estimatedBuying && estimatedBuying != 0 {
                balanced -= estimatedBuying
                balance = balanced      //
                self.basketMoney.text = "0"     // self를 넣었을때와 안넣었을때 의미상의 차이는? <이하 동일>
                self.currentBalance.text = String(balanced)
                self.greetingMsg.text = "또 올거죠? (애원)"
                estimatedBuying = 0 }
            else if balanced < estimatedBuying && estimatedBuying != 0 {
                self.greetingMsg.text = "돈 가져오세요 (빠직)"}
            else if estimatedBuying == 0 {
                self.greetingMsg.text = "아직 안고르셨음 (민망)"}
        }
    }
    
    // 5. 잔액 충전 : 터치시마다 천원/이천원씩 증가
    @IBAction func charge (btn: UIButton) {
        
        if var balanced = balance {
            switch btn.tag {
            case 1 :
                balanced += charged
                balance = balanced
                self.currentBalance.text = String(balanced)
            case 2 :
                balanced += (charged * 2)
                balance = balanced
                self.currentBalance.text = String(balanced)
            default : currentBalance.text = "0"}
        }else {
            // describing이 뭔지?  String()로 변환이 안될때 쓰는거 같은데 안될떄가 어떤경우들이 있는지
            switch btn.tag {
            case 1 :
                balance = charged
                self.currentBalance.text = String(describing:balance)
                
            case 2 :
                balance = charged * 2
                self.currentBalance.text = String(describing:balance)
            default :
                return}
        }
    }
    // 6. 구매 초기화 : 터치시 장바구니 금액 및 환영메세지 초기화
    @IBAction func reset (btn: UIButton) {
        self.estimatedBuying = 0
        self.basketMoney.text = String(estimatedBuying)
        self.greetingMsg.text = "다 먹고 싶죠? (의미심장)"}
}


UIResponder
