//
//  EpisodeListCell.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/30/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

protocol EpisodeListCellProtocol: class {
    func favoriteListUpdated()
}

class EpisodeListCell: UITableViewCell {
    
    private lazy var containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var episodeImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var episodeNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .white
        label.backgroundColor = UIColor.darkGray
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let favoriteButton = UIButton()
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        return favoriteButton
    }()
    
    var episode: Episode?
    weak var delegate: EpisodeListCellProtocol?
    
    @objc func favoriteButtonTapped(){
        guard let episode = self.episode else { return }
        if FavoriteEpisodeList.shared.checkIfIsFavorite(episode: episode) {
            FavoriteEpisodeList.shared.remove(episode: episode)
        } else {
            FavoriteEpisodeList.shared.add(episode: episode)
        }
        delegate?.favoriteListUpdated()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(episodeImageView)
        containerView.addSubview(episodeNameLabel)
        containerView.addSubview(subTitleLabel)
        contentView.addSubview(containerView)
        contentView.addSubview(favoriteButton)
        
        episodeImageView.centerYAnchor.constraint(equalTo:contentView.centerYAnchor).isActive = true
        episodeImageView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant:10).isActive = true
        episodeImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        episodeImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:episodeImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        episodeNameLabel.topAnchor.constraint(equalTo:containerView.topAnchor).isActive = true
        episodeNameLabel.leadingAnchor.constraint(equalTo:containerView.leadingAnchor).isActive = true
        episodeNameLabel.trailingAnchor.constraint(equalTo:favoriteButton.leadingAnchor).isActive = true
        
        subTitleLabel.topAnchor.constraint(equalTo:episodeNameLabel.bottomAnchor).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo:containerView.leadingAnchor).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo:episodeNameLabel.bottomAnchor).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo:containerView.leadingAnchor).isActive = true
        
        favoriteButton.widthAnchor.constraint(equalToConstant:60).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant:60).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant:0).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo:contentView.centerYAnchor).isActive = true
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func populate(episode: Episode, delegate: EpisodeListCellProtocol) {
        self.episode = episode
        self.delegate = delegate
        
        episodeNameLabel.text = episode.name
        subTitleLabel.text = "Season \(episode.season) | episode \(episode.number)"
        
        guard let imageUrl = URL(string: episode.image.medium) else { return }
        self.episodeImageView.image = nil
        ImageDownloadHelper.shared.downloadImage(url: imageUrl) { (image) in
            DispatchQueue.main.async {
                self.episodeImageView.image = image
            }
        }
        
        if FavoriteEpisodeList.shared.checkIfIsFavorite(episode: episode) {
            favoriteButton.setImage(UIImage(named: "favoriteFilled"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        }
    }
}
