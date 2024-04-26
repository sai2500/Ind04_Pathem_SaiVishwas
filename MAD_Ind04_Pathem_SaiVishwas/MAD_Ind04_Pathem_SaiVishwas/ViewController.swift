//
//  ViewController.swift
//  MAD_Ind04_Pathem_SaiVishwas
//
//  Created by Sai Vishwas Pathem on 4/19/24.
//



import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Presenting the Tableview to display states and its nicknames
    
    @IBOutlet weak var myView: UITableView!
    //The array is to store response from the provided GET API request
    var responseFromDB:[States] = []
    
    //Spinner used while loading data from database
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //The deleagte and datasource for the tableview
        myView.delegate = self
        myView.dataSource = self
        
        spinner.hidesWhenStopped = true
        spinner.startAnimating()

       
        fetchDataFromDatabase() // Calling the fuction

        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.responseFromDB.count
    }
    // The populating tableview with response returned by the API
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "myCell")
        cell.textLabel?.text = self.responseFromDB[indexPath.row].name
        cell.detailTextLabel?.text = self.responseFromDB[indexPath.row].nickname
        return cell
        
        
    }
    
    
    
    func fetchDataFromDatabase(){ //Fetching from the database
        let url = "https://cs.okstate.edu/~spathem/file.php"
        
        guard let url = URL(string: url) else {
            print("URL is Invalid")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Nothing data received yet")
                return
            }
            
            do {
                let states = try JSONDecoder().decode([States].self, from: data)
                DispatchQueue.main.async {
                    self.responseFromDB = states
                    self.spinner.stopAnimating()
                    self.myView.reloadData()
                }
            } catch {
                print("Error at decoding the JSON Data: \(error)")
            }
        }
        
        task.resume()
    }

    
}



struct States: Decodable {
    let name: String
    let nickname: String
    
}

struct Response: Decodable {
    var stateInfo: [States] // Expecting an array of States
}



