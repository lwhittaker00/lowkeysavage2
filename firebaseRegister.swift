//
//  firebaseRegister.swift
//  
//
//  Created by User on 3/30/20.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

Auth.auth().createUser(withEmail: "user@email.com", password: "PASSWORD******") { (user, error) in
    if let error = error {
        print(error.localizedDescription)
    }
    else if let user = user {
        print("Sign Up Successfully. \(user.uid)")
    }
}

Auth.auth().signIn(withEmail: "user@email.com", password: "PASSWORD******") { (user, error) in
    if let error = error {
        print(error.localizedDescription)
    }
    else if let user = user {
        print(user.uid)
    }
}

let currentUser = Auth.auth().currentUser
print(currentUser.uid)

if let user = user {
  let uid = user.uid
  let email = user.email
  let photoURL = user.photoURL
}

let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
changeRequest?.displayName = "Carter Keneth"
changeRequest?.commitChanges(completion: { (error) in
    if let error = error {
        print(error.localizedDescription)
        self.view.makeToast(error.localizedDescription)
    }
})

if Auth.auth().currentUser != nil {
    do {
        try Auth.auth().signOut()
    }
    catch {
    }
}
