//
//  CatViewModel.swift
//  RandomCat
//
//  Created by sai sitaram on 07/02/25.
//

import Foundation
import UIKit

// MARK: - Protocols
protocol CatInfoViewModelDelegate {
    func catDataDisplay(catInfoModel: CatModel?)
}

class CatsInfoViewModel:CatsInfoServiceLayerDelegate {
   
    var serviceLayer: CatsInfoServiceLayer = CatsInfoServiceLayer()
    var delegate: CatInfoViewModelDelegate? = nil
    
    func getCatFactsData(){
        self.serviceLayer.delegate = self
        self.serviceLayer.getRandomCatFacts()
    }
    
    func responseOfRandomCatFacts(data: CatModel?) {
        delegate?.catDataDisplay(catInfoModel: data)
    }
}
