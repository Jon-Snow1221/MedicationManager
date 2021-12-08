//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by Jonathan Llewellyn on 11/10/21.
//

import UIKit

class MedicationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moodSurveyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MedicationController.shared.fetchMedication()
        guard let survey = MoodSurveyController.shared.fetchTodaysSurvey() else {return}
        
        moodSurveyButton.setTitle(survey.mentalState, for: .normal)
        
        //Notification settings:
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reminderFired),
                                               name: NSNotification.Name(Strings.medicationReminderReceived),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func surveyButtonTapped(_ sender: UIButton) {
        // Programatic segue: (I ended up using storyboard segue instead)
//        guard let moodSurveyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "moodSurveyViewController") as? MoodSurveyViewController else {return}
//        moodSurveyViewController.delegate = self
//        performSegue(withIdentifier: "toMoodSurveyViewController", sender: self)
    }
    
    @objc private func reminderFired() {
        
    }
    

    // MARK: - Navigation Segues

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Strings.medicationDetailsSegueIdentifier,
           let indexPath = tableView.indexPathForSelectedRow,
           let destination = segue.destination as? MedicationDetailViewController {
            let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
            destination.medication = medication
        } else if segue.identifier == Strings.moodSurveyViewControllerSegueIdentifier, // tell the segue from the storyboard who the delegate is
                  let destination = segue.destination as? MoodSurveyViewController {
            destination.delegate = self
        }
    }
}

// MARK: - TableView Data Source
extension MedicationListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MedicationController.shared.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MedicationController.shared.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicationTableViewCell else {return UITableViewCell()}
        
        let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
       
        cell.configure(with: medication)
        cell.delegate = self
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Not Taken"
        } else if section == 1 {
            return "Taken"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // called to delete our cell on swipe
            /// Grabs the `Medication` that we want to delete
            let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
            /// Calls the delete function on our `MedicationController`
            MedicationController.shared.deleteMedication(medication: medication)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension MedicationListViewController: UITableViewDelegate {
    
}

extension MedicationListViewController: MedicationTableViewCellDelegate {
    
    func medicationWasTakenButtonTapped(medication: Medication, wasTaken: Bool) {
        MedicationController.shared.markMedicationTaken(medication: medication, wasTaken: wasTaken)
        tableView.reloadData()
    }
}

extension MedicationListViewController: MoodSurveyViewControllerDelegate {
    func moodButtonTapped(with emoji: String) {
        MoodSurveyController.shared.didTapMoodEmoji(emoji)
        moodSurveyButton.setTitle(emoji, for: .normal)
    }
    
    
}
