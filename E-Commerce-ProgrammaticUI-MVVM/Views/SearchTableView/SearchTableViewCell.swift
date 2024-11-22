//
//  SearchTableViewCell.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 22.11.2024.
//

import UIKit
import SnapKit
import Lottie

class SearchTableViewCell: UITableViewCell {

    static let identifier: String = "SearchTableViewCell"
    
    var animationView : LottieAnimationView!
    
    private var view = UIView()
    private let customImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let favButton = UIButton()
    private let addToCartButton = UIButton()
    
    var viewModel = FavoritesViewModel.shared
    private var isFav: Bool = false
    var product: Product?
    
    var cartVM = CartViewModel.shared
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(view)
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        view.addSubview(customImageView)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(favButton)
        view.addSubview(addToCartButton)
        
        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favButton.tintColor = .purple
        favButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(30)
        }
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        customImageView.contentMode = .scaleAspectFit
        customImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(10)
            make.width.equalTo(150)
        }
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(customImageView.snp.right).offset(10)
            make.right.equalTo(favButton.snp.left)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(customImageView.snp.right).offset(10)
            make.right.equalToSuperview()
        }
        addToCartButton.setTitle("Add to cart", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        addToCartButton.backgroundColor = .systemPurple
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(20)
            make.left.equalTo(customImageView.snp.right)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    func configure(with product: Product){
        self.product = product
        customImageView.image = UIImage(named: product.image!)
        titleLabel.text = product.name
        priceLabel.text = "\(product.price) TL"
        
        isFav = viewModel.favoritesList.contains(where: { $0.id == product.id })
        if isFav {
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @objc private func favButtonTapped(){
        guard let currentProduct = product else {
            print("product is nil")
            return
        }
        isFav.toggle()
        favButton.setImage(isFav ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        
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
