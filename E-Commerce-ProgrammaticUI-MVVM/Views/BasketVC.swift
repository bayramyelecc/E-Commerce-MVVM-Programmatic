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
    
    private let descLabel = UILabel()
    
    
    var product: Product?
    
    var favVM = FavoritesViewModel.shared
    
    
    var viewModel = CartViewModel.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.onCartUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.descLabelUpdate()
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        descLabelUpdate()
    }
}

extension BasketVC: SetupProtocol, BasketCellDelegate {
    
    func descLabelUpdate() {
        if !viewModel.cartList.isEmpty {
            descLabel.isHidden = true
        } else {
            descLabel.isHidden = false
        }
    }
    
    func didTapRemoveButton(product: Product) {
        
        let alert = UIAlertController(title: "UYARI", message: "Ürünü silmek istediğinizden emin misiniz ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.viewModel.removeFromCart(product)
            self.collectionView.reloadData()
            print("ürün silindi")
            let totalPrice = self.viewModel.cartList.reduce(0) { $0 + $1.price }
            self.totalPriceLabel.text = "\(String(format: "%.1f", totalPrice)) TL"
        }))
        present(alert, animated: true)
    }
    
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
        collectionView.basketDelegate = self
        view.addSubview(descLabel)
    }
    
    func drawUI() {
        view.backgroundColor = .systemBackground
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
        
        let totalPrice = viewModel.cartList.reduce(0) { $0 + $1.price }
        totalPriceLabel.text = "\(String(format: "%.1f", totalPrice)) TL"
        totalPriceLabel.font = .systemFont(ofSize: 20, weight: .black)
        totalPriceLabel.textColor = .black
        totalPriceLabel.textAlignment = .center
        
        descLabel.text = "add something to your cart"
        descLabel.textColor = .black
        descLabel.textAlignment = .center
        descLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
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
        descLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
