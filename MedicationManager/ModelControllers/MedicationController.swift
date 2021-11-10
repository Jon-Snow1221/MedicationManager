//
//  MedicationController.swift
//  MedicationManager
//
//  Created by Jonathan Llewellyn on 11/10/21.
//

import Foundation
import CoreData

class MedicationController {
    
    static let shared = MedicationController()
    
    private init() {}
    
    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //SOT
    var medications: [Medication] = []
    
    //CRUD
    
    func createMedication(name: String, timeOfDay: Date) {
        Medication(name: name, timeOfDay: timeOfDay)
        CoreDataStack.saveContext()
    }
    
    func fetchMedication() {
        let medications = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        print(medications.count)
        self.medications = medications
    }
    
    func updateMedication() {
        
    }
    
    func deleteMedication() {
        
    }
}

