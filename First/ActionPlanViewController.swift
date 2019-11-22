//
//  ActionPlanViewController.swift
//  First
//
//  Created by Shayan on 2019-11-12.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit

class ActionPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var bodyparts = [BodyPart]()
    var severities = [String]()
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (segmentedControl.selectedSegmentIndex == 0){
            return bodyparts.count
        }
        else {
            return 2
        }
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BodyPartResultTableViewCell", for: indexPath) as? BodyPartResultTableViewCell else {
            fatalError("The dequeued cell is not an instance of PatientTableViewCell.")
        }
        let part = bodyparts[indexPath.row]
        let sev = severities[indexPath.row]
        
        if (segmentedControl.selectedSegmentIndex == 0){
            cell.setEverything(bodypart: part, sev: sev)
        }
        else {
            cell.setEverythingGeneral(int: indexPath.row)
        }
        cell.selectionStyle = .none

        
        return cell
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
