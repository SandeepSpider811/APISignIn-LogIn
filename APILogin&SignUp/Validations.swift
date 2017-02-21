//
//  Validations.swift
//  APILogin&SignUp
//
//  Created by Sierra 4 on 21/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//
import UIKit
import Foundation
class Validations {
    
    class func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    class func validateString(value: String) -> Bool {
        let STRING_REGEX = "^[a-zA-Z]+$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", STRING_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    class func alertMessage(messageString: String, selfArg: UIViewController, title: String) {
        let alert = UIAlertController(title: title, message: messageString, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
        }))
        selfArg.present(alert, animated: true, completion: nil)
    }
    
    class func validateMobileNo(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
}
