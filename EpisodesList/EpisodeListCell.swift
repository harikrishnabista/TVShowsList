//
//  EpisodeListCell.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/30/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

//class EpisodeListCell: UITableViewCell {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.initializeView()
//    }
//
//    func initializeView(){
//
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//}

class EpisodeListCell: UITableViewCell {
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let episodeImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let episodeNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .white
        label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    let countryImageView:UIImageView = {
//        let img = UIImageView()
//        img.contentMode = .scaleAspectFill // without this your image will shrink and looks ugly
//        img.translatesAutoresizingMaskIntoConstraints = false
//        img.layer.cornerRadius = 13
//        img.clipsToBounds = true
//        return img
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(episodeImageView)
        containerView.addSubview(episodeNameLabel)
        containerView.addSubview(subTitleLabel)
        self.contentView.addSubview(containerView)
        
//        self.contentView.addSubview(countryImageView)
        
        episodeImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        episodeImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        episodeImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        episodeImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.episodeImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        episodeNameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        episodeNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        episodeNameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        subTitleLabel.topAnchor.constraint(equalTo:self.episodeNameLabel.bottomAnchor).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo:self.episodeNameLabel.bottomAnchor).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        
//        countryImageView.widthAnchor.constraint(equalToConstant:26).isActive = true
//        countryImageView.heightAnchor.constraint(equalToConstant:26).isActive = true
//        countryImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20).isActive = true
//        countryImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func populate(episode: Episode) {
        episodeNameLabel.text = episode.name
        subTitleLabel.text = "Season \(episode.season) | episode \(episode.number)"
        
        guard let imageUrl = URL(string: episode.image.medium) else { return }
        self.episodeImageView.image = nil
        ImageDownloadHelper.shared.downloadImage(url: imageUrl) { (image) in
            DispatchQueue.main.async {
                self.episodeImageView.image = image
            }
        }
    }
}
