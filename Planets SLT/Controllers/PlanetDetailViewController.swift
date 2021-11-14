//
//  PlanetDetailViewController.swift
//  Planets SLT
//
//  Created by Chathura Jayanaka on 11/14/21.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    var planet: Planet?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrbitalPeriod: UILabel!
    @IBOutlet weak var lblGravity: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setPlanetData()
    }
    
    func setPlanetData() {
        lblName.text = planet?.name
        lblOrbitalPeriod.text = planet?.orbitalPeriod
        lblGravity.text = planet?.gravity
    }

}
