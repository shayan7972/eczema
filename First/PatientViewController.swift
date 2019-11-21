//
//  PatientViewController.swift
//  First
//
//  Created by Shayan on 2019-11-02.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit
import os.log

class PatientViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        
    }
    
    var patient : Patient?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text field’s user input through delegate callbacks.
        nameField.delegate = self
        
        // Set up views if editing an existing baby.
        if let patient = patient {
            nameField.text = patient.name
            profileImage.image = patient.photo
            ageField.text = String(patient.age)
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        nameField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        profileImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameField.text ?? ""
        let photo = profileImage.image
        let age = Int(ageField.text!)
        
        // Set the meal to be passed to PatientTableViewController after the unwind segue.
        patient = Patient(name: name, photo: photo, age: age!)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

    
    
    

}
