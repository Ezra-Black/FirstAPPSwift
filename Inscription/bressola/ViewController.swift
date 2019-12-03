//
//  ViewController.swift
//  
//
//  Created by Morgann Riu on 17/10/2019.
//  Copyright © 2019 Morgann Riu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    // outlet    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTextFields: UITextField!
    @IBOutlet weak var passwordTextFields: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var labelError: UILabel!
    
    @IBAction func unwindToMain(_ segue: UIStoryboardSegue) {
        // intentionally left empty
    }
    //propertie
    override func viewDidLoad() {
        super.viewDidLoad()
        User.shared.LogoutUser()
        setupButtons()
        setupTextFieldManager()
        setupLabel()
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent // met le texte dans la nav barre en blanc light .
    }
    // private function
    private func setupButtons(){
        loginButton.layer.cornerRadius = 20 // rayon
        loginButton.layer.borderWidth = 3 // bordure
        loginButton.layer.borderColor = UIColor.black.cgColor // bordure color
        
        signupButton.layer.cornerRadius = 20
        signupButton.layer.borderWidth = 3
        signupButton.layer.borderColor = UIColor.white.cgColor
        signupButton.layer.backgroundColor = UIColor.black.cgColor // background color
    }
    private func setupLabel(){
        labelError.isHidden = true // cache le label
    }
    private func setupTextFieldManager(){
        loginTextFields.delegate = self
        passwordTextFields.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    // actions
    @objc private func hidekeyboard(){
        loginTextFields.resignFirstResponder()
        passwordTextFields.resignFirstResponder()
    }
    
    @IBAction func loginactionbutton(_ sender: Any) {
     
       let parameters = ["email": loginTextFields.text! , "password": passwordTextFields.text!]
             //create the url with URL
             let url = URL(string: "https://lonewolf.fr/admin/inc/apijsonc.php")

             //create the session object
             let session = URLSession.shared

             //now create the URLRequest object using the url object
                    var request = URLRequest(url: url!)
             request.httpMethod = "POST" //set http method as POST

             do {
                 request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
             } catch let error {
                 print(error.localizedDescription)
             }

             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             request.addValue("application/json", forHTTPHeaderField: "Accept")

             //create dataTask using the session object to send data to the server
             let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                 guard error == nil else {
                     return
                 }

                 guard let data = data else {
                     return
                 }

                 do {
                    // print(data)
                    // print(try! JSONSerialization.jsonObject(with: data, options: .mutableContainers))
                    //            {
                    //                erreur = 0;
                    //                login = salut;
                    //                mail = "salut@salut.fr";
                    //            }
                     //create json object from data
                     if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any ] {
                     let erreur = json["erreur"] as! Int
                        if erreur == 1// compte déja inscrit
                        {
                            DispatchQueue.main.async {
                                self.labelError.isHidden = false
                                 self.labelError.text = "incorrect"
                                }
                        }
                        if erreur == 0 // compte trouvé
                        {
                            DispatchQueue.main.async {
                                self.labelError.isHidden = false
                            self.labelError.text = "correct"
                                User.shared.pseudo = json["login"] as! String
                                 User.shared.mail =  json["mail"] as! String
                                self.performSegue(withIdentifier: "goToHome", sender: self)
                            }
                            
                         // handle json...
                        }
                    }
                 } catch let error {
                     print(error.localizedDescription)
                    // erreur ?

                 }
                
               
             })
             task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func signupActionButton(_ sender: Any) {
          labelError.isHidden = true
          self.performSegue(withIdentifier: "goSignUp", sender: self)
    }
    
    
    
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
