//
//  ViewController.swift
//  TPDPXPayPlusExample
//
//  Created by Kevin Kao on 2025/4/18.
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

    @IBAction func startPXPayPlus(_ sender: Any) {
        let pxPayPlus = TPDPxPayPlus.setup(withReturnUrl: "https://google.com.tw")
        pxPayPlus.onSuccessCallback { prime in
            // send prime to your server and call pay by prime API
            DispatchQueue.main.async {
                let payment = "Use below cURL to get the payment_url.\ncurl -X POST \\\nhttps://sandbox.tappaysdk.com/tpc/payment/pay-by-prime \\\n-H \'content-type: application/json\' \\\n-H \'x-api-key: partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\' \\\n-d \'{ \n \"prime\": \"\(prime!)\", \"partner_key\": \"partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\", \"merchant_id\": \"GlobalTesting_PX_PAY_Plus_EC\", \"details\":\"TapPay Test\", \"amount\": 100, \"cardholder\": { \"phone_number\": \"+886923456789\", \"name\": \"Jane Doe\", \"email\": \"Jane@Doe.com\", \"zip_code\": \"12345\", \"address\": \"123 1st Avenue, City, Country\", \"national_id\": \"A123456789\" }, \"result_url\": { \"frontend_redirect_url\" : \"\(self.frontend_rediret_url)\",\"backend_notify_url\":\"\(self.backend_notify_url)\"} }\'"

                print(payment)
            }
        }.onFailureCallback { status, msg in
            
        }.getPrime()
    }
    
}

