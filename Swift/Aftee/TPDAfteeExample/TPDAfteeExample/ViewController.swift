//
//  ViewController.swift
//  TPDAfteeExample
//
//  Created by Kevin Kao on 2025/7/9.
//

import UIKit
import TPDirect

class ViewController: UIViewController {

    let frontend_rediret_url = "https://example.com/front-end-redirect"
    let backend_notify_url = "https://example.com/back-end-notify"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startAftee(_ sender: Any) {
        let aftee = TPDAftee.setup(withReturnUrl: "myapp://tpdAfteeExample")
        
        aftee.onSuccessCallback { prime in
            DispatchQueue.main.async {
                let payment = "Use below cURL to get the payment_url.\ncurl -X POST \\\nhttps://sandbox.tappaysdk.com/tpc/payment/pay-by-prime \\\n-H \'content-type: application/json\' \\\n-H \'x-api-key: partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\' \\\n-d \'{ \n \"prime\": \"\(prime!)\", \"partner_key\": \"partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\", \"merchant_id\": \"GlobalTesting_AFTEE\", \"details\": \"[{\"item_id\": \"Product_001\",    \"item_name\": \"1號商品\",    \"item_category\": \"Product\",    \"item_price\": 10,    \"item_quantity\": 2  },  {    \"item_id\": \"Product_002\",    \"item_name\": \"2號商品\",    \"item_category\": \"Product\",    \"item_price\": 30,    \"item_quantity\": 1  },  {    \"item_id\": \"Shipping_Fee_001:\",    \"item_name\": \"運費\",    \"item_category\": \"Shipping Fee\",    \"item_price\": 5,    \"item_quantity\": 1  }]\", \"amount\": 100, \"cardholder\": { \"phone_number\": \"+886923456789\", \"name\": \"Jane Doe\", \"email\": \"Jane@Doe.com\", \"zip_code\": \"12345\", \"address\": \"123 1st Avenue, City, Country\", \"national_id\": \"A123456789\" }, \"result_url\": { \"frontend_redirect_url\" : \"\(self.frontend_rediret_url)\",\"backend_notify_url\":\"\(self.backend_notify_url)\"} }\'"
                
                print(payment)
            }

                
        }.onFailureCallback { status, msg in
            print("status: \(status), msg: \(msg)")
        }.getPrime()
    }
    
}

