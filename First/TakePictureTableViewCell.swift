//
//  TakePictureTableViewCell.swift
//  First
//
//  Created by Shayan on 2019-11-10.
//  Copyright © 2019 Eczema. All rights reserved.
//

import UIKit

protocol TakePictureDelegate {
    
    func didTapTakePhoto(cell: TakePictureTableViewCell)
}

class TakePictureTableViewCell: UITableViewCell {


    @IBOutlet weak var iconImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    

    @IBOutlet weak var cameraImage: UIImageView!
    
    var delegate : TakePictureDelegate?
    var bodypart : BodyPart!
    
    
    func setBodyPart(part: BodyPart){
        nameLabel.text = part.name
        iconImage.image = part.icon
        cameraImage.image = part.photo
        bodypart = part
    }
    
    
    @IBAction func takePicture(_ sender: Any) {
        delegate?.didTapTakePhoto(cell : self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
