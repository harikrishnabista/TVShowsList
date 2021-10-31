//
//  FavoritesViewController.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/28/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private var viewModel = FavoritesViewModel()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        view.backgroundColor = UIColor.white
        
        self.setupViews()
    }
    
    private func setupViews(){
        view.addSubviewPinningEdges(subView: tableView)
        
        tableView.register(EpisodeListCell.self, forCellReuseIdentifier: "EpisodeListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateFavoriteEpisodes()
        tableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeListCell", for: indexPath) as? EpisodeListCell else {
            fatalError()
        }
        
        cell.populate(episode: viewModel.favoriteEpisodes[indexPath.row], delegate: self)
        return cell
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = EpisodeDetailsViewController()
        detailVC.episode = viewModel.favoriteEpisodes[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FavoritesViewController: EpisodeListCellProtocol {
    func favoriteListUpdated() {
        viewModel.updateFavoriteEpisodes()
        tableView.reloadData()
    }
}

