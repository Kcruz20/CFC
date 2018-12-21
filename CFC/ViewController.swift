//
//  ViewController.swift
//  CFC
//
//  Created by Katherinne Cruz Lopez on 11/8/18.
//  Copyright © 2018 Katherinne Cruz. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let ref = Database.database().reference()
        ref.child("someid/name").setValue("Mike")
    }
    
    //DOESN'T WORK
    //DOESN'T SAVE NEW USER
    //This is the signup and it makes sure that every box is filled out, if not it lets the user know there is an empty box and it needs to be filled out
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty
            else{
                self.showMessage(messageToDisplay: "First name is requiered!")
                return;
                }
        guard let lastName = lastnameTextField.text, !lastName.isEmpty
            else{
                self.showMessage(messageToDisplay: "Last name is requiered!")
                return;
                }
        guard let userEmailAddress = emailAddressTextField.text, !userEmailAddress.isEmpty
            else{
                self.showMessage(messageToDisplay: "Email is requiered!")
                return;
                }
        guard let userPassword = passwordTextField.text, !userPassword.isEmpty
            else{
                self.showMessage(messageToDisplay: "User password is requiered!")
                return;
        }
        guard let userRepeatPassword = repeatPassword.text, !userRepeatPassword.isEmpty
            else{
                self.showMessage(messageToDisplay: "User repeat password is requiered!")
                return;
        }
        //user needs to re enter the password to make sure they know what their password is
        if userPassword != userRepeatPassword
        {
            self.showMessage(messageToDisplay: "User provided passwords don't match")
            return;
        }
        
        //This makes sure that the email used is correct
        Auth.auth().createUser(withEmail: userEmailAddress, password: userPassword)
        { (user, error) in
            if let error = error
            {
                print(error.localizedDescription) //show me error
                self.showMessage(messageToDisplay: error.localizedDescription) //show user error
                return
            }
        //shows new user info in database
            if let user = user
            {
                var databaseReference: DatabaseReference!
                databaseReference = Database.database().reference()
                
                let userInformation:[String:String] = ["firstName":firstName, "lastName":lastName]
                
                databaseReference.child("users").child(user.user.uid).setValue(["userInformation" : userInformation]) //shows detailed info in database
            }
        }
        
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
    }
    //tells me if its not working
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
    
    
    //Social Media & website
    //DOESNT WORK!!
    @IBAction func Twitter(_ sender: Any) {
       
        guard let url = URL(string: "https://www.twitter.com") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func Instagram(_ sender: Any) {
        guard let url = URL(string: "https://www.instagram.com") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func Facebook(_ sender: Any) {
        guard let url = URL(string: "https://www.facebook.com") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func website(_ sender: Any) {
        guard let url = URL(string: "https://www.tucentrofamiliarwa.com") else {return}
        UIApplication.shared.open(url)

    }
    
    
    }
    
    
        
    
    


