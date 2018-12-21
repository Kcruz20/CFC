//
//  SignInViewController.swift
//  CFC
//
//  Created by Katherinne Cruz Lopez on 11/27/18.
//  Copyright © 2018 Katherinne Cruz. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
//makes sure that user has email and password
    @IBAction func signinButton(_ sender: Any) {
        guard let userEmail = userEmailAddressTextField.text, !userEmail.isEmpty
            else{
                self.showMessage(messageToDisplay: "User email is requiered!")
                return;
                }
        
        guard let userPassword = userPasswordTextField.text, !userPassword.isEmpty
            else{
                self.showMessage(messageToDisplay: "User password is requiered!")
                return;
        }
        
        //authenticate email with firebase
        Auth.auth().signIn(withEmail: userEmail, password: userPassword)
        {
            (user, error) in
            
            if let Error = error
            {       //if error then it will print an error in xcode
                let mainpage = self.storyboard?.instantiateViewController(withIdentifier: "MainPageViewController") as! MainPageViewController
                self.present(mainpage, animated: true, completion: nil)
               // print(error.localizedDescription )
                //self.showMessage(messageToDisplay: error.localizedDescription)
                return
            }
            
            if user != nil{     //if user is good -> first page(screen)
               let mainpage = self.storyboard?.instantiateViewController(withIdentifier: "MainPageViewController") as! MainPageViewController
                self.present(mainpage, animated: true, completion: nil)
            }
        }
        
    }
    //shows if there is something wrong
    public func showMessage(messageToDisplay:String)
    {
        let alertController = UIAlertController(title: "Alert title",
                                                message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction (title: "OK", style: .default)
        {
            (action:UIAlertAction!) in
            print("Ok button tapped");
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }

}
