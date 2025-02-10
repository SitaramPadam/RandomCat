//
//  CatView.swift
//  RandomCat
//
//  Created by sai sitaram on 07/02/25.
//

import UIKit

class CatView: UIView {
    
    @IBOutlet var factLabel:UILabel!
    @IBOutlet var carImage:UIImageView!
    @IBOutlet var quotesButton:UIButton!
    
    var viewModel:CatsInfoViewModel = CatsInfoViewModel()
    
    func setUpUI(){
        self.quotesButton.layer.cornerRadius = 10
        self.quotesButton.layer.shadowColor = UIColor.black.cgColor
        self.quotesButton.layer.shadowOpacity = 0.3
        self.quotesButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.quotesButton.layer.shadowRadius = 4
        self.quotesButton.clipsToBounds = false
    }
    
    func updateUI(details: CatModel){
        factLabel.text  = details.data[0]
    }
    
    @IBAction func onClickCatInfo(_sender : AnyObject){
        viewModel.delegate = self
        DispatchQueue.global().async { [self] in
            viewModel.getCatFactsData()
        }
    }
}

extension CatView:CatInfoViewModelDelegate {
    func catDataDisplay(catInfoModel: CatModel?) {
        if let quotesData = catInfoModel,catInfoModel?.data != nil {
            DispatchQueue.main.async {
                self.updateUI(details: quotesData)
            }
        }
    }
}
