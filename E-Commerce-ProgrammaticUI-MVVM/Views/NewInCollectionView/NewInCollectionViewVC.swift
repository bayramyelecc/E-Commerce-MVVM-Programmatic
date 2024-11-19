//
//  NewInCollectionViewVC.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 18.11.2024.
//

import UIKit

class NewInCollectionViewVC: UIView {

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var viewModel = MainViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension NewInCollectionViewVC: SetupProtocol {
    func setup() {
        configure()
        drawUI()
        makeLayout()
        collectionView.reloadData()
    }
    
    func configure() {
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewInCollectionViewCell.self, forCellWithReuseIdentifier: NewInCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func drawUI() {
        collectionView.backgroundColor = .systemBackground
    }
    
    func makeLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NewInCollectionViewVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.newList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewInCollectionViewCell.identifier, for: indexPath) as! NewInCollectionViewCell
        let model = viewModel.newList[indexPath.row]
        cell.configure(with: model)
        cell.backgroundColor = .lightGray.withAlphaComponent(0.2)
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 170
        return CGSize(width: width, height: 290)
    }
}