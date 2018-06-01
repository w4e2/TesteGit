//
//  RepositoriesTableViewCell.swift
//  TesteCedroIOS
//
//  Created by pc on 31/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit
import AlamofireImage
class RepositoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var authorImageView: UIImageView!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
        self.authorNameLabel.textColor = ColorManager.getAuthorNameColor()
        self.repositoryNameLabel.textColor = ColorManager.getRepositoryNameColor()
        self.repositoryDescriptionLabel.textColor = ColorManager.getRepositoryDescritionColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func customizeForItem(_ item: Items) {
        self.authorNameLabel.text = "Author: \(item.owner?.login ?? "")"
        if let imageURL = item.owner?.avatarUrl {
            if let url = URL(string: imageURL) {
                let placeholderImage = UIImage(named: "placeholder")
                self.authorImageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
            }
        }
        self.repositoryNameLabel.text = item.name
        self.repositoryDescriptionLabel.text = item.descriptionValue
        
        
    }
}
