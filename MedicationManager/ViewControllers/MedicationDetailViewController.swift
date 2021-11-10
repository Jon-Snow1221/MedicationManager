//
//  MedicationDetailViewController.swift
//  MedicationManager
//
//  Created by Jonathan Llewellyn on 11/10/21.
//

import UIKit

class MedicationDetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func savedButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
              !name.isEmpty
        else {return}
        
        let timeOfDay = datePicker.date
        
        MedicationController.shared.createMedication(name: name, timeOfDay: timeOfDay)
    }
}
