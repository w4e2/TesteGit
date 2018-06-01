//
//  PullRequestTableViewCell.swift
//  TesteCedroIOS
//
//  Created by pc on 31/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit

class PullRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var pullNameLabel: UILabel!
    @IBOutlet weak var pullDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
        self.authorNameLabel.textColor = ColorManager.getAuthorNameColor()
        self.pullDateLabel.textColor = ColorManager.getRepositoryNameColor()
        self.pullNameLabel.textColor = ColorManager.getRepositoryDescritionColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func customizeForItem(_ request: PullRequest) {
        self.authorNameLabel.text = "Author: \(request.user?.login ?? "")"
        if let imageURL = request.user?.avatarUrl {
            if let url = URL(string: imageURL) {
                let placeholderImage = UIImage(named: "placeholder")
                self.authorImageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
            }
        }
        self.pullNameLabel.text = request.title
        self.pullDateLabel.text = Util.formatBackDateString(dateString: request.createdAt!)
        
        
    }
}
