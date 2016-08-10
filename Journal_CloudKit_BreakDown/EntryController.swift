//
//  EntryController.swift
//  Journal_CloudKit_BreakDown
//
//  Created by Diego Aguirre on 8/7/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

public let EntryControllerDidRefreshNotification = "EntryControllerDidRefreshNotification"

class EntryController {
    
    static var sharedController = EntryController()
    
    private let cloudKitManager = CloudKitManager()
    
    
    
    private(set) var entries: [Entry] = [] {
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
              let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(EntryControllerDidRefreshNotification, object: self)
            })
        }
    }
    
    init() {
        fetchEntries()
    }
    
    func addEntry(entry: Entry, completion: ((NSError?) -> Void)? = nil) {
        
        let record = entry.cloudKitRecord
        
        cloudKitManager.saveRecord(record) { (error) in
            defer { completion?(error) }
            
            if let error = error {
                print("Error saving \(entry) to cloudKit \(error.localizedDescription)")
                return
            }
            self.entries.insert(entry, atIndex: 0)
            print("message successfully appended to array")
            
        }
    }
    func fetchEntries(completion: ((NSError?) -> Void)? = nil) {
        let sortDescriptors = [NSSortDescriptor(key: Entry.dateKey, ascending: false)]
        
        cloudKitManager.fetchRecordsWithType(Entry.recordType, sortDescriptors: sortDescriptors) { (records, error) in
            defer { completion?(error) }
            if let error = error {
                print("Error Fetching Entries \(error.localizedDescription)")
                return
            }
            
            guard let records = records else { return }
            
            self.entries = records.flatMap{ Entry(cloudKitRecord: $0) }
            
            print("Successfully created Entry from CKRecords")
        }
    }
    
    func deleteEntry(completion: ((NSError?) -> Void)? = nil) {
        
    }
}