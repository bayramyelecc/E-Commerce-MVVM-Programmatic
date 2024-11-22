//
//  CategoriesDetailCollectionViewCell.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 19.11.2024.
//

import UIKit
import Lottie

class CategoriesDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CategoriesDetailCollectionViewCell"
    
    var animationView: LottieAnimationView!
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let favButton = UIButton()
    private let addToCartButton = UIButton()
    
    private var isFav: Bool = false
    var product: Product?
    
    var cartVM = CartViewModel.shared
    var viewModel = FavoritesViewModel.shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
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
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    func configure(with product: Product) {
        self.product = product
        imageView.image = UIImage(named: product.image!)
        titleLabel.text = product.name
        priceLabel.text = "\(product.price) TL"
        
        isFav = viewModel.favoritesList.contains(where: { $0.id == product.id })
        if isFav {
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    
    @objc private func favButtonTapped() {
        guard let currentProduct = product else {
            print("Product is nil")
            return
        }
        isFav.toggle()
        print("Favorite button tapped for: \(currentProduct.name)")
        if isFav {
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            viewModel.addToFavorites(currentProduct)
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            viewModel.removeFromFavorites(currentProduct)
        }
    }
    
    @objc func addToCart(){
        guard let currentProduct = product else {
            print("product is nil")
            return
        }
        cartVM.addToCart(currentProduct)
        showAddToCartAnimation()
    }
    
    func showAddToCartAnimation() {
        animationView = LottieAnimationView(name: "cart")
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.center = contentView.center
        animationView.contentMode = .scaleAspectFit
        contentView.addSubview(animationView)
        animationView.play { [weak self] finished in
            if finished {
                self?.animationView.removeFromSuperview()
            }
        }
    }
    
}
