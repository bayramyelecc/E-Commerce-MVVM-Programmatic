//
//  CategoriesCollectionViewCell.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 18.11.2024.
//

import UIKit
import SnapKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CategoriesCollectionViewCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let backView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(backView)
        backView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        backView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        backView.layer.cornerRadius = 35
        backView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(70)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 10, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configure(with category: Categories) {
        if let name = category.image {
            imageView.image = UIImage(named: name)
        }
        titleLabel.text = category.name
    }
    
}
