//
//  EntryDetailViewController.swift
//  Journal_CloudKit_BreakDown
//
//  Created by Diego Aguirre on 8/7/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let entry = entry {
            updateWithEntry(entry)
        }
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        if var entry = self.entry {
            entry.title = titleTextField.text!
            entry.body = self.bodyTextView.text
        } else {
            let newEntry = Entry(title: self.titleTextField.text!, body: self.bodyTextView.text)
            EntryController.sharedController.postNewEntry(newEntry, completion: { (_) in
                
            })
            self.entry = newEntry
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func clearButtonTapped(sender: AnyObject) {
        
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    func updateWithEntry(entry: Entry) {
        self.entry = entry
        
        self.titleTextField.text = entry.title
        self.bodyTextView.text = entry.body
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

}
