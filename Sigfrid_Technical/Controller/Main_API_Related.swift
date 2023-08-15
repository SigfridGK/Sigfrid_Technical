//
//  Main_API_Related.swift
//  Sigfrid_Technical
//
//  Created by Sigfrid Acabal on 8/15/23.
//
import Alamofire
import Foundation

extension MainViewController {
    func callAPIRegion(){
        let url = "https://restcountries.com/v3.1/all"
        let header: HTTPHeaders = ["content-type":"application/json"]
        AF.request(url, method: .get, encoding: URLEncoding.httpBody, headers: header)
        .responseDecodable(of: [RegionDataModel].self) { (response) in
            switch response.result {
            case let .failure(error):
                break
            case .success:
                if let data = response.value {
                    self.allRestCountry = data
                    self.allRestCountry = self.allRestCountry.sorted { $0.region < $1.region }
                    self.allRestCountry.forEach { e in
                        if (!self.allRegion.contains(e.region)){
                            self.allRegion.append(e.region)
                        }
                    }
                    self.getRegionList()
                }
                break
            }
        
        }.resume()
    }
}
