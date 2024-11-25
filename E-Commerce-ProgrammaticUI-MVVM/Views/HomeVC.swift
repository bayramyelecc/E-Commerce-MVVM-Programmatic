//
//  HomeVC.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 17.11.2024.
//

import UIKit
import SnapKit
import Lottie

class HomeVC: UIViewController {
    
    private var animationView: LottieAnimationView!
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let searchBar = UITextField()
    private let categoriesTitle = UILabel()
    private let categoriesCollectionView = CategoriesCollectionVC()
    private let topSellingTitle = UILabel()
    private let topSellingCollectionView = TopSellingCollectionViewController()
    private let newInTitle = UILabel()
    private let newInCollectionView = NewInCollectionViewVC()
        
    
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        categoriesCollectionView.delegate = self
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.topSellingCollectionView.reloadData()
    }
    
}

extension HomeVC: SetupProtocol, CategoriesCollectionVCDelegate {
    
    
    func setup() {
        configure()
        drawUI()
        makeLayout()
        
    }
    
    func didSelectCategory(_ category: Categories) {
        let detailVC = CategoriesDetailVC()
        detailVC.selectedCategory = category
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func configure() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(categoriesTitle)
        
        stackView.addArrangedSubview(categoriesCollectionView)
        stackView.addArrangedSubview(topSellingTitle)
        stackView.addArrangedSubview(topSellingCollectionView)
        stackView.addArrangedSubview(newInTitle)
        stackView.addArrangedSubview(newInCollectionView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartButtonTapped))
        navigationController?.navigationBar.tintColor = .purple
        
        let titleLabel = UILabel()
        titleLabel.text = "TRADE"
        titleLabel.textColor = UIColor.systemPurple
        titleLabel.font = .systemFont(ofSize: 18, weight: .black)
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
        
    }
    
    func drawUI() {
        view.backgroundColor = .systemBackground
        scrollView.backgroundColor = .systemBackground
        stackView.backgroundColor = .systemBackground
        scrollView.alwaysBounceVertical = true
        scrollView.bouncesHorizontally = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        categoriesTitle.text = "Categories"
        categoriesTitle.textColor = .black
        categoriesTitle.font = .systemFont(ofSize: 15, weight: .bold)
        categoriesTitle.attributedText = createAttributedString(with: categoriesTitle.text!, leftPadding: 15)
        
        categoriesCollectionView.backgroundColor = .systemBackground
        
        topSellingTitle.text = "Top Selling"
        topSellingTitle.textColor = .black
        topSellingTitle.font = .systemFont(ofSize: 15, weight: .bold)
        topSellingTitle.attributedText = createAttributedString(with: topSellingTitle.text!, leftPadding: 15)
        
        topSellingCollectionView.backgroundColor = .systemBackground
        
        newInTitle.text = "New In"
        newInTitle.textColor = .systemPurple
        newInTitle.font = .systemFont(ofSize: 15, weight: .bold)
        newInTitle.attributedText = createAttributedString(with: newInTitle.text!, leftPadding: 15)
        
        newInCollectionView.backgroundColor = .systemBackground
    }
    
    func makeLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.height.equalTo(90)
        }
        
        topSellingCollectionView.snp.makeConstraints { make in
            make.height.equalTo(290)
        }
        
        newInCollectionView.snp.makeConstraints { make in
            make.height.equalTo(290)
        }
    }
    
    func createAttributedString(with text: String, leftPadding: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = leftPadding
        paragraphStyle.firstLineHeadIndent = leftPadding
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    @objc private func cartButtonTapped(){
        let vc = BasketVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


