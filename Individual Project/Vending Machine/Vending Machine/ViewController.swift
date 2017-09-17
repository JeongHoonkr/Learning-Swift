//
//  ViewController.swift
//  Vending Machine
//
//  Created by Choi Jeong Hoon on 2017. 9. 17..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var basketMoney: UILabel!
    @IBOutlet weak var currentBalance: UILabel!
    @IBOutlet weak var greetingMsg: UILabel!
    
    
    override func viewDidLoad() {
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
    var balance: Int = 0
    var charged: Int = 1000
    var estimatedBuying: Int = 0
    var pricePerItem: Int = 1000
    
    @IBAction func items (btn: UIButton)
    {
        estimatedBuying += pricePerItem
        basketMoney.text = String(estimatedBuying)
        greetingMsg.text = "다 먹고 싶죠? (방긋)"
    }
    
    @IBAction func purchase (btn: UIButton) {
        if  balance >= estimatedBuying && estimatedBuying != 0 {
            balance -= estimatedBuying
            self.basketMoney.text = "\(estimatedBuying - estimatedBuying)"
            self.currentBalance.text = String(balance)
            self.greetingMsg.text = "또 올거죠? (애원)"
            estimatedBuying = 0
            self.basketMoney.text = String(estimatedBuying)
            
        } else if balance < estimatedBuying && estimatedBuying != 0 {
            self.greetingMsg.text = "돈 가져오세요 (빠직)"}
          else if estimatedBuying == 0 {
            self.greetingMsg.text = "아직 안고르셨음 (민망)"
        }
        
    }
    
    @IBAction func charge (btn: UIButton) {
        balance += charged
        self.currentBalance.text = String(balance)
    }
    
    @IBAction func reset (btn: UIButton) {
        estimatedBuying = 0
        self.basketMoney.text = String(estimatedBuying)
        self.greetingMsg.text = "다 먹고 싶죠? (의미심장)"
    }
}
