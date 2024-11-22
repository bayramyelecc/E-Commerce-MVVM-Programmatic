//
//  LoginVC.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 22.11.2024.
//

import UIKit

class LoginVC: UIViewController {
    
    private let stackView = UIStackView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let descLabel = UILabel()
    private let gotoRegisterButton = UIButton()
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


extension LoginVC : SetupProtocol {
    
    
    func setup() {
        configure()
        drawUI()
        makeLayout()
    }
    
    func configure() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        view.addSubview(descLabel)
        view.addSubview(gotoRegisterButton)
    }
    
    func drawUI() {
        title = "Sign in"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemPurple
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "bag1")
        
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
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        loginButton.backgroundColor = .systemPurple
        loginButton.layer.cornerRadius = 10
        loginButton.tintColor = .white
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        descLabel.text = "Don't have an account?"
        descLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        descLabel.textColor = .black
        descLabel.textAlignment = .center
        
        gotoRegisterButton.setTitle("Register", for: .normal)
        gotoRegisterButton.setTitleColor(.systemPurple, for: .normal)
        gotoRegisterButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        gotoRegisterButton.addTarget(self, action: #selector(gotoRegisterButtonTapped), for: .touchUpInside)
    }
    
    func makeLayout() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        gotoRegisterButton.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func gotoRegisterButtonTapped(){
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButtonTapped(){
        
        guard let email = emailTextField.text, !email.isEmpty,
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
        
        FirebaseManager.shared.loginUser(email: email, password: password) { result in
            switch result {
            case .success(_):
                let vc = TabbarViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            case .failure(let error):
                print(error)
            }
            
        }
        
        func showAlert(title: String, message: String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true)
        }
        
    }
}
