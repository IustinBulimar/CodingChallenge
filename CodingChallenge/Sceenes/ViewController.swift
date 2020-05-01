//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Iustin Bulimar on 01/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var activities = [Activity]()
    
    var apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        updateActivities()
    }
    
    func updateActivities() {
        apiManager.getActivities { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let activities):
                    self.activities = activities
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    

    //  MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activity = activities[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as? ActivityCell else { return UITableViewCell() }
        
        cell.titleLabel.text = activity.title
        cell.checkSwitch.isOn = activity.completed
        
        return cell
    }

}



