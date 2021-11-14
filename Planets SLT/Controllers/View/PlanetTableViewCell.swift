//
//  PlanetTableViewCell.swift
//  Planets SLT
//
//  Created by Chathura Jayanaka on 11/14/21.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblClimate: UILabel!
    @IBOutlet weak var ivImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
