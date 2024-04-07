//
//  StemWordsTableViewController.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 4/04/24.
//

import UIKit

class StemWordsHistoryTableViewController: UITableViewController {

    // MARK: - State variables
    fileprivate var viewModel = StemWordHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadstemWordHistory()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stemWordsData?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StemWordsHistoryTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? StemWordsHistoryTableViewCell else
        {
            fatalError("Unable to Dequeue Stemming Table View Cell")
        }
        
        if let viewModel = viewModel.viewModel(for: indexPath.row) {
            cell.configure(with: viewModel)
        }
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

private extension StemWordsHistoryTableViewController {
    func configureBinding() {
        viewModel.onListDidChange = {[weak self] in
            self?.tableView.reloadData()
        }
    }
}
