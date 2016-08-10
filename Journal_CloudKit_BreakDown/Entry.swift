//
//  Entry.swift
//  Journal_CloudKit_BreakDown
//
//  Created by Diego Aguirre on 8/7/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

struct Entry {
    
   
    
    var date: NSDate
    var title: String
    var body: String
}

protocol EntryDelegate
{
    func errorUpdating(error: NSError)
    func modelUpdated()
}