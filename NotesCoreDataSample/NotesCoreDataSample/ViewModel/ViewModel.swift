//
//  ViewModel.swift
//  NotesCoreDataSample
//
//  Created by rfsouto on 3/2/24.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject
{
    @Published var text = ""
    @Published var date = Date()
    @Published var show = false
    @Published var updateItem : Notes!
    
    func saveData(context: NSManagedObjectContext) {
        let newNote = Notes(context: context)
        newNote.text = text
        newNote.date = date
        do{
            try context.save()
            print("Saved")
            show.toggle()
        }catch let error as NSError{
            print("Not save", error.localizedDescription)
        }
    }
    
    func deleteData(item: Notes, context: NSManagedObjectContext) {
        context.delete(item)
        do{
            try context.save()
            print("Deleted")
        }catch let error as NSError{
            print("Not deleted", error.localizedDescription)
        }
    }
    
    func sendData(item: Notes) {
        updateItem = item
        text = item.text ?? ""
        date = item.date ?? Date()
        show.toggle()
    }
    
    func editData(context: NSManagedObjectContext){
        updateItem.text = text
        updateItem.date = date
        do{
            try context.save()
            print("Edited")
            show.toggle()
            updateItem = nil
        }catch let error as NSError{
            print("Not edited", error.localizedDescription)
        }
    }
}
