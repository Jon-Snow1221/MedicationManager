//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by Jonathan Llewellyn on 11/10/21.
//

import UIKit

class MedicationListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        MedicationController.shared.fetchMedication()
    }
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MedicationListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MedicationController.shared.medications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicationTableViewCell else {return UITableViewCell()}
        
        let medication = MedicationController.shared.medications[indexPath.row]
        
        cell.nameLabel.text = medication.name
        cell.timeLabel.text = "\(medication.timeOfDay)"
        
        return cell
    }
    
}

extension MedicationListViewController: UITableViewDelegate {
    
}
