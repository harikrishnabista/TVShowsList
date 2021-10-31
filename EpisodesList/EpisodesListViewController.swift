//
//  EpisodesListViewController.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/28/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

class EpisodesListViewController: UIViewController {
    
    private let viewModel = EpisodesListViewModel()

    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        return mainStackView
    }()
    
    private lazy var headerView:UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    private lazy var headerImageBgView: UIImageView = {
        let headerImageBgView = UIImageView()
        headerImageBgView.contentMode = .scaleAspectFill
        headerImageBgView.translatesAutoresizingMaskIntoConstraints = false
        headerImageBgView.clipsToBounds = true
        return headerImageBgView
    }()
    
    private lazy var summaryViewContainer: UIView = {
        let summaryViewContainer = UIView()
        summaryViewContainer.translatesAutoresizingMaskIntoConstraints = false
        summaryViewContainer.backgroundColor = UIColor.black
        summaryViewContainer.alpha = 0.85
        summaryViewContainer.layer.cornerRadius = 10.0
        return summaryViewContainer
    }()
    
    private lazy var summaryStackView: UIStackView = {
        let summaryStackView = UIStackView()
        summaryStackView.axis = .vertical
        summaryStackView.distribution = .fill
        summaryStackView.alignment = .fill
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        return summaryStackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EpisodeListCell.self, forCellReuseIdentifier: "EpisodeListCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        initViews()
        loadEpisodes()
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    private func initViews(){
        view.addSubviewPinningEdges(subView: mainStackView)

        headerView.addSubviewPinningEdges(subView: headerImageBgView)
        headerView.addSubviewPinningEdges(subView: summaryViewContainer,
                                          leading: 15,
                                          trailing: 15,
                                          top: 70,
                                          bottom: 15)
        
        summaryViewContainer.addSubviewPinningEdges(subView: summaryStackView)
        
        summaryStackView.isLayoutMarginsRelativeArrangement = true
        summaryStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20,
                                                                           leading: 20,
                                                                           bottom: 20,
                                                                           trailing: 20)
        
        mainStackView.addArrangedSubview(headerView)
        mainStackView.addArrangedSubview(tableView)
        
        mainStackView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadEpisodes(){
        
        // TODO:- show loading UI
        
        viewModel.fetchEpisodes { (success, errorMessage) in
            
            // TODO:- hide loading UI
            
            DispatchQueue.main.async {
                if success {
                    self.populateView()
                } else if let errorMessage = errorMessage {
                    // TODO:- show error UI with this message
                }
            }
        }
    }
    
    private func populateView(){
        populateHeaderImageView()
        
        title = viewModel.show?.name
        
        let seasonEpisodeLabel = createLabel()
        seasonEpisodeLabel.text = viewModel.seasonEpisodeDisplayValue
        seasonEpisodeLabel.font = UIFont.boldSystemFont(ofSize: seasonEpisodeLabel.font.pointSize)
        
        let summaryLabel = createLabel()
        summaryLabel.numberOfLines = 3
        summaryLabel.text = viewModel.show?.summary
        summaryLabel.font = UIFont.italicSystemFont(ofSize: summaryLabel.font.pointSize)
        
        summaryStackView.addArrangedSubview(seasonEpisodeLabel)
        summaryStackView.addArrangedSubview(summaryLabel)
        
        summaryStackView.invalidateIntrinsicContentSize()
        
        mainStackView.isHidden = false
        
        tableView.reloadData()
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.white
        return label
    }
    
    private func populateHeaderImageView(){
        guard let imageUrlString = viewModel.show?.image.medium,
            let imageUrl = URL(string: imageUrlString) else {
            return
        }
        
        ImageDownloadHelper.shared.downloadImage(url: imageUrl) { (image) in
            DispatchQueue.main.async {
                self.headerImageBgView.image = image
            }
        }
    }
    
}

extension EpisodesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.show?.embedded.episodes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeListCell", for: indexPath) as? EpisodeListCell else {
            fatalError()
        }
        
        if let episode = viewModel.show?.embedded.episodes[indexPath.row] {
            cell.populate(episode: episode, delegate: self)
        }
        
        return cell
    }
    
}

extension EpisodesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = EpisodeDetailsViewController()
        detailVC.episode = viewModel.show?.embedded.episodes[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension EpisodesListViewController: EpisodeListCellProtocol {
    func favoriteListUpdated() {
        self.tableView.reloadData()
    }
}
