//
//  AddSessionViewController.swift
//  CoreData
//
//  Created by Matthew Dias on 8/4/19.
//  Copyright © 2019 Matthew Dias. All rights reserved.
//

import UIKit
import CoreData

class AddSessionViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var speakerField: UITextField!
    @IBOutlet weak var dateField: UITextField!

    let speakerPicker = UIPickerView()
    let datePicker = UIDatePicker()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    
    private var selectedSpeakerIndex: Int?
    private var selectedDate: Date? {
        didSet {
            guard let date = selectedDate else { return }
            dateField.text = dateFormatter.string(from: date)
        }
    }
    
    
    // MARK: make NSFetchedResultsController for Speaker
    private lazy var fetchedResultsController: NSFetchedResultsController<Speaker> = {
        let fetchRequest: NSFetchRequest<Speaker> = Speaker.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(keyPath: \Speaker.name, ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: DataStore.shared.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Error fetching speakers: \(nserror), \(nserror.userInfo)")
        }
        
        return fetchedResultsController
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        speakerPicker.dataSource = self
        speakerPicker.delegate = self
        speakerField.inputView = speakerPicker
    
        dateField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePicked(_:)), for: .primaryActionTriggered)
        datePicker.datePickerMode = .date
    }
    
    @IBAction func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        guard
            let title = titleField.text,
            !title.isEmpty,
            let speakerIndex = selectedSpeakerIndex,
            let speaker = fetchedResultsController.fetchedObjects?[speakerIndex],
            let date = selectedDate else {
                let alert = UIAlertController(title: "All Fields Required", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
        }
        
        // MARK: add session to Core Data
        let session = Session(context: DataStore.shared.managedObjectContext)
        session.title = title
        session.speaker = speaker
        session.date = date
        dismiss(animated: true, completion: nil)
        DataStore.shared.saveContext()
    }

}

extension AddSessionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

}

extension AddSessionViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fetchedResultsController.fetchedObjects?[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSpeakerIndex = row
        speakerField.text = fetchedResultsController.fetchedObjects?[row].name
    }
    
}


extension AddSessionViewController {
    @objc func datePicked(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
}
