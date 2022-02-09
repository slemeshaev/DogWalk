//
//  DogWalkController.swift
//  DogWalk
//
//  Created by Stanislav Lemeshaev on 08.02.2022.
//  Copyright © 2022 slemeshaev. All rights reserved.
//

import UIKit

class DogWalkController: UIViewController {
    
    private let identifier = "Cell"
    
    // MARK: - IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    private var walks: [Date] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - IBActions
    @IBAction func addWalk(_ sender: UIBarButtonItem) {
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
