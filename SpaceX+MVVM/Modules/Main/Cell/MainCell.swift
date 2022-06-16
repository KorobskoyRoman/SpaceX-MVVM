//
//  MianCell.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 16.06.2022.
//

import UIKit
import SDWebImage

class MainCell: UITableViewCell {
    
    static let reuseId = "MainCell"
    
    var imagePhoto = UIImageView()
    var dateLabel: UILabel = {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let date = dateFormatter.date(from: label.text ?? "")
        let dateSring = dateFormatter.string(from: date ?? Date())
        label.text = dateSring
        label.textColor = .mainWhite()
        label.font = .sfPro16()
        return label
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainWhite()
        label.font = .sfPro20()
        return label
    }()
    var successLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePhoto.image = nil
    }
    
    override func layoutSubviews() { //округляем всю ячейку
        super.layoutSubviews()
        self.layer.cornerRadius = 10
    }
    
    func update(with viewModel: Result) {
        let launch = viewModel
        let imgUrl = launch.links.patch.small
        guard let imgUrl = imgUrl,
              let url = URL(string: imgUrl)
        else { return }
        
        imagePhoto.sd_setImage(with: url, completed: nil)
        imagePhoto.layer.masksToBounds = false
        imagePhoto.layer.cornerRadius = imagePhoto.frame.size.height / 2
        imagePhoto.clipsToBounds = true
        
        let date = launch.dateUTC?.firstIndex(of: "T")
        let updatedDate = launch.dateUTC![..<date!]
        let dateLabeltext = "Launch date: "
        dateLabel.text = "\(dateLabeltext) \(updatedDate)"
        
        nameLabel.text = "\(launch.name ?? "no data")"
        
        successLabel.text = "\(launch.success ?? false)"
        if successLabel.text == "false" {
            successLabel.text = "Launch failed"
            successLabel.textColor = .mainRed()
        } else if successLabel.text == "true" {
            successLabel.text = "Launch successed"
            successLabel.textColor = .mainGreen()
        }
    }
    
    private func setConstraints() {
            imagePhoto.translatesAutoresizingMaskIntoConstraints = false
            imagePhoto.clipsToBounds = true
            imagePhoto.contentMode = .scaleAspectFill
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            successLabel.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(dateLabel)
            addSubview(imagePhoto)
            addSubview(nameLabel)
            addSubview(successLabel)
            
            NSLayoutConstraint.activate([
                imagePhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                imagePhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                imagePhoto.heightAnchor.constraint(equalToConstant: 50),
                imagePhoto.widthAnchor.constraint(equalToConstant: 50)
            ])
            
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -30),
                nameLabel.leadingAnchor.constraint(equalTo: imagePhoto.trailingAnchor, constant: 10),
                nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
            
            NSLayoutConstraint.activate([
                dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -30),
                dateLabel.leadingAnchor.constraint(equalTo: imagePhoto.trailingAnchor, constant: 10),
                dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
            
            NSLayoutConstraint.activate([
                successLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                successLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -2),
                successLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
            ])
        }
}
