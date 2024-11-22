//
//  FavoritesVC.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 17.11.2024.
//

import UIKit
import SnapKit

class FavoritesVC: UIViewController {
    
    let collectionView = FavoritesCollectionView()
    var viewModel = FavoritesViewModel.shared
    
    private var descLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.onFavoritesListUpdated = { [weak self] in
            DispatchQueue.main.async {
                print("Favorites updated: \(self?.viewModel.favoritesList.count ?? 0)")
                self?.collectionView.reloadData()
                self?.descLabelUpdate()
                print("CollectionView reloaded")
            }
        }
    }
}

extension FavoritesVC : SetupProtocol {
    func setup() {
        configure()
        drawUI()
        makeLayout()
    }
    
    func configure() {
        view.addSubview(collectionView)
        view.addSubview(descLabel)
        descLabel.text = "No favorites yet"
        descLabel.textAlignment = .center
        descLabel.font = .systemFont(ofSize: 16, weight: .bold)
        descLabel.textColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartButtonTapped))
        navigationController?.navigationBar.tintColor = .purple
        
    }
    
    func drawUI() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
    }
    
    func makeLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        descLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func descLabelUpdate() {
        if !viewModel.favoritesList.isEmpty {
            descLabel.isHidden = true
        } else {
            descLabel.isHidden = false
        }
    }
    
    @objc private func cartButtonTapped(){
        let vc = BasketVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
