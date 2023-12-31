//
//  ViewController.swift
//  ByteCoin
//
//  Created by Anna Zaitsava on 20.08.23.
//

import UIKit

var coinManager = CoinManager()

class ViewController: UIViewController, UIPickerViewDataSource {
    

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

}
//MARK: CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdateRate(currency: String, rate: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = rate
            self.currencyLabel.text = currency
        }
    }
        
        func didFailWithError(error: Error) {
            print(error)
    }
}

//MARK: UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        print(coinManager.currencyArray[row])
    }
    
}
