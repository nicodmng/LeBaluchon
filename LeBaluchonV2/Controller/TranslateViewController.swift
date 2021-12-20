//
//  TranslateViewController.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 19/11/2021.
//

import UIKit

class TranslateViewController: UIViewController {
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var translationButton: UIButton!
    
    @IBOutlet weak var userTextView: UITextView!
    @IBOutlet weak var resultTextView: UITextView!
    
    @IBOutlet weak var selectLanguagePickerView: UIPickerView!
    
    @IBAction func translateButtonPressed(_ sender: Any) {
        getDataTranslate()
        translationButton.isEnabled = false
    }
    
    // MARK: - Let & Var
    
    var serviceTranslate = TranslateService()
    var traduction: String?
    
    var currentLanguageValue = "en"
    let countries = [(langue:"Bulgarian", idLangue:"BG"),
                     (langue:"Czech", idLangue:"CS"),
                     (langue:"Danish", idLangue:"DA"),
                     (langue:"German", idLangue:"DE"),
                     (langue:"Greek", idLangue:"EL"),
                     (langue:"English (British)", idLangue:"EN-GB"),
                     (langue:"English (American)", idLangue:"EN-US"),
                     (langue:"Spanish", idLangue:"ES"),
                     (langue:"Estonian", idLangue:"ET"),
                     (langue:"Finnish", idLangue:"FI"),
                     (langue:"Hungarian", idLangue:"HU"),
                     (langue:"Italien", idLangue:"IT"),
                     (langue:"Japanese", idLangue:"JA"),
                     (langue:"Lithuanien", idLangue:"LT"),
                     (langue:"Latvian", idLangue:"LV"),
                     (langue:"Dutch", idLangue:"NL"),
                     (langue:"Polish", idLangue:"PL"),
                     (langue:"Portuguese", idLangue:"PT-PT"),
                     (langue:"Portuguese (Brazilian)", idLangue:"PT-BR"),
                     (langue:"Romanian", idLangue:"RO"),
                     (langue:"Russian", idLangue:"RU"),
                     (langue:"Slovak", idLangue:"SK"),
                     (langue:"Slovenian", idLangue:"SL"),
                     (langue:"Swedish", idLangue:"SV"),
                     (langue:"Chinese", idLangue:"ZH")
    ]
        
    // MARK: - Override
    
    // Keyboard disappear
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userTextView.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeholderText()
        selectLanguagePickerView.delegate = self
        selectLanguagePickerView.dataSource = self
    }
    
    // MARK: - Functions
    
    private func getDataTranslate() {
        self.serviceTranslate.getTranslate(text: userTextView.text, languageCodeTarget: currentLanguageValue) { [weak self] result in DispatchQueue.main.async {
            switch result {
            case .success(let translate):
                self?.traduction = translate.translations[0].text
                self?.resultTextView.text = self?.traduction
                self?.translationButton.isEnabled = true
            case .failure(let error):
                self?.showAlert(message: error.description)
                }
            }
        }
        
    }
    
    private func placeholderText() {
        userTextView.text = "Saisissez votre text en français ici"
        userTextView.textColor = UIColor.lightGray
        userTextView.font = UIFont.italicSystemFont(ofSize: 20)
    }
    
    private func textViewDidBeginEditing(_ userTextView: UITextView) {
        if userTextView.textColor == UIColor.lightGray {
            userTextView.text = nil
            userTextView.textColor = UIColor.black
        }
    }
    
}
//End of class

// MARK: - Extensions

extension TranslateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].langue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentLanguageValue = countries[row].idLangue
    }
}
