import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.nameTextField.bind { text in
            self.nameTextField.text = text
            
        }
        viewModel.password.bind { text in
            self.passwordTextField.text = text
        }
        viewModel.email.bind { text in
            self.emailTextField.text = text
        }
        
        viewModel.isVaild.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .red : .lightGray
        }
    }
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        viewModel.signIn {
            // 화면전환
        }
    }
    
    @IBAction func nameTextFieldClicked(_ sender: UITextField) {
        viewModel.nameTextField.value = nameTextField.text!
        viewModel.checkValidation()
    }
    @IBAction func passwordTextFieldClicked(_ sender: UITextField) {
        viewModel.password.value = passwordTextField.text!
        viewModel.checkValidation()
    }
    
    @IBAction func emailTextFieldClicked(_ sender: UITextField) {
        viewModel.email.value = emailTextField.text!
        viewModel.checkValidation()
    }
    
    
    

}

