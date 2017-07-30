//
//  TableAnimatorController.swift
//  Test
//
//  Created by prafulla on 29/07/17.
//  Copyright © 2017 HelloDoc. All rights reserved.
//

import UIKit

class TableAnimatorController: UIViewController {

    @IBOutlet weak var addElement: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var cellTimerBucketCollection : [CellTimerDataBucket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ProgressCell
        self.navigationItem.title = "Question2"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()//avoid dummy cell
        self.tableView.register(UINib(nibName: "ProgressCell", bundle: nil), forCellReuseIdentifier: "ProgressCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddItemClicked(_ sender: Any) {
        var playerName = 0
        let count = cellTimerBucketCollection.count
        if count != 0 {
            playerName = cellTimerBucketCollection[count - 1].playerNumber + 1
        }
        let newCell = CellTimerDataBucket.init(playerNum: playerName)
        newCell.delegate = self
        self.tableView.beginUpdates()
        _ = self.cellTimerBucketCollection.append(newCell)
        tableView.insertRows(at: [IndexPath.init(row: count, section: 0)], with: .bottom)
        self.tableView.endUpdates()
    }


}


extension TableAnimatorController : UITableViewDelegate {
    
}


extension TableAnimatorController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(withIdentifier: "ProgressCell") as! ProgressCell
        let bucket = cellTimerBucketCollection[indexPath.row]
        newCell.playerName.text = "Player " + String(bucket.playerNumber)
        newCell.configTimer(currentTime: bucket.remaningTime)
        return newCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTimerBucketCollection.count
    }
}

extension TableAnimatorController : TimeOverDelegate {
    func didFinishTimer(playerName : Int) {
        // remove timer
        // Player added first will removed first so no need of playerName
        self.tableView.beginUpdates()
        _ = self.cellTimerBucketCollection.remove(at: 0)
        tableView.deleteRows(at: [IndexPath.init(row: 0, section: 0)], with: .top)
        self.tableView.endUpdates()
        
        let alertController = UIAlertController(title: "Player \(playerName)", message: Q2Constants.alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}

