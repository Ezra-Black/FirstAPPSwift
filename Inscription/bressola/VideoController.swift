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
class VideoController: UIViewController , WKUIDelegate {
    //outlet
    @IBOutlet weak var nameAuth: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    // properties
    
    
    @IBOutlet  var webView: WKWebView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          .lightContent // met le texte dans la nav barre en blanc light .
      }

    override func viewDidLoad() {
   
        super.viewDidLoad()
        super.viewDidLoad()
             
             let myURL = URL(string:"https://www.youtube.com/embed/9DSMgVG0--8?list=RD9DSMgVG0--8")
        
     
             let myRequest = URLRequest(url: myURL!)
             webView.load(myRequest)

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
    
    
  
    
    
    
     
      
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
  
    
    
    
    
    
    
}

