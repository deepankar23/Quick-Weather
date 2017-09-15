//
//  HomeViewController.swift
//  Quick Weather
//
//  Created by Deepankar Srivastava on 9/11/17.
//  Copyright © 2017 Deepankar Srivastava. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- IB-Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    //MARK:- ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- IB-Actions
    
    @IBAction func weatherButtonTapped(_ sender: Any) {
    
        guard let text = textField.text else{
            return
        }

        if text.isEmpty {
            let alertController =  UIAlertController.init(title: "Oops", message: kAlertMessage, preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: kWeatherDetailSegueIdentifier, sender: nil)
        }
        
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == kWeatherDetailSegueIdentifier{
        
            guard let weatherDetailVC = segue.destination as? WeatherDetailViewController else{
                return
            }
            
            weatherDetailVC.cityName = self.textField.text ?? ""
            
        }
        
    }

}

