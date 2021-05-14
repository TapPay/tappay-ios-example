//
//  ViewController.swift
//  Direct_Pay_CCVForm
//
//  Created by Cherri Kevin on 5/13/21.
//

import UIKit
import TPDirect

class ViewController: UIViewController {

    @IBOutlet weak var ccvFormView: UIView!
    var tpdCcvForm : TPDCcvForm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tpdCcvForm = TPDCcvForm.setupCCV(withContainer: self.ccvFormView)
        
        self.tpdCcvForm.onCCVFormUpdated { (status) in
            print("isCanGetCCVPrime : \(status!.isCanGetCCVPrime())")
        }
        
    }

    
    @IBAction func getCCVPrime(_ sender: Any) {
        let tpdCcv = TPDCcv.setup(self.tpdCcvForm)
        
        tpdCcv.onSuccessCallback { (prime) in
            print("prime : \(prime)")
        }.onFailureCallback { (status, message) in
            print("status : \(status), message : \(message)")
        }.getPrime()
    }
    
}

