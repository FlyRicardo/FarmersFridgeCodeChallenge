//
//  StemmingViewController.swift
//  FarmersFridgeCodeChallenge
//
//  Created by Fabian  Rodriguez on 4/04/24.
//

import UIKit

class StemmingViewController: UIViewController {
    
    // MARK: - Input UI elements

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var stemmingButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    // MARK: - Output UI elements
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - State variables

    var viewModel: StemmingViewModel = .init() {
        didSet {
            /// TODO Notify change to view <Observer>
            updateView()
        }
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        let words = inputTextView.text.split(separator: " ").map { String($0) }
        viewModel.stem(words)
    }
}

extension StemmingViewController {
    private func  updateView() {
//        tableView.refreshControl?.endRefreshing()

        if viewModel.stemWordsData.isEmpty {
            tableView.reloadData()
        }
    }
}

// MARK: - Process input methods

extension StemmingViewController {

}

// MARK: - Table data source
extension StemmingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSteamWords
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StemmingTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? StemmingTableViewCell else {
            fatalError("Unable to Dequeue Stemming Table View Cell")
        }

        cell.configure(
            with: viewModel.viewModel(for: indexPath.row)
        )

        return cell
    }
}
