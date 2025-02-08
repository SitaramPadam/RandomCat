//
//  RandomCatViewController.swift
//  RandomCat
//
//  Created by sai sitaram on 07/02/25.
//

import UIKit

class RandomCatViewController: UIViewController {
       
    @IBOutlet var catView:CatView!
        
    var viewModel:CatsInfoViewModel = CatsInfoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        catView.setUpUI()
        viewModel.delegate = self
        DispatchQueue.global().async { [self] in
            viewModel.getCatFactsData()
        }
    }

}

extension RandomCatViewController:CatInfoViewModelDelegate {
    func CatDataDisplay(catInfoModel: CatModel?) {
        if let factsData = catInfoModel,catInfoModel?.data != nil {
            DispatchQueue.main.async {
                self.catView.updateUI(details: factsData)
            }
        }
    }
}
