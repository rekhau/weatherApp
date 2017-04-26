//
//  MainViewController.swift
//  OpenWeatherApp
//
//  Created by Rekha Bisht on 4/23/17.
//  Copyright © 2017 Rekha Bisht. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var searchTextField:UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var minMaxTemp: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    
    var city:String = String()
    
    @IBAction func searchClicked(sender:UIButton) {
        searchTextField.resignFirstResponder()
        callWeatherService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //May be use google API to load the cities on the fly
        super.viewWillAppear(true)
        searchTextField.becomeFirstResponder()
        
        //Check if in the user defaults there exists any city ; if yes refresh the weather data
        if !WeatherSettings.lastCitySearched.isEmpty {
            searchTextField.text = WeatherSettings.lastCitySearched
            city = WeatherSettings.lastCitySearched
            callWeatherService()
        }
        else {
           initializeUIComponents()
        }
        
        toggleSearchButton()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func callWeatherService() {
        NetworkService.downloadData(forCity: city, handler: { data,error in
            if (data != nil) {
                DispatchQueue.main.async {  [weak self] in
                    self?.cityName.text = data?.cityName
                    self?.currentTemp.text = data?.currentTemp
                    self?.minMaxTemp.text = (data?.minTemp)! + "/" + (data?.maxTemp)!
                    WeatherSettings.lastCitySearched = (data?.cityName)!
                    
                }
                //Call the image URL in the background
                DispatchQueue.global().async {
                    NetworkService.downloadWeatherImage(forWeatherType: (data?.imageName)!, handler: { (data, error) in
                        if (data != nil) {
                            //Extract the image data and refresh the image view on main
                            DispatchQueue.main.async { [weak self ] in
                                self?.weatherImageView.image = UIImage(data: data!)
                            }
                        }
                        else {
                            print("Could not get Image data")
                        }
                    })
                }
                
            }
            else {
                DispatchQueue.main.async { [weak self] in
                    self?.initializeUIComponents()
                    self?.showAlert()
                }
                
            }
            
        })
    }
    
    func initializeView() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: nil, queue: OperationQueue.main) { [weak self]
            notification in
            self?.city = (notification.object! as AnyObject).text
            self?.toggleSearchButton()
        }
    }
    
    func toggleSearchButton() {
        if (searchTextField.text?.isEmpty)! {
            searchButton.isEnabled = false
        }
        else {
            searchButton.isEnabled = true
        }
    }
    
    func initializeUIComponents() {
        cityName.text = "- - "
        currentTemp.text = "- -"
        minMaxTemp.text = "- -/- - "
        searchTextField.text = ""
        weatherImageView.image = UIImage()
        searchButton.isEnabled = false
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Data could not be fetched at this time.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        alert.addAction(defaultAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}


extension MainViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
}
