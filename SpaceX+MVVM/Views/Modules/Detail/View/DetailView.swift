//
//  DetailCell.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 17.06.2022.
//

import Foundation
import UIKit
import YouTubePlayer
import SDWebImage

class DetailView: UIView {
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .sfPro20()
        label.textColor = .mainBlack()
        return label
    }()
    
    private let rocketLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .sfPro20()
        label.textColor = .mainBlack()
        return label
    }()
    
    private let successLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .sfPro20()
        label.textColor = .mainBlack()
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .mainBlack()
        label.numberOfLines = 0
        label.font = .sfPro20()
        label.textAlignment = .justified
        return label
    }()
    
    private let playerView = YouTubePlayerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        mainView.clipsToBounds = true
        setConstraints()
        
        self.layer.shadowColor = UIColor.mainBlack().cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.playerView.layer.cornerRadius = 10
        self.playerView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(from viewModel: DetailViewModel) {
        let imageUrl = viewModel.launch.links.patch.large
        let url = URL(string: imageUrl ?? "")
        image.sd_setImage(with: url, completed: nil)
        let link = viewModel.launch.links.webcast //video
        guard let videoLink = URL(string: link ?? "") else { return }
        playerView.loadVideoURL(videoLink)
        
        nameLabel.text = "🌙 \(viewModel.launch.name ?? "")"
        rocketLabel.text = "🚀 id: \(viewModel.launch.rocket ?? "")"
        successLabel.text = "\(viewModel.launch.success ?? false)"
        detailsLabel.text = viewModel.launch.details
        
        if successLabel.text == "false" {
            successLabel.text = "lauchStatusFailed".localized(tableName: "LibraryDetailsVC")
            successLabel.textColor = .mainRed()
        } else if successLabel.text == "true" {
            successLabel.text = "lauchStatusSuccessed".localized(tableName: "LibraryDetailsVC")
            successLabel.textColor = .mainGreen()
        }
        print("configured!!!!")
    }
    
    private func setConstraints() {
        playerView.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        playerView.contentMode = .scaleAspectFill

        self.addSubview(mainView)
        mainView.addSubview(image)
        mainView.addSubview(nameLabel)
        mainView.addSubview(rocketLabel)
        mainView.addSubview(successLabel)
        mainView.addSubview(detailsLabel)
        mainView.addSubview(playerView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            image.heightAnchor.constraint(equalToConstant: 75),
            image.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 5)
        ])

        NSLayoutConstraint.activate([
            rocketLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            rocketLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            rocketLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 5)
        ])

        NSLayoutConstraint.activate([
            successLabel.topAnchor.constraint(equalTo: rocketLabel.bottomAnchor, constant: 5),
            successLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            successLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 5)
        ])

        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            detailsLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 20),
            playerView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            playerView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            playerView.heightAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
    }
}
