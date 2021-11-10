//
//  Medication+Convenience.swift
//  MedicationManager
//
//  Created by Jonathan Llewellyn on 11/10/21.
//

import CoreData

extension Medication {
    @discardableResult convenience init(name: String, timeOfDay: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.timeOfDay = timeOfDay
    }
}
