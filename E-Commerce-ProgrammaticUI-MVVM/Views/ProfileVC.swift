//
//  ProfileVC.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 17.11.2024.
//

import UIKit

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
        
        nameLabel.text = "Bayram Yeleç"
        emailLabel.text = "bayramyelec@gmail.com"
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
}
