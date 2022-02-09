//
//  SearchImageViewController.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 8.2.2022.
//

import UIKit

class SearchImageViewController: UIViewController {

    // MARK: - IB Outlets
    
    /// Text Field for  the Date
    @IBOutlet private weak var dateTextField: UITextField!
    /// Button for executing the search action
    @IBOutlet private weak var searchButton: UIButton!

    // MARK:  Properties
    
    var navigationDelegate: PresentImageDetailViewDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setUpPickerView()
        super.viewDidLoad()
    }
    // MARK: - IBAction
    
    @IBAction func searchButtonPressed() {
        guard let navigationDelegate = navigationDelegate,
              let date = dateTextField.text,
              !date.isEmpty else {
            return
        }
        navigationDelegate.presentImageDetailsViewController(date: date)
        dateTextField.resignFirstResponder()
        dateTextField.text = ""
    }
    
    // MARK: - Date Picker Events
    
    @objc private func onDateSelection() {
        guard let datePickerView = dateTextField.inputView as? UIDatePicker else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = dateFormatter.string(from: datePickerView.date)
        dateTextField.resignFirstResponder()
    }
    @objc private func cancelDateSelection() {
        dateTextField.text = ""
        dateTextField.resignFirstResponder()
    }
    private func setUpPickerView() {
        dateTextField.datePicker(target: self,
                                  doneAction: #selector(onDateSelection),
                                  cancelAction: #selector(cancelDateSelection),
                                  datePickerMode: .date)
    }
}
