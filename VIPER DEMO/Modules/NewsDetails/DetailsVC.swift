//
//  DetailsNewsVC.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import UIKit
import WebKit

protocol DetailsViewProtocol: AnyObject{
    func getPlayerFeed(data:MatchModel)
}

class DetailsVC: UIViewController {
    @IBOutlet weak var teamB: UILabel!
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var presenter: DetailsViewPresenter?
    var playerArray: MatchModel?
    var newsUrl:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        presenter?.getPlayerApiData()

    }
    
    func configureTableView() {
    tableView.register(UINib(nibName: "playerTVC", bundle: nil), forCellReuseIdentifier: "playerTVC")
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorColor = .clear
    }
    
    @IBAction func bacBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
extension DetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArray?.teams[playerArray?.matchdetail.teamHome ?? ""]?.players.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "playerTVC") as? playerTVC {
            let players = playerArray?.teams[playerArray?.matchdetail.teamHome ?? ""]?.players
            let playerNames = players?.map { $0.value }
            for  index in indexPath {
                if playerNames?[index].iscaptain == true {
                    cell.playerNameLabel.text = (playerNames?[index].nameFull ?? "") + " (c)"
                } else if playerNames?[index].iskeeper == true {
                    cell.playerNameLabel.text = (playerNames?[index].nameFull ?? "") + " (Wk)"
                } else {
                    cell.playerNameLabel.text = playerNames?[index].nameFull
                }
                
            }
            let playersB = playerArray?.teams[playerArray?.matchdetail.teamAway ?? ""]?.players
            let playerNameB = playersB?.map { $0.value }
            for  index in indexPath {
                if playerNameB?[index].iscaptain == true {
                    cell.playerNameB.text = (playerNameB?[index].nameFull ?? "") + " (c)"
                } else if playerNames?[index].iskeeper == true {
                    cell.playerNameB.text = (playerNameB?[index].nameFull ?? "") + " (Wk)"
                } else {
                    cell.playerNameB.text = playerNameB?[index].nameFull
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let players = playerArray?.teams[playerArray?.matchdetail.teamHome ?? ""]?.players
        let playerNames = players?.map { $0.value }
        for index in indexPath {
            let alertController = UIAlertController(title: "Style", message: ("BATTING STYLE " + playerNames![index].batting.style.rawValue), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)

            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true)
            
        }
       
        
    }
    
}

extension DetailsVC: DetailsViewProtocol{
    func getPlayerFeed(data: MatchModel) {
        self.playerArray = data
        teamA.text = data.teams[data.matchdetail.teamHome]?.nameFull ?? ""
        teamB.text = data.teams[data.matchdetail.teamAway]?.nameFull ?? ""
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}
