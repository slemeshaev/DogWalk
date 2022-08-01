//
//  DogWalkController.swift
//  DogWalk
//
//  Created by Stanislav Lemeshaev on 08.02.2022.
//  Copyright © 2022 slemeshaev. All rights reserved.
//

import UIKit
import CoreData

class DogWalkController: UIViewController {
    private let identifier = "Cell"
    
    // MARK: - Properties
    @IBOutlet private var tableView: UITableView!
    
    private var currentDog: Dog?
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    private lazy var coreDataStack = CoreDataStack(modelName: "DogWalk")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - IBActions
    @IBAction private func addWalk(_ sender: UIBarButtonItem) {
        let walk = Walk(context: coreDataStack.managedContext)
        walk.date = Date()
        
        currentDog?.addToWalks(walk)
        coreDataStack.saveContext()
        
        tableView.reloadData()
    }
    
    // MARK: - Private
    private func configureUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        let dogName = "Fido"
        let dogFetch: NSFetchRequest<Dog> = Dog.fetchRequest()
        dogFetch.predicate = NSPredicate(format: "%K == %@", #keyPath(Dog.name), dogName)
        
        do {
            let results = try coreDataStack.managedContext.fetch(dogFetch)
            
            if results.count > 0 {
                currentDog = results.first
            } else {
                currentDog = Dog(context: coreDataStack.managedContext)
                currentDog?.name = dogName
                coreDataStack.saveContext()
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
}

// MARK: - UITableViewDataSource
extension DogWalkController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDog?.walks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        guard let walk = currentDog?.walks?[indexPath.row] as? Walk,
              let walkDate = walk.date as Date? else {
            return cell
        }
        
        cell.textLabel?.text = dateFormatter.string(from: walkDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Time of walks"
    }
}
