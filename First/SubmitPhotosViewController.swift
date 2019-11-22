//
//  SubmitPhotosViewController.swift
//  First
//
//  Created by Shayan on 2019-11-11.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit

class SubmitPhotosViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var num=0

    
    
    @IBOutlet weak var mytable: UITableView!
    
    
    var bodyparts = [BodyPart]()

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
        let severities = ["under-control","flare-up","out-of-control"]
        var sev = [String]()
        
        sendRequestToServer()
        //send body part to server and ask for an answer
        //for bp in bodyparts
        // sev = ask_for_severity(bp)
        // severities.append(sev)
        let actionplanview = segue.destination as? ActionPlanViewController
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print(bodyparts)
        print(bodyparts.count)
        
        for _ in 1...bodyparts.count{
            let randomName = severities.randomElement()!
            sev.append(randomName)
        }
        print(sev)
        
        
        actionplanview?.bodyparts = bodyparts
        actionplanview?.severities = sev
    }
    
    func sendRequestToServer(){
        let url = URL(string: "http://hello-bond.appspot.com/predict")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "head": bodyparts.filter { $0.name == "face" },
            "right_hand": bodyparts.filter { $0.name == "arm" },
            "right_foot": bodyparts.filter { $0.name == "foot" },
        ]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }

        task.resume()
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
