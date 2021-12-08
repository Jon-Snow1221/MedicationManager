//
//  MoodSurveyViewController.swift
//  MedicationManager
//
//  Created by Jonathan Llewellyn on 11/11/21.
//

import UIKit

protocol MoodSurveyViewControllerDelegate: AnyObject {
    func moodButtonTapped(with emoji: String)
}

class MoodSurveyViewController: UIViewController {

    weak var delegate: MoodSurveyViewControllerDelegate?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reminderFired),
                                               name: NSNotification.Name(Strings.medicationReminderReceived),
                                               object: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func emojiTapped(_ sender: UIButton) {
        guard let emoji = sender.titleLabel?.text else {return}
        
        delegate?.moodButtonTapped(with: emoji)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func reminderFired() {
//        view.backgroundColor = .systemRed
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.view.backgroundColor = .systemPurple
//        }
    }

}
