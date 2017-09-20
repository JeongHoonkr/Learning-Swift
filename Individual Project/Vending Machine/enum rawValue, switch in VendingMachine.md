## enum rawValue 및 switch 사용



본 코드는 Vending Machine코드중 일부를 따온것입니다

```
 // rawValue 열거 넘버링
 
 enum MenuOfVendingMachine: Int {
        case candybar=1, chips, cookie, dietsoda, fruitjuice, gum, poptart, sandwich, water
    }
    
    let someMenu = MenuOfVendingMachine.candybar.rawValue
    
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
            
        default:
            break}
        }
        guard let optionalInt = pricePerItem else { return }
        estimatedBuying += optionalInt
        basketMoney.text = String(estimatedBuying)

     }

```

