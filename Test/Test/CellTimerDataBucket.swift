//
//  CellTimerDataBucket.swift
//  Test
//
//  Created by prafulla on 29/07/17.
//  Copyright © 2017 HelloDoc. All rights reserved.
//

import UIKit

protocol TimeOverDelegate: class {
    func didFinishTimer( playerName : Int )

}


class CellTimerDataBucket: NSObject {
    var playerNumber : Int = 0
    var remaningTime : Int = Q2Constants.countDownTime
    var delegate : TimeOverDelegate?
    var timer : Timer?
    
    init(playerNum : Int) {
        super.init()
        playerNumber = playerNum
        configTimer()
    }
    
    func configTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CellTimerDataBucket.update), userInfo: nil, repeats: true)
    }
    
    func update() {
        remaningTime = remaningTime - 1
        if remaningTime <= 0 {
            timer?.invalidate()
            delegate?.didFinishTimer(playerName: playerNumber)
        }
    }
}
