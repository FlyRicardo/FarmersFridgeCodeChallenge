//
//  StemmingViewController.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 4/04/24.
//

import UIKit

// fui a recoger a mi esposa, no me tardo. dejo abierta la llamada.

class StemmingViewController: UIViewController {
    
    // MARK: - Input UI elements

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    // MARK: - Output UI elements
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - State variables
    
    fileprivate var viewModel = StemmingViewModel()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBinding()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func touchUpSteaStemButton(_ sender: UIButton) {
        if let inputString = inputTextView.text { 
            viewModel.stem(inputString)
        }
    }
    
    @IBAction func touchUpClearButton(_ sender: UIButton) {
        inputTextView.text = ""
        viewModel.clearHistory()
    }
    
}

private extension StemmingViewController {
    func configureBinding() {
        viewModel.onListDidChange = {[weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Table data source
extension StemmingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stemWordsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: StemmingTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? StemmingTableViewCell
        else {
            fatalError("Unable to Dequeue Stemming Table View Cell")
        }

        if let viewModel = viewModel.viewModel(for: indexPath.row) {
            cell.configure(with: viewModel)
        }

        return cell
    }
}
