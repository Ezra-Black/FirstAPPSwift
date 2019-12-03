//
//  HomeController.swift
//  
//
//  Created by Morgann Riu on 17/10/2019.
//  Copyright © 2019 Morgann Riu. All rights reserved.
//

import UIKit
import FirebaseAuth
import WebKit
class HomeController: UIViewController , WKUIDelegate {
    //outlet
    @IBOutlet weak var nameAuth: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var envoyerbutton: UIButton!
    @IBOutlet weak var textenvoyer: UITextField!
    // properties

    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          .lightContent // met le texte dans la nav barre en blanc light .
      }
    private func setupLabel(){
        nameAuth.text = User.shared.pseudo // cache le label
        
    }
    private func setupButtons(){
        logoutButton.layer.cornerRadius = 20 // rayon
        logoutButton.layer.borderWidth = 3 // bordure
        logoutButton.layer.borderColor = UIColor.white.cgColor // bordure color
        
        
        envoyerbutton.layer.cornerRadius = 20 // rayon
           envoyerbutton.layer.borderWidth = 3 // bordure
           envoyerbutton.layer.borderColor = UIColor.black.cgColor // bordure color
        
    }
    override func viewDidLoad() {
        setupLabel()
        setupButtons()
        super.viewDidLoad()
             
        

        // Do any additional setup after loading the view.
    }
    // private func
    // action
    @IBAction func LogoutButtonAct(_ sender: Any) {
        
        
        DispatchQueue.main.async {
                                   User.shared.LogoutUser()
                                   self.performSegue(withIdentifier: "goToIndex", sender: self)
                                 }
        
    }
    
    
    
    
    
    @IBAction func actionenvoyer(_ sender: Any) {
       
        
        let parameters = ["texte": textenvoyer.text!, "login": User.shared.pseudo] as [String : Any]
              //create the url with URL
        
              let url = URL(string: "https://lonewolf.fr/admin/inc/apitchat.php")

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
                                
                          print(data)
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
