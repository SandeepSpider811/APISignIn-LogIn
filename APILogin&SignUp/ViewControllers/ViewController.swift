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
import SVProgressHUD
import M13Checkbox

class ViewController: UIViewController {
    
    var rememberMeFlag = 0
    var emailFetchedFromUserdefault = ""
    var passFetchedFromUserdefault = ""
    let userDefault = UserDefaults.standard
    
    var dataToDetails = [String : String]()

    @IBOutlet weak var checkBoxOutlet: M13Checkbox!
    
    @IBOutlet weak var btnSignInOutlet: UIButton!
    
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
            SVProgressHUD.show()
            btnSignInOutlet.isEnabled = false
            let param : [String : Any] = ["email": txtFieldEmail.text ?? "",
                                          "password" : txtFieldPassword.text ?? "",
                                          "flag" : 1 ]
            
            ApiHandler.fetchData(urlStr: "login", parameters: param) { (jsonData) in
                let userModel = Mapper<User>().map(JSONObject : jsonData)
                
                print(userModel?.msg ?? "")
                print(userModel?.profile?.username ?? "")
                print(userModel?.profile?.phone ?? "")
                print(userModel?.profile?.email ?? "")
                print(userModel?.profile?.country ?? "")
                print(userModel?.profile?.city ?? "")
                print(userModel?.profile?.address ?? "")
                if userModel?.profile?.username ?? "" != "" {
//                    Validations.alertMessage(messageString: "Login confirmed ", selfArg: self, title: "Congratulations!")
                    if self.rememberMeFlag == 1 {
                        var dictionary = [String : String]()
                        dictionary["email"] = self.txtFieldEmail.text
                        dictionary["password"] = self.txtFieldPassword.text
                        self.userDefault.set(dictionary, forKey: "savedDict")
                        self.userDefault.synchronize()
                    }
                    self.dataToDetails["username"] = userModel?.profile?.username ?? ""
                    self.dataToDetails["phone"] = userModel?.profile?.phone ?? ""
                    self.dataToDetails["email"] = userModel?.profile?.email ?? ""
                    self.dataToDetails["country"] = userModel?.profile?.country ?? ""
                    self.dataToDetails["city"] = userModel?.profile?.city ?? ""
                    self.dataToDetails["address"] = userModel?.profile?.address ?? ""
                    self.performSegue(withIdentifier: "DetailsViewController", sender: self)
                    SVProgressHUD.dismiss()
                    self.btnSignInOutlet.isEnabled = true
                } else {
                    SVProgressHUD.dismiss()
                    self.btnSignInOutlet.isEnabled = true
                    Validations.alertMessage(messageString: "Something gone wrong!", selfArg: self, title: "Oops!")
                }
            }
        }
    }
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if checkBoxOutlet.checkState.rawValue == "Checked" {
            rememberMeFlag = 1
        } else {
            rememberMeFlag = 0
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewController" {
            let guest = segue.destination as! DetailsViewController
            guest.username = dataToDetails["username"]!
            guest.phone = dataToDetails["phone"]!
            guest.email = dataToDetails["email"]!
            guest.country = dataToDetails["country"]!
            guest.city = dataToDetails["city"]!
            guest.address = dataToDetails["address"]!
        }
    }
}

