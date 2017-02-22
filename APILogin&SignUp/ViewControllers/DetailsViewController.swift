//
//  DetailsViewController.swift
//  APILogin&SignUp
//
//  Created by Sierra 4 on 22/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var lblUser: UILabel!

    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var lblCountry: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    var username = ""
    var phone = ""
    var email = ""
    var country = ""
    var city = ""
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUser.text = username
        lblPhone.text = phone
        lblEmail.text = email
        lblCity.text = city
        lblAddress.text = address
        lblCountry.text = country
    }
    
    @IBAction func btnBack(_ sender: Any) {
         _ = navigationController?.popViewController(animated: true)
    }
    

}
