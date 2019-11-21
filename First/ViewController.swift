//
//  ViewController.swift
//  First
//
//  Created by Shayan on 2019-10-30.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    var imagePicker: UIImagePickerController!

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func takePhoto(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera

        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageView.image = info[.originalImage] as? UIImage
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    


}

