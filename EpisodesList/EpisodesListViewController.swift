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

    private let mainStackView: UIStackView = {
        let summaryStackView = UIStackView()
        summaryStackView.axis = .vertical
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        return summaryStackView
    }()
    
    private let headerView:UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    private let headerImageBgView: UIImageView = {
        let headerImageBgView = UIImageView()
        headerImageBgView.contentMode = .scaleAspectFill
        headerImageBgView.translatesAutoresizingMaskIntoConstraints = false
        headerImageBgView.clipsToBounds = true
        return headerImageBgView
    }()
    
    private let summaryViewContainer: UIView = {
        let summaryViewContainer = UIView()
        summaryViewContainer.translatesAutoresizingMaskIntoConstraints = false
        summaryViewContainer.backgroundColor = UIColor.black
        summaryViewContainer.alpha = 0.85
        summaryViewContainer.layer.cornerRadius = 10.0
        return summaryViewContainer
    }()
    
    private let summaryStackView: UIStackView = {
        let summaryStackView = UIStackView()
        summaryStackView.axis = .vertical
        summaryStackView.distribution = .fill
        summaryStackView.alignment = .fill
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        summaryStackView.spacing = 15
        return summaryStackView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        initViews()
        loadEpisodes()
    }
    
    private func initViews(){
        view.addSubviewPinningEdges(subView: mainStackView)
        
        headerView.addSubviewPinningEdges(subView: headerImageBgView)
        headerView.addSubviewPinningEdges(subView: summaryViewContainer,
                                          leading: 15,
                                          trailing: 15,
                                          top: 15,
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
    }
    
    private func loadEpisodes(){
        viewModel.fetchEpisodes { (success, errorMessage) in
            DispatchQueue.main.async {
                if success {
                    self.populateView()
                } else if let errorMessage = errorMessage {
                    // show error UI with this message
                }
            }
        }
    }
    
    private func populateView(){
        populateHeaderImageView()
        
        title = viewModel.show?.name
        
        let totalSeasonLabel = createLabel()
        totalSeasonLabel.text = viewModel.totalSeasonDisplayValue
        totalSeasonLabel.font = UIFont.boldSystemFont(ofSize: totalSeasonLabel.font.pointSize)
        
        let totalEpisodesLabel = createLabel()
        totalEpisodesLabel.text = viewModel.totalEpisodesDisplayValue
        totalEpisodesLabel.font = UIFont.boldSystemFont(ofSize: totalEpisodesLabel.font.pointSize)
        
        let summaryLabel = createLabel()
        summaryLabel.text = viewModel.show?.summary
        summaryLabel.font = UIFont.italicSystemFont(ofSize: summaryLabel.font.pointSize)
        
        summaryStackView.addArrangedSubview(totalSeasonLabel)
        summaryStackView.addArrangedSubview(totalEpisodesLabel)
        summaryStackView.addArrangedSubview(summaryLabel)
        
        summaryStackView.invalidateIntrinsicContentSize()
        
        mainStackView.isHidden = false
        
        tableView.reloadData()
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
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

