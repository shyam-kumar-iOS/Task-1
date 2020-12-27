//
//  DetailViewController.swift
//  Tranxit Task
//
//  Created by Shyam Kumar on 10/10/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tblV: UITableView!
    
   var details = [Info]()
    
    let dB = DatabaseHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        details = dB.fetch(Info.self)
        print(details.map{$0.amount})
        
        tblV.register(InfoTableViewCell.nib, forCellReuseIdentifier: InfoTableViewCell.identifier)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as! InfoTableViewCell
        
        let currentDetails = details[indexPath.row]
        
        cell.transId.text = currentDetails.id
        cell.sentNo.text = currentDetails.storedNo
        cell.amountLbl.text = currentDetails.amount
        cell.isCredit.text = (currentDetails.isCredit) ? "Credit" : "Debit"
        cell.isCredit.backgroundColor = (currentDetails.isCredit) ? .green : .red
        cell.isCredit.textColor = (currentDetails.isCredit) ? .darkGray : .white
        cell.backgroundColor = .green
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
