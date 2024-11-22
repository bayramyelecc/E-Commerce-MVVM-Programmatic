//
//  SearchTableView.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 22.11.2024.
//

import UIKit
import SnapKit

class SearchTableView: UIViewController {
    
    private let tableView = UITableView()
    private let searchBar = UITextField()
    
    var viewModel = MainViewModel()
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        keyboardClose()
    }
    
    func setupSearchBar() {
        
        title = "All Products"
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.textColor = .black
        searchBar.font = .systemFont(ofSize: 15)
        searchBar.layer.cornerRadius = 25
        searchBar.clipsToBounds = true
        searchBar.borderStyle = .none
        searchBar.backgroundColor = .systemGray6
        searchBar.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchBar.leftView?.tintColor = .black
        searchBar.leftViewMode = .always
        searchBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        searchBar.addTarget(self, action: #selector(searchingFunc), for: .editingChanged)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartButtonTapped))
        navigationController?.navigationBar.tintColor = .purple
        
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.separatorStyle = .none
    }
    
    @objc func searchingFunc(){
        guard let text = searchBar.text else { return }
        if text.isEmpty {
            isSearching = false
            viewModel.searchFilterItems = viewModel.products
        } else {
            isSearching = true
            viewModel.filterProducts(name: text)
        }
        tableView.reloadData()
    }
    
    func keyboardClose() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func cartButtonTapped(){
        let vc = BasketVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? viewModel.searchFilterItems.count : viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.selectionStyle = .none
        let product = isSearching ? viewModel.searchFilterItems[indexPath.row] : viewModel.products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
