//
//  ViewController.swift
//  APILogin&SignUp
//
//  Created by Sierra 4 on 20/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//
import Alamofire
import ObjectMapper
import UIKit
import SkyFloatingLabelTextField

class ViewController: UIViewController {
    
    var rememberMeFlag = 0
    var emailFetchedFromUserdefault = ""
    var passFetchedFromUserdefault = ""
    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var txtFieldEmail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtFieldPassword: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetching values from userdefault
        if userDefault.value(forKey: "savedDict") != nil {
            var dictionary = [String : String]()
            dictionary = userDefault.value(forKey: "savedDict") as! [String : String]
            txtFieldEmail.text = dictionary["email"]
            txtFieldPassword.text = dictionary["password"]
        }
        txtFieldPassword.isSecureTextEntry = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        if !Validations.isValidEmail(testStr: txtFieldEmail.text!) {
            Validations.alertMessage(messageString: "Please enter correct email", selfArg: self, title: "Oops!")
        } else if txtFieldPassword.text == "" {
            Validations.alertMessage(messageString: "Please enter correct password", selfArg: self, title: "Oops!")
        } else {
            let param : [String : Any] = ["email": txtFieldEmail.text ?? "",
                                          "password" : txtFieldPassword.text ?? "",
                                          "flag" : 1 ]
            ApiHandler.fetchData(urlStr: "login", parameters: param) { (jsonData) in
                let userModel = Mapper<User>().map(JSONObject : jsonData)
                print(userModel?.msg ?? "")
                print(userModel?.profile?.username ?? "")
                print(userModel?.profile?.phone ?? "")
                if userModel?.profile?.username ?? "" != ""{
                    Validations.alertMessage(messageString: "Login confirmed ", selfArg: self, title: "Congratulations!")
                    if self.rememberMeFlag == 1 {
                        var dictionary = [String : String]()
                        dictionary["email"] = self.txtFieldEmail.text
                        dictionary["password"] = self.txtFieldPassword.text
                        self.userDefault.set(dictionary, forKey: "savedDict")
                        self.userDefault.synchronize()
                    }
                } else {
                    Validations.alertMessage(messageString: "Something gone wrong!", selfArg: self, title: "Oops!")
                }
            }
        }
    }
    
    @IBAction func btnRememberMe(_ sender: Any) {
        rememberMeFlag = 1
    }
    
}

