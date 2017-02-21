//
//  SignUpViewController.swift
//  APILogin&SignUp
//
//  Created by Sierra 4 on 21/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//
import Alamofire
import ObjectMapper
import UIKit
import SkyFloatingLabelTextField
class SignUpViewController: UIViewController {

    
    @IBOutlet weak var txtFieldName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtFieldEmailAddress: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtFieldPassword: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtFieldPhoneNumber: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtFieldCountry: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtFieldCity: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtFieldAddress: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldPassword.isSecureTextEntry = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func btnBack(_ sender: Any) {
         _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        if !Validations.validateString(value: txtFieldName.text!) || txtFieldName.text == "" {
            Validations.alertMessage(messageString: "Please enter correct name", selfArg: self, title: "Oops!")
        } else if !Validations.isValidEmail(testStr: txtFieldEmailAddress.text!) {
            Validations.alertMessage(messageString: "Please enter correct email", selfArg: self, title: "Oops!")
        } else if txtFieldPassword.text == "" {
            Validations.alertMessage(messageString: "Please enter a valid password", selfArg: self, title: "Oops!")
        } else if !Validations.validateMobileNo(value: txtFieldPhoneNumber.text!) {
            Validations.alertMessage(messageString: "Please enter only 10 digits", selfArg: self, title: "Oops!")
        } else if txtFieldCountry.text == "" {
            Validations.alertMessage(messageString: "Please enter correct country", selfArg: self, title: "Oops!")
        } else if txtFieldCity.text == "" {
            Validations.alertMessage(messageString: "Please enter correct city", selfArg: self, title: "Oops!")
        } else if txtFieldAddress.text == "" {
            Validations.alertMessage(messageString: "Please enter correct address", selfArg: self, title: "Oops!")
        } else {
            let param : [String : Any] = ["username": txtFieldName.text ?? "",
                                          "email" : txtFieldEmailAddress.text ?? "",
                                          "password" : txtFieldPassword.text ?? "",
                                          "phone" : txtFieldPhoneNumber.text ?? "",
                                          "country" : txtFieldCountry.text ?? "",
                                          "city" : txtFieldCity.text ?? "",
                                          "address" : txtFieldAddress.text ?? "",
                                          "flag" : 1,
                                          "birthday" : "09/02/1994",
                                          "country_code" : "91",
                                          "postal_code" : "134109",
                                          "country_iso3" : "IND",
                                          "state" : "HARYANA"]
            ApiHandler.fetchData(urlStr: "signup", parameters: param) { (jsonData) in
                let userModel = Mapper<User>().map(JSONObject : jsonData)
                print(userModel?.msg ?? "")
                print(userModel?.profile?.username ?? "")
                print(userModel?.profile?.phone ?? "")
                if self.txtFieldName.text == userModel?.profile?.username ?? ""{
                    Validations.alertMessage(messageString: "Your account has been successfully created", selfArg: self, title: "Congratulations!")
                } else {
                    Validations.alertMessage(messageString: "Something gone wrong!", selfArg: self, title: "Oops!")
                }
            }
        }
    }
    
}
