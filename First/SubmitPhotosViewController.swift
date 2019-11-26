//
//  SubmitPhotosViewController.swift
//  First
//
//  Created by Shayan on 2019-11-11.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit
import Alamofire

class SubmitPhotosViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var num=0

    
    
    @IBOutlet weak var mytable: UITableView!


    
    
    var bodyparts = [BodyPart]()
    var images: Dictionary = [Int:Any]()
    var sev = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        loadSampleData()
        mytable.delegate = self
        mytable.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bodyparts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TakePictureTableViewCell", for: indexPath) as? TakePictureTableViewCell else {
            fatalError("The dequeued cell is not an instance of PatientTableViewCell.")
        }
        let part = bodyparts[indexPath.row]
        
        cell.setBodyPart(part: part)
        cell.delegate = self
        cell.tag = indexPath.row
        cell.selectionStyle = .none
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let severities = ["under-control","flare-up","out-of-control"]
        
        var parameters: Dictionary = [String: Data] ()
        
        if (images.isEmpty){
            let alert = UIAlertController(title: "No Picture Captured", message: "Please select at least one body part to proceed.", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        


        
        for body in bodyparts {
            let index = bodyparts.firstIndex{$0 === body}!
            print(index)
            let im = images[index]!
            print(im)
            parameters[body.name] = im as? Data
        }
        print(parameters)

        
        requestWith(parameters: parameters, completion: {
            print("completed")
            
            let actionplanview = segue.destination as? ActionPlanViewController
                       //
                       //

            actionplanview?.bodyparts = self.bodyparts
            actionplanview?.severities = self.sev
            
        })
        
            

        
        
       
    }

    
    func requestWith(parameters: [String : Any], completion: @escaping () -> Void){
        
//        let url = "https://eczema-baby.appspot.com/predict"
        let url = "https://hello-bond.appspot.com/predict"

        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
                
        
   

       
        AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    multipartFormData.append(value as! Data, withName: key as String,fileName: key+".jpeg" , mimeType: "image/png")
                }

            }, to: url, method: .post, headers: headers)
                .uploadProgress { progress in
                    print("Upload Progress: \(progress.fractionCompleted)")
                }
                .downloadProgress { progress in
                    print("Download Progress: \(progress.fractionCompleted)")
                }
            .responseJSON(completionHandler: { response in
                
                switch response.result {
                case .success(let value):
                    print(value)
                    
                    
                    if let dictionary = value as? [String: Any] {
                        for bp in self.bodyparts{
                            if let state = dictionary[bp.name] as? String {
                                self.sev.append(state)
                            }
                        }
                        print(dictionary)
                    }
                    
                    completion()

                case let .failure(error):
                    print(error)
                    completion()
                }
            })
        
    }
    
    
    
    //MARK: Private Methods
     
    private func loadSampleData() {
        
        let arm = BodyPart(name: "arm")
        let face = BodyPart(name: "face")
        let foot = BodyPart(name: "foot")

        
        bodyparts +=  [arm,face,foot]

    }

}

extension SubmitPhotosViewController : TakePictureDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    func didTapTakePhoto(cell: TakePictureTableViewCell) {
        let imagePicker = UIImagePickerController()
        num=cell.tag
        imagePicker.delegate = self
        imagePicker.sourceType = .camera

        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[.originalImage] as? UIImage
        let cell2 = mytable.cellForRow(at: NSIndexPath(row: num, section: 0) as IndexPath) as! TakePictureTableViewCell
        
        cell2.cameraImage.image = image
        cell2.bodypart.photo = image
        images[num] = image!.jpegData(compressionQuality: 0.5)

    }
    
    
    
    
}


extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
