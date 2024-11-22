//
//  RegisterVC.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 22.11.2024.
//
import UIKit
import SnapKit

class RegisterVC: UIViewController {
    
    private let stackView = UIStackView()
    private let usernameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let registerButton = UIButton()
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension RegisterVC: SetupProtocol {
    func setup() {
        configure()
        drawUI()
        makeLayout()
    }
    
    func configure() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(registerButton)
    }
    
    func drawUI() {
        title = "Create Account"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.textColor = .black
        usernameTextField.font = .systemFont(ofSize: 15)
        usernameTextField.autocapitalizationType = .none
        
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.textColor = .black
        emailTextField.font = .systemFont(ofSize: 15)
        emailTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textColor = .black
        passwordTextField.font = .systemFont(ofSize: 15)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        registerButton.backgroundColor = .systemPurple
        registerButton.layer.cornerRadius = 10
        registerButton.tintColor = .white
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func makeLayout() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(190)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    @objc func registerButtonTapped(){
        
        guard let username = usernameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                  showAlert(title: "Uyarı", message: "Lütfen tüm alanları doldurunuz")
                  return
              }
        guard email.contains("@") && email.contains(".") else {
            showAlert(title: "Uyarı", message: "Lütfen geçerli bir email adresi giriniz")
            return
        }
        guard password.count >= 6 else {
            showAlert(title: "Uyarı", message: "Lütfen en az 6 karakter giriniz")
            return
        }
        FirebaseManager.shared.createUser(username: username, email: email, password: password)
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}
