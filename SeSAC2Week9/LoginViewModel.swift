//
//  LoginViewModel.swift
//  SeSAC2Week9
//
//  Created by J on 2022/09/01.
//

import Foundation

class LoginViewModel {
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var nameTextField: Observable<String> = Observable("")
    var isVaild: Observable<Bool> = Observable(false)
    
    func checkValidation() {
        if email.value.count >= 6 && password.value.count >= 4 {
            isVaild.value = true
        } else {
            isVaild.value = false
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        UserDefaults.standard.set(nameTextField.value, forKey: "name")
        
        completion()
    }
}
