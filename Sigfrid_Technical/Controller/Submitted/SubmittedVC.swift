//
//  MainViewController.swift
//  Sigfrid_Technical
//
//  Created by Sigfrid Acabal on 8/15/23.
//

import UIKit
import DropDown

class SubmittedVC: UIViewController {
    
    @IBOutlet weak var resultTxt: UILabel!
    
    //properties
    var allRestCountry:[RegionDataModel] = []
    var name = ""
    var selectedRegion = ""
    var selectedCountry = ""
    var capital = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let getCapital = allRestCountry
//                        .filter({$0.region == selectedRegion && $0.name.common == selectedCountry})
//        capital = getCapital[0].capital[0]
        
        // init Data
        resultTxt.text = "Hi \(name) \n\n You are from \(selectedRegion), \n\(selectedCountry) \n\nYour Capital City is:\(capital)"
    }
}
