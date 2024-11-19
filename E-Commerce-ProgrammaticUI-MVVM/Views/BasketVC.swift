//
//  BasketVC.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 17.11.2024.
//

import UIKit
import SnapKit

class BasketVC: UIViewController {
    
    private let collectionView = BasketCollectionView()
    private let priceView = UIView()
    private let totalPriceLabel = UILabel()
    private let buyButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension BasketVC: SetupProtocol {
    func setup() {
        configure()
        drawUI()
        makeLayout()
    }
    
    func configure() {
        navigationItem.title = "Basket"
        view.addSubview(collectionView)
        view.addSubview(priceView)
        priceView.addSubview(totalPriceLabel)
        view.addSubview(buyButton)
    }
    
    func drawUI() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemRed
        
        priceView.backgroundColor = .systemBackground
        
        buyButton.setTitle("Buy", for: .normal)
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
        buyButton.backgroundColor = .systemPurple
        buyButton.layer.cornerRadius = 25
        buyButton.layer.shadowColor = UIColor.black.cgColor
        buyButton.layer.shadowRadius = 10
        buyButton.layer.shadowOpacity = 0.2
        buyButton.layer.shadowOffset = .zero
        
        totalPriceLabel.text = "100$"
        totalPriceLabel.font = .systemFont(ofSize: 20, weight: .black)
        totalPriceLabel.textColor = .black
        totalPriceLabel.textAlignment = .center
        
    }
    
    func makeLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(20)
        }
        priceView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(priceView.snp.bottom)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        totalPriceLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
