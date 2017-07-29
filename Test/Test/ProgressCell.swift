//
//  ProgressCell.swift
//  Test
//
//  Created by prafulla on 29/07/17.
//  Copyright © 2017 HelloDoc. All rights reserved.
//

import UIKit

class ProgressCell: UITableViewCell {

   
    @IBOutlet weak var progressBar: CirculerProgressView!
    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var playerName: UILabel!
    var timer : Timer?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configTimer(currentTime : Int){
        
        progressBar.progress =  (CGFloat(currentTime)/CGFloat(Q2Constants.countDownTime))

        
        timerText.text = String(currentTime)
        
        
        timer?.invalidate()  // if already running
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ProgressCell.update), userInfo: nil, repeats: true)
        
    }
    
    func update() {
        if let crTime = Int(timerText.text ?? "0") {
            if crTime > 0 {
                timerText.text = String(crTime - 1)
                progressBar.progress =  (CGFloat(crTime - 1)/CGFloat(Q2Constants.countDownTime))
            }
        }
    }
}
