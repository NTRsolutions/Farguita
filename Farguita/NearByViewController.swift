//
//  NearByViewController.swift
//  Farguita
//
//  Created by ahmed on 5/29/18.
//  Copyright © 2018 Ahmed Derbala. All rights reserved.
//

import UIKit
import Alamofire

class NearByViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nearByTableView: UITableView!
    var nearByList = [AnyObject]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        Alamofire.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.1254,8.2541&radius=5000&keyword=restaurant&key=AIzaSyBK1huFM4wx3BcM-cr10_3MJ9QMRNQ0Kb0").responseJSON
            {
                response in
                let result = response.result
                
                if let dict = result.value as? Dictionary<String,AnyObject>
                {
                    if let innerDict = dict["results"]
                    {
                        self.nearByList = innerDict as! [AnyObject]
                        self.nearByTableView.reloadData()
                    }
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearByList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let nameLabel:UILabel = cell.viewWithTag(1) as! UILabel
        let name = nearByList[indexPath.row]["name"]
        nameLabel.text = name as? String
       
        let vicinityLabel:UILabel = cell.viewWithTag(2) as! UILabel
        let vicinity = nearByList[indexPath.row]["vicinity"]
        vicinityLabel.text = vicinity as? String
        
       /* let long:UILabel = cell.viewWithTag(4) as! UILabel
        let long2 = nearByList[indexPath.row]["rating"]
        long.text = long2 as? String */
    return cell
    }

    
}
