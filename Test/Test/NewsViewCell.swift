//
//  NewsViewCell.swift
//  Test
//
//  Created by prafulla on 30/07/17.
//  Copyright © 2017 HelloDoc. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
    @IBOutlet weak var newsTitle: UILabel!

    @IBOutlet weak var newsTime: UILabel!
    @IBOutlet weak var newsTags: UILabel!
    @IBOutlet weak var newsAuther: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
