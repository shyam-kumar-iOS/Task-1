//
//  Info.swift
//  Tranxit Task
//
//  Created by Shyam Kumar on 10/10/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import Foundation
import CoreData

class Info : NSManagedObject {
    
    @NSManaged var amount : String
    @NSManaged var id : String
    @NSManaged var isCredit : Bool
    @NSManaged var storedNo : String
   
}
