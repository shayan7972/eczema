//
//  BodyPartsViewController.swift
//  First
//
//  Created by Shayan on 2019-11-09.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit

class BodyPartsViewController: UIViewController {
    
    var body_selected = [String]()
    var baby = Patient()

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "Select \(baby.name)'s affected body parts:"
        welcomeLabel.numberOfLines = 2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bodyPartTapped (_ sender: UIButton){
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            sender.isSelected = !sender.isSelected
            if (sender.isSelected){
                self.body_selected.append(sender.titleLabel!.text!.lowercased())
            } else{
                if let index = self.body_selected.firstIndex(of: sender.titleLabel!.text!.lowercased()) {
                    self.body_selected.remove(at: index)
                }
            }
            
        }) { (success) in
            UIView.animate(withDuration: 0.2, delay: 0.05, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion:nil)
        }

    }
    
    
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let submitPhotosViewController = segue.destination as? SubmitPhotosViewController
        var bodyparts = [BodyPart]()
        for part in body_selected{
            bodyparts += [BodyPart(name: part)]
        }
        
        if (bodyparts.count == 0){
            // create the alert
            let alert = UIAlertController(title: "No Body Part Selected", message: "Please select at least one body part to proceed.", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        else {
            submitPhotosViewController?.bodyparts = bodyparts
        }
        
        
        
    }

}
