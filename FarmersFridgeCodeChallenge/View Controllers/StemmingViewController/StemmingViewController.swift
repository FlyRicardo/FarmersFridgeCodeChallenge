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

    var stemWords = [StemWord]()
    
    
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
        stem()
    }
}

// MARK: - Process input methods

extension StemmingViewController {
    func stem() {
        
    }
}

// MARK: - Table data source
extension StemmingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stemWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StemmingTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? StemmingTableViewCell else {
            fatalError("Unable to Dequeue Stemming Table View Cell")
        }
        
        cell.configure(
            with: stemWords[indexPath.row]
        )

        return cell
    }
}
