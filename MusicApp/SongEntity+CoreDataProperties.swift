//
//  SongEntity+CoreDataProperties.swift
//  MusicApp
//
//  Created by Alexsander  on 3/15/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SongEntity {

    @NSManaged var author: String?
    @NSManaged var remoteID: NSNumber?
    @NSManaged var label: String?
    @NSManaged var version: NSNumber?

}
