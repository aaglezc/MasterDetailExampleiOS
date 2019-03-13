//
//  DetailViewController.swift
//  MasterDetailExampleiOS
//
//  Created by Pritesh Patel on 2018-02-23.
//  Copyright © 2018 MoxDroid. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var myProgressView: UIView!
    var timer = Timer()
    var seconds = 10
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textField_Date: UITextField!
    var datePicker : UIDatePicker!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var lblLocalizationtitle: UILabel!
    
    //https://iosdevcenters.blogspot.com/2017/05/uipickerview-example-with-uitoolbar-in.html
    //https://iosdevcenters.blogspot.com/2016/03/ios9-uidatepicker-example-with.html
    @IBOutlet weak var txt_pickUpData: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    
    var currentSlected: Int = 0
    var myPickerView : UIPickerView!
    var pickerDataFirstName = ["Hitesh" , "Kirit" , "Ganesh" , "Paresh"]
    var pickerDataLastName = ["Modi" , "Patel" , "Gandhi" , "Joshi", "Sharma", "Amin"]
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        self.txt_pickUpData.delegate = self
        self.txt_LastName.delegate = self
        self.textField_Date.delegate = self
        
        self.lblLocalizationtitle.text = NSLocalizedString("BOOK_PURCHASE", comment: "")
        
        runTimer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func pickUp(_ textField : UITextField){
    
    // UIPickerView
    self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
    self.myPickerView.delegate = self
    self.myPickerView.dataSource = self
    self.myPickerView.backgroundColor = UIColor.white
    textField.inputView = self.myPickerView
    
    // ToolBar
    let toolBar = UIToolbar()
    toolBar.barStyle = .default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
    toolBar.sizeToFit()
    
    // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DetailViewController.doneClick))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(DetailViewController.cancelClick))
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    textField.inputAccessoryView = toolBar
    
    }

    //MARK:- PickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentSlected == 1{
        return pickerDataFirstName.count
        }else{
            return pickerDataLastName.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentSlected == 1{
            return pickerDataFirstName[row]
        }else{
            return pickerDataLastName[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentSlected == 1{
            self.txt_pickUpData.text = pickerDataFirstName[row]
        }else{
            self.txt_LastName.text = pickerDataLastName[row]
        }
    }
    //MARK:- TextFiled Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      
        if textField.isEqual(txt_pickUpData)
        {
            currentSlected = 1
            self.pickUp(textField)
        }
        else if textField.isEqual(txt_LastName){
            currentSlected = 2
            self.pickUp(textField)
        }else{
            currentSlected = 3
            self.pickUpDate(textField)
        }
        
        
    }
    
   //MARK:- Button
    @objc func doneClick() {
        if currentSlected == 1{
            txt_pickUpData.resignFirstResponder()
        }
        else if currentSlected == 2{
            txt_LastName.resignFirstResponder()
        }else{
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateStyle = .medium
            dateFormatter1.timeStyle = .none
            textField_Date.text = dateFormatter1.string(from: datePicker.date)
            textField_Date.resignFirstResponder()
        }
        }
    
    @objc func cancelClick() {
        if currentSlected == 1{
            txt_pickUpData.resignFirstResponder()
        }
        else if currentSlected == 2{
            txt_LastName.resignFirstResponder()
        }else{
            textField_Date.resignFirstResponder()
        }
    }
    
    
    func pickUpDate(_ textField : UITextField){
    
    // DatePicker
    self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
    self.datePicker.backgroundColor = UIColor.white
    self.datePicker.datePickerMode = UIDatePickerMode.date
    textField.inputView = self.datePicker
    
    // ToolBar
    let toolBar = UIToolbar()
    toolBar.barStyle = .default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
    toolBar.sizeToFit()
    
    // Adding Button ToolBar
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    textField.inputAccessoryView = toolBar
    
    }
    
    @IBAction func segmentPriceChange(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        txt_LastName.text = "\(seconds)" //This will update the label.
        if(seconds == 0){
            myActivityIndicator.stopAnimating()
            myProgressView.isHidden = true
        timer.invalidate()
        }
    }
}

// MARK: - IBActions
extension DetailViewController {
    
    @IBAction func cancelToPlayersViewController(_ segue: UIStoryboardSegue) {
        print("Cancel")
    }
    
    @IBAction func savePlayerDetail(_ segue: UIStoryboardSegue) {
        print("Save")
    }
}
