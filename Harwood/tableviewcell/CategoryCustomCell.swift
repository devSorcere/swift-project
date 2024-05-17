//
//  CategoryCustomCell.swift
//  Harwood
//
//  Created by Star on 5/8/24.
//

import Foundation
import UIKit

class CategoryCustomCell: UITableViewCell {
    
    @IBOutlet weak var view_filename: UIView!
    @IBOutlet weak var view_preview: UIView!
    @IBOutlet weak var btn_preview: UIButton!
    
    @IBOutlet weak var lbl_filename: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
