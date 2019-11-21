//
//  PatientTableViewController.swift
//  First
//
//  Created by Shayan on 2019-11-02.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit
import os.log

class PatientTableViewController: UITableViewController {
    //MARK: Properties
    var patients = [Patient]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load the sample data.
           loadSamplePatients()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return patients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PatientTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PatientTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PatientTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let patient = patients[indexPath.row]
        
        cell.nameLabel.text = patient.name
        cell.profileImageView.image = patient.photo
        cell.ageLabel.text = String(patient.age)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @IBAction func unwindToPatientList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? PatientViewController, let patient = sourceViewController.patient {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                patients[selectedIndexPath.row] = patient
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: patients.count, section: 0)
                
                patients.append(patient)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            patients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddBaby":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let patientDetailViewController = segue.destination as? PatientViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
             
            guard let selectedPatientCell = sender as? PatientTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
             
            guard let indexPath = tableView.indexPath(for: selectedPatientCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
             
            let selectedPatient = patients[indexPath.row]
            patientDetailViewController.patient = selectedPatient
            
        case "BodyPartsSelector":
            
            guard let bodyPartsViewController = segue.destination as? BodyPartsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedPatient = sender as? UIButton else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let index = tableView.indexPath(for: selectedPatient.superview?.superview as! UITableViewCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedBaby = patients[index.row]
            
            bodyPartsViewController.baby = selectedBaby
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }

    }
    
    
    //MARK: Private Methods
     
    private func loadSamplePatients() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let patient1 = Patient(name: "Shayan", photo: photo1, age: 4) else {
            fatalError("Unable to instantiate 1")
        }
        
        guard let patient2 = Patient(name: "Sina", photo: photo2, age: 5) else {
            fatalError("Unable to instantiate 2")
        }
        
        guard let patient3 = Patient(name: "Michele", photo: photo3, age: 3) else {
            fatalError("Unable to instantiate 3")
        }
        
        patients += [patient1, patient2, patient3]
        
    }

}
