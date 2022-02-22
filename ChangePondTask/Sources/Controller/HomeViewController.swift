//
//  ViewController.swift
//  ChangePondTask
//
//  Created by Sasikumar Perumal on 19/02/22.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.getListApiCall(param: ["query":"technology","page":"1"])
        setupViewModel()
    }


    //View Model Setup
    func setupViewModel() {
        
        viewModel.homeListModel.observeError = { [weak self] error in
            guard let self = self else { return }
            //Show alert here
        }
        viewModel.homeListModel.observeValue = { [weak self] value in
            guard let self = self else { return }
            
            
            
            
        }
        
    }
    
}

