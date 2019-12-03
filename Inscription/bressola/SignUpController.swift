//
//  SignUpController.swift
//  
// la connection à l'application
//  Created by Morgann Riu on 18/10/2019.
//  Copyright © 2019 Morgann Riu. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {


    
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet var labelError: UILabel!
    @IBOutlet weak var buttonSignUp: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var verifPassword: UITextField!
    @IBOutlet weak var buttonReturn: UIButton!

    override var preferredStatusBarStyle: UIStatusBarStyle {
          .lightContent // met le texte dans la nav barre en blanc light .
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()

        // Do any additional setup after loading the view.
    }
    private func setupButtons(){
        
        buttonSignUp.layer.cornerRadius = 20
        buttonSignUp.layer.borderWidth = 3
        buttonSignUp.layer.borderColor = UIColor.black.cgColor
    
        buttonReturn.layer.cornerRadius = 20
            buttonReturn.layer.borderWidth = 3
            buttonReturn.layer.borderColor = UIColor.white.cgColor
        
        labelError.isHidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func SignUp(_ sender: Any) {
        if password.text != verifPassword.text {
                   
                      labelError.isHidden = false
                      labelError.text = "Le mot de passe n'est pas valide !"
                  }
        if   login.text != "" && email.text != ""  && password.text != "" && password.text == verifPassword.text {

            
            
                   let parameters = ["login": login.text!, "password": password.text! , "email": email.text!] as [String : Any]
                       //create the url with URL
                 
                       let url = URL(string: "https://lonewolf.fr/admin/inc/apijson.php")

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
                             //  print(data)
                               print(try! JSONSerialization.jsonObject(with: data, options: .mutableContainers))
                              //            {
                              //                erreur = 0;
                              //                login = salut;
                              //                mail = "salut@salut.fr";
                              //            }
                               //create json object from data
                               if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any ] {
                               let erreur = json["erreur"] as! Int
                                
                                  if erreur == 0 // compte trouvé
                                  {
                                      DispatchQueue.main.async {
                                         
                                         // les label
                                        User.shared.pseudo = json["login"] as! String
                                        User.shared.mail = json["mail"] as! String
                                            
                                        print(User.shared.pseudo)
                                        print(User.shared.mail)

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
    }
}
