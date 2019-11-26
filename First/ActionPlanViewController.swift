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
    
    @IBOutlet weak var segmented: UISegmentedControl!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (segmented.selectedSegmentIndex == 0){
            return 2
        }
        else {
            return bodyparts.count
        }
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        self.table.reloadInputViews()
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BodyPartResultTableViewCell", for: indexPath) as? BodyPartResultTableViewCell else {
            fatalError("The dequeued cell is not an instance of PatientTableViewCell.")
        }
        
        if (segmented.selectedSegmentIndex == 0){
            cell.setEverythingGeneral(int: indexPath.row)
        }
        else {
            if (severities.isEmpty){
                severities = [String](repeating: "not_processed", count: bodyparts.count)
            }
            let part = bodyparts[indexPath.row]
            let sev = severities[indexPath.row]
            cell.setEverything(bodypart: part, sev: sev)
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
