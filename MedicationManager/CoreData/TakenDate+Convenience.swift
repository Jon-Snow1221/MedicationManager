//
//  TakenDate+Convenience.swift
//  MedicationManager
//
//  Created by Jonathan Llewellyn on 11/10/21.
//

import Foundation
import CoreData

extension TakenDate {
    @discardableResult convenience init(date: Date, medication: Medication, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.date = date
        self.medication = medication
    }
}

