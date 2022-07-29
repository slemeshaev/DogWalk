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
    // MARK: - Properties
    @IBOutlet private var tableView: UITableView!
    
    private let identifier = "Cell"
    
    private var walks: [Date] = []
    
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
        walks.append(Date())
        tableView.reloadData()
    }
    
    // MARK: - Private
    private func configureUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }
}

// MARK: - UITableViewDataSource
extension DogWalkController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let date = walks[indexPath.row]
        cell.textLabel?.text = dateFormatter.string(from: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Time of walks"
    }
}
