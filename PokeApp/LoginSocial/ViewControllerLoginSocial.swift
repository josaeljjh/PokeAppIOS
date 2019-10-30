//
//  ViewControllerLoginSocial.swift
//  PokeApp
//
//  Created by Josael Hernandez on 9/6/19.
//  Copyright © 2019 Josael Hernandez. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase
import FirebaseDatabase
import FirebaseAnalytics

class ViewControllerLoginSocial: UIViewController,GIDSignInDelegate {
    var fullName: String = ""
    var email: String = ""
    
    @IBOutlet weak var btnGoogle: LeftAlignedIconButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnFaceBook(_ sender: UIStoryboardSegue) {
          starViewController("Region")
    }
   
    @IBAction func loginGoogle(_ sender: UIStoryboardSegue) {
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
            print(error.localizedDescription)
            return
        }else{
            guard let authentication = user.authentication else {return}
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential){(result,error) in
                if error == nil{
                    self.fullName = user.profile.name
                    self.email = user.profile.email
                    Globales.idUser = user.userID
                    
                    var dbRef: DatabaseReference!
                        dbRef = Database.database().reference().child("User").child(Globales.idUser)
                    
                    dbRef.child("userName").setValue(self.fullName)
                    dbRef.child("email").setValue(self.email)
                    dbRef.child("idUser").setValue(Globales.idUser)
        
                    self.starViewController("Region")
                    self.navigationController?.popToViewController(ofClass: ViewControllerRegion.self)
                    
                }else{
                    print(error?.localizedDescription as Any)
                }
            }
        }
    }
}
