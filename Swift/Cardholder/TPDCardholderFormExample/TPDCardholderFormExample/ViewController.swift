//
//  ViewController.swift
//  TPDCardholderFormExample
//
//  Created by Kevin Kao on 2025/11/5.
//

import UIKit
import TPDirect

class ViewController: UIViewController {

    @IBOutlet weak var cardholderFormView: UIView!
    @IBOutlet weak var payButton: UIButton!
    
    var tpdCardholderForm : TPDCardholderForm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tpdCardholderForm = TPDCardholderForm.setup(withContainer: self.cardholderFormView)
        
        self.tpdCardholderForm.setErrorColor(colorWithRGB(rgbString: "D62D20", alpha: 1.0))
        
        self.tpdCardholderForm.setShowEmailField(false);
        self.tpdCardholderForm.setShowPhoneNumberField(false)
        
        self.tpdCardholderForm.onFormUpdated { status in
            weak var weakSelf = self
    
            weakSelf?.payButton.isEnabled = status.isCanGetCardholderPrime()
            weakSelf?.payButton.alpha     = (status.isCanGetCardholderPrime()) ? 1.0 : 0.25
        }
    }

    
    @IBAction func doneAction(_ sender: Any) {
        self.tpdCardholderForm.onSuccessCallback { prime, status, message in
            print("prime: \(prime), status: \(status), message: \(message)")
        }.onFailureCallback { status, message in
            print("status: \(status), message: \(message)")
        }.getCardholderPrime();
    }
    
    func colorWithRGB(rgbString:String!, alpha:CGFloat!) -> UIColor! {
        
        let scanner = Scanner.init(string: rgbString.lowercased())
        var baseColor:UInt64 = UInt64()
        scanner.scanHexInt64(&baseColor)
        
        let red     = ((CGFloat)((baseColor & 0xFF0000) >> 16)) / 255.0
        let green   = ((CGFloat)((baseColor & 0xFF00) >> 8)) / 255.0
        let blue    = ((CGFloat)(baseColor & 0xFF)) / 255.0
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

