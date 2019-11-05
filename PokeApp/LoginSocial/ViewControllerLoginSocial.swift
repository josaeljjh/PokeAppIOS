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
import FacebookCore
import FacebookLogin
import FirebaseAuth

class ViewControllerLoginSocial: UIViewController,GIDSignInDelegate {
    var fullName: String = ""
    var email: String = ""
    var dbRef: DatabaseReference!
    
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
        
        let loginManager = LoginManager()
        loginManager.logIn(
            permissions: [.publicProfile, .email],
            viewController: self
        ) { result in
            self.loginManagerDidComplete(result)
        }
        
    }
    
    
    func loginManagerDidComplete(_ result: LoginResult) {
        switch result {
        case .cancelled:
            ShowSheet("Login Cancelled","User cancelled login.")
        case .failed(let error):
            ShowSheet("Login Fail","Login failed with error: \(error)")
        case .success:
            signIntoFirebase()
        }
    }
    
    func signIntoFirebase(){
        let authenticationToken = AccessToken.current!.tokenString
        let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
        Auth.auth().signIn(with: credential){(authResult,error) in
            if let error = error {
                print(error)
                return
            }else {
                Globales.idUser = (authResult?.user.uid)!
                //Data user
                self.dbRef = Database.database().reference().child("User").child(Globales.idUser)
                                
                // Successful log in with Facebook
                self.dbRef.child("userName").setValue(authResult?.user.displayName)
                self.dbRef.child("email").setValue(authResult?.user.email)
                self.dbRef.child("idUser").setValue(Globales.idUser )
                JNBBottombar.shared.show(text: "Successful log in with Facebook")
                self.starViewController("Region")
                self.navigationController?.popToViewController(ofClass: ViewControllerRegion.self)
            }
            
        }
        
        
        
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
                    //Data user
                    self.dbRef = Database.database().reference().child("User").child(Globales.idUser)
                    
                    self.dbRef.child("userName").setValue(self.fullName)
                    self.dbRef.child("email").setValue(self.email)
                    self.dbRef.child("idUser").setValue(Globales.idUser)
                    JNBBottombar.shared.show(text: "Successful log in with Google")
                    self.starViewController("Region")
                    self.navigationController?.popToViewController(ofClass: ViewControllerRegion.self)
                    
                }else{
                    print(error?.localizedDescription as Any)
                }
            }
        }
    }
}
