//
//  TopSellingCollectionViewCell.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 18.11.2024.
//

import UIKit
import SnapKit


class TopSellingCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "TopSellingCollectionViewCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let favButton = UIButton()
    private let addToCartButton = UIButton()
    
    private var isFav: Bool = false
    
    var viewModel =  MainViewModel()
    var product: Product?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(favButton)
        contentView.addSubview(addToCartButton)
        
        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favButton.tintColor = .purple
        favButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.top.equalTo(favButton.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.equalToSuperview().inset(10)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(10)
        }
        addToCartButton.setTitle("Add to cart", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        addToCartButton.backgroundColor = .systemPurple
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    func configure(with product: Product) {
        imageView.image = UIImage(named: product.image!)
        titleLabel.text = product.name
        priceLabel.text = "\(product.price) TL"
    }
    
    @objc private func favButtonTapped(){
        isFav.toggle()
        favButton.setImage(isFav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)        
    }
}
