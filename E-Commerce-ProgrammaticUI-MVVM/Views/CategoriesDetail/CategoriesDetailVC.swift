//
//  CategoriesDetailVC.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 19.11.2024.
//

import UIKit

class CategoriesDetailVC: UIViewController {
    
    var selectedCategory: Categories?
    var viewModel = MainViewModel()
    
    weak var basketDelegate: BasketCellDelegate?
    
    private var filteredProducts: [Product] = []
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}

extension CategoriesDetailVC: SetupProtocol {
    func setup() {
        configure()
        drawUI()
        makeLayout()
    }
    
    func configure() {
        
        guard let selectedCategory = selectedCategory?.name else { return }
        filteredProducts = viewModel.products(category: selectedCategory)
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoriesDetailCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesDetailCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func drawUI() {
        view.backgroundColor = .systemBackground
        title = selectedCategory?.name
    }
    
    func makeLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CategoriesDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesDetailCollectionViewCell.identifier, for: indexPath) as! CategoriesDetailCollectionViewCell
        let product = filteredProducts[indexPath.row]
        cell.configure(with: product)
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 15
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.3
        return CGSize(width: width, height: 290)
    }
}
