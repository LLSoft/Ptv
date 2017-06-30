//
//  ViewController.swift
//  PredictiveTextTableView
//
//  Created by Matthew Howes Singleton on 5/26/16.
//  Copyright © 2016 Matthew Howes Singleton. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var autoCompletePossibilities: [String] = []
    var autoComplete: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Predictive Text TableView"
        
        textField.delegate = self
        tableView.delegate = self
    }
    
    
    // MARK: - Clear
    
    func clearTextFieldAfterAddingToArray() {
        textField.text = ""
    }
    
    
    // MARK: - TextField
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchAutocompleteEntriesWithSubstring(substring)
        return true
    }
    
    
    func addToArray(textField: UITextField) {
        if textField == textField {
            let textToAdd = textField.text ?? ""
            autoCompletePossibilities.append(textToAdd)
            print("it worked")
        }
    }
    
    
    // MARK: - String
    
    func searchAutocompleteEntriesWithSubstring(_ substring: String) {
        autoComplete.removeAll(keepingCapacity: false)
        for key in autoCompletePossibilities {
            let myString:NSString! = key as NSString
            let substringRange :NSRange! = myString.range(of: substring)
            if (substringRange.location  == 0) {
                autoComplete.append(key)
            }
        }
        tableView.reloadData()
    }
    
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let index = indexPath.row as Int
        cell.textLabel!.text = autoComplete[index]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        textField.text = selectedCell.textLabel!.text!
    }
    
    
    // MARK: - IBAction
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addToArray(textField: textField)
        clearTextFieldAfterAddingToArray()
    }
    
}






