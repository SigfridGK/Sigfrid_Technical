//
//  MainViewController.swift
//  Sigfrid_Technical
//
//  Created by Sigfrid Acabal on 8/15/23.
//

import UIKit
import DropDown

class MainViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var searchCountry: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    //properties
    var allRestCountry:[RegionDataModel] = []
    var allRegion = [String]()
    
    var availableCountry = [String]()
    
    let regionDrpDown = DropDown()
    lazy var networkDropDowns: [DropDown] = {
     return [self.regionDrpDown]
    }()
    
    
    let countryResult = DropDown()
    lazy var countryResults: [DropDown] = {
     return [self.countryResult]
    }()
    
    var selectedRegion = ""
    var selectedCountry = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDownBtn.addTarget(self, action: #selector(didTapRegion), for: .touchUpInside)
        submitBtn.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        clearBtn.addTarget(self, action: #selector(didTapClear), for: .touchUpInside)
        
        searchCountry.addTarget(self, action: #selector(didChangeSearchTxt), for: .editingChanged)
        
        // init Data
        callAPIRegion()
        initKeyBoardHide()
    }
    
    func initKeyBoardHide(){
        self.hideKeyboard()
        NotificationCenter.default.addObserver(self,
                                       selector: #selector(self.keyboardWillShow(notification:)),
                                       name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                       selector: #selector(self.keyboardWillHide(notification:)),
                                       name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getRegionList() {
        regionDrpDown.anchorView = dropDownBtn
        regionDrpDown.bottomOffset = CGPoint(x: 0, y: dropDownBtn.bounds.height)
        regionDrpDown.dataSource = allRegion
        regionDrpDown.selectionAction = { [weak self] (index, item) in
            self?.dropDownBtn.setTitleColor(.black, for: .normal)
            self?.dropDownBtn.setTitle(item, for: .normal)
            self?.selectedRegion = item
            
            var filterdCountry = self?.allRestCountry.filter({$0.region == item})
            filterdCountry = filterdCountry?.sorted { $0.name.common < $1.name.common }
            filterdCountry?.forEach { e in
                self?.availableCountry.append(e.name.common)
            }
            
            self?.getCountryList()
        }
        
        regionDrpDown.reloadAllComponents()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backLabel = UIBarButtonItem()
        
        if segue.identifier == "showSubmitSegue"{
            let nextViewCntrlr = segue.destination as! SubmittedVC
            nextViewCntrlr.name = nameTxtField.text ?? ""
            nextViewCntrlr.selectedRegion = selectedRegion
            nextViewCntrlr.selectedCountry = selectedCountry
            nextViewCntrlr.allRestCountry = allRestCountry
        }
    }
    
    @objc
    func didTapSubmit(){
        var isValid = true
        let arrTxt = [searchCountry.text,selectedRegion,nameTxtField.text]
        arrTxt.forEach { e in
            if e == ""{
                isValid = false
                return;
            }
        }
        
        performSegue(withIdentifier: "showSubmitSegue", sender: nil)
    }
    
    @objc
    func didTapClear(){
        self.dropDownBtn.setTitleColor(.gray, for: .normal)
        self.dropDownBtn.setTitle("Select your region", for: .normal)
        self.selectedRegion = ""
        
        searchCountry.text = ""
    }
    
    @objc
    func didTapRegion(){
        regionDrpDown.show()
    }
    
    
    func getCountryList() {
        countryResult.anchorView = searchCountry
        countryResult.bottomOffset = CGPoint(x: 0, y: searchCountry.bounds.height - 50)
        countryResult.dataSource = availableCountry
        countryResult.selectionAction = { [weak self] (index, item) in
            self?.searchCountry.text = item
            self?.selectedCountry = item
        }
    
        countryResult.reloadAllComponents()
    }
    
    @objc
    func didChangeSearchTxt(){
        countryResult.show()
    }
}
