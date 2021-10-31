//
//  EpisodeDetailsViewController.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/30/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    var viewModel = EpisodeDetailsViewModel()
    var episode: Episode?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        scrollView.alpha = 0.70
        scrollView.layer.cornerRadius = 10.0
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }
    
    private let headerImageBgView: UIImageView = {
        let headerImageBgView = UIImageView()
        headerImageBgView.contentMode = .scaleAspectFill
        headerImageBgView.translatesAutoresizingMaskIntoConstraints = false
        headerImageBgView.clipsToBounds = true
        return headerImageBgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.episode = self.episode
        
        setupViews()
        populateView()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.white
        view.addSubviewPinningEdges(subView: headerImageBgView)
        view.addSubviewPinningEdges(subView: scrollView, leading: 20, trailing: 20, top: 150, bottom: 80)
        scrollView.addSubviewPinningEdges(subView: contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.addSubviewPinningEdges(subView: stackView)
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20,
                                                                     leading: 20,
                                                                     bottom: 20,
                                                                     trailing: 20)
    }
    
    private func populateView(){
        guard let episode = viewModel.episode else { return }
        
        self.title = episode.name
        
        let seasonEpisodeLabel = createLabel()
        seasonEpisodeLabel.text = viewModel.seasonEpisodeDisplayValue
        stackView.addArrangedSubview(seasonEpisodeLabel)

        if let airDateValue = episode.airdate {
            let airDateDisplayValue = "\(airDateValue) \(episode.airtime)"
            let airDateLabel = createLabel()
            airDateLabel.text = airDateDisplayValue
            stackView.addArrangedSubview(airDateLabel)
        }
        
        let summaryLabel = createLabel()
        summaryLabel.text = episode.summary
        stackView.addArrangedSubview(summaryLabel)
        
        let websiteLabel = createLabel()
        websiteLabel.text = episode.links.linksSelf.href
        stackView.addArrangedSubview(websiteLabel)

        populateHeaderImageView()
    }
    
    private func populateHeaderImageView(){
        guard let imageUrlString = viewModel.episode?.image.original,
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

