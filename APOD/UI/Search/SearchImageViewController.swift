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
    
    var navigationDelegate: NavigationDelegate?
        
    /// Picker view for the date selection
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.maximumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    @objc private func cancelDateSelection() {
        self.view.endEditing(true)
    }
    private func setUpPickerView() {
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(onDateSelection))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDateSelection))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
}
