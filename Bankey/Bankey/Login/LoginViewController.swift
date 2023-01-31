//
//  ViewController.swift
//  Bankey
//
//  Created by Luis Angel Torres G on 25/01/23.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
    
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let stackContainer = UIStackView()
    let appTitleLabel = UILabel()
    let descriptionLabel = UILabel()
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }


}

extension LoginViewController {
    private func style(){
        loginView.translatesAutoresizingMaskIntoConstraints = false
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8 // for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        appTitleLabel.text = "Bankey"
        appTitleLabel.textAlignment = .center
        appTitleLabel.font = UIFont.systemFont(ofSize: 35)
        
        descriptionLabel.text = "Your premium source for all things banking!"
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "Username / password cannot be blank"
        errorMessageLabel.isHidden = true
        
        stackContainer.backgroundColor = .systemCyan
    }
    
    private func layout(){
        stackContainer.addArrangedSubview(appTitleLabel)
        stackContainer.addArrangedSubview(descriptionLabel)
        stackContainer.addArrangedSubview(loginView)
        stackContainer.addArrangedSubview(signInButton)
        stackContainer.addArrangedSubview(errorMessageLabel)
        
        stackContainer.axis = .vertical
        stackContainer.spacing = 15
        
        view.addSubview(stackContainer)
        
        NSLayoutConstraint.activate([
            stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackContainer.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackContainer.trailingAnchor, multiplier: 2)
        ])
    }
}

// MARK: Actions
extension LoginViewController {
    
    @objc private func signInTapped(sender: UIButton){
        errorMessageLabel.isHidden = true
        login()

    }
    
    private func login(){
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
//        if username.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username / password cannot be blank")
//            return
//        }
        
        if username == "" && password == "" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    //En este caso withMessage es llamado "argument label", sirve para hacer más legible el código
    private func configureView(withMessage message: String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}
