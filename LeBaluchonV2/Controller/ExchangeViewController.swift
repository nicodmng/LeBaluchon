//
//  ViewController.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 17/11/2021.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    // MARK: - IBOutlet & IBAction
    
    @IBOutlet weak var euroText: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dayRate: UILabel!
    
    @IBAction func textFieldChange(_ sender: UITextField) {
        if let r = rate, let text = sender.text, let d = Double(text) {
            let result = String(d * r)
            resultLabel.text = result
        }
    }
    
    //MARK: - Let & Var
    
    private var serviceRate: ExchangeService!
    
    var rate: Double? {
        didSet {
            if let r = rate {
                let numberFormatter = NumberFormatter()
                numberFormatter.maximumFractionDigits = 3
                let rateFormatter = numberFormatter.string(for: r)
                dayRate.text = (rateFormatter ?? "") + " $"
            }
        }
    }
    
    // MARK: - Overrides
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        serviceRate = ExchangeService()
        getRate()
    }
    
    // Keyboard disappear
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        euroText.resignFirstResponder()
    }
    
    // MARK: - Functions
    
    private func getRate() {
        serviceRate.getExchange { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let exchangeRate):
                    self?.rate = exchangeRate.rates["USD"]
                case .failure(let error):
                    self?.showAlert(message: error.description)
                }
            }
        }
    }
}
// End of class
