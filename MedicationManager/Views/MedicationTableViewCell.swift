//
//  MedicationTableViewCell.swift
//  MedicationManager
//
//  Created by Jonathan Llewellyn on 11/10/21.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {
    
    //OUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wasTakenButton: UIButton!
    
   //ACTIONS
    @IBAction func wasTakenButtonTapped(_ sender: UIButton) {
        print("Was tekn button tapped")
    }
    
}
