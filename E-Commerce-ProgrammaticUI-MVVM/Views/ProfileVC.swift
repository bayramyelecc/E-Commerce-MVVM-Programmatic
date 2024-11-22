//
//  ProfileVC.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 17.11.2024.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {
    
    private let profileView = UIView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let logoutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ProfileVC: SetupProtocol {
    func setup() {
        configure()
        drawUI()
        makeLayout()
        displayUserName()
    }
    
    func configure() {
        view.addSubview(profileView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(emailLabel)
        profileView.addSubview(logoutButton)
    }
    
    func drawUI() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Profile"
        navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .systemBackground
        profileView.backgroundColor = .systemGray5
        profileView.layer.cornerRadius = 20
        
        emailLabel.text = "\(Auth.auth().currentUser?.email ?? "")"
        nameLabel.textColor = .black
        emailLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 20, weight: .black)
        emailLabel.font = .systemFont(ofSize: 16, weight: .bold)
        nameLabel.textAlignment = .center
        emailLabel.textAlignment = .center
        
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        logoutButton.backgroundColor = .systemPurple
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.layer.cornerRadius = 15
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    func makeLayout() {
        profileView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
    }
    
    @objc func logoutButtonTapped(){
        showAlert(title: "Sign Out", message: "Are you sure you want to sign out?")
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sign Out", style: .default, handler: { _ in
            FirebaseManager.shared.logoutUser { result in
                switch result {
                case .success(_):
                    let vc = LoginVC()
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                case .failure(let error):
                    print(error)
                }
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(alert, animated: true)
    }
    
    func displayUserName() {
        FirebaseManager.shared.fetchUser { [weak self] username in
            DispatchQueue.main.async {
                if let username = username {
                    self?.nameLabel.text = username
                } else {
                    self?.nameLabel.text = "Kullanıcı adı bulunamadı"
                }
            }
        }
    }
    
}
