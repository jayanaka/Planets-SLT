//
//  PlanetTableViewController.swift
//  Planets SLT
//
//  Created by Chathura Jayanaka on 11/14/21.
//

import UIKit
import Alamofire

class PlanetTableViewController: BaseTVC {

    var planetList: [Planet] = []
    var pageIndex = 1
    var fetchAllData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        
        loadPlanetData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadPlanetData() {
        if !(NetworkReachabilityManager()?.isReachable)! {
            self.showAlert(title: "Network error", message: "NO INTERNET", actionTitles: ["RETRY", "CANCEL"], actions: [{ action1 in
                   self.loadPlanetData()
               }, { action2 in
            }, nil])
            
        } else {
            
            let planetService = PlanetService()
            planetService.getPlanets(page: pageIndex, onSuccess: { (nextPage: String, results: [Planet]) -> Void in
                self.hideProgress()
                if (nextPage != nil && nextPage != "") {
                    self.pageIndex += 1
                    self.fetchAllData = false
                } else {
                    self.fetchAllData = true
                }
                self.tableView.stopLoading()
                self.planetList.append(contentsOf: results)
                self.tableView.reloadData()
                
            }, onResponseError: { (error: String, status: Int) -> Void in
                print(error)
                self.tableView.stopLoading()
                self.showMessage(isError: true, title: "Error", message: error)
                
            }, onError: { (error: String, code: Int) -> Void in
                print(error)
                self.tableView.stopLoading()
                self.showMessage(isError: true, title: "Error", message: error)
                
            })
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetList.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetTableViewCell", for: indexPath) as! PlanetTableViewCell
        let item = planetList[indexPath.row]
        cell.lblName?.text = item.name
        cell.lblClimate?.text = item.climate
        
        if let imageURL = try? "https://picsum.photos/id/\(indexPath.row)/60/60".asURL() {
            cell.ivImage.kf.setImage(with: imageURL)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = planetList.count - 1
        if (!fetchAllData && indexPath.row == lastItem) {
            tableView.startLoading()
            loadPlanetData()
        }
    }
    
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = planetList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "PlanetDetailViewController") as! PlanetDetailViewController
        detailViewController.planet = item
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
}
