//
//  AddSpeakerViewController.swift
//  CoreData
//
//  Created by Matthew Dias on 8/4/19.
//  Copyright © 2019 Matthew Dias. All rights reserved.
//

import UIKit


class AddSpeakerViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addTapped(_ sender: Any) {
        guard let name = nameField.text, !name.isEmpty else {
            let alert = UIAlertController(title: "Name can’t be empty", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let speaker = Speaker(context: DataStore.shared.managedObjectContext)
        speaker.name = name
        dismiss(animated: true, completion: nil)
        DataStore.shared.saveContext()
    }
}
