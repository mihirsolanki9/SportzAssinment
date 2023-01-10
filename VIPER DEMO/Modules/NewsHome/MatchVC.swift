//
//  NewsVC.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import UIKit

protocol NewsViewProtocol: AnyObject{
    func getNewsFeed(data:MatchModel)
}

class MatchVC: UIViewController {
    @IBOutlet weak var squadsBtn: UIButton!
    @IBOutlet weak var venueLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    var presenter: NewsPresenter?
    @IBOutlet weak var timeLbl: UILabel!
    var newsFeedArray: Player?
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var matchNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getHomeApiData()
    }
    
    @IBAction func squad(_ sender: UIButton) {
        presenter?.redirectToDetails()
    }
    
}

extension MatchVC: NewsViewProtocol {
    func getNewsFeed(data: MatchModel) {
        print(data.teams[data.matchdetail.teamHome]?.players)
        dateLbl.text = "Date:- " + (data.matchdetail.match.date )
        venueLbl.text = data.matchdetail.venue.name
        timeLbl.text = "Time:- " + (data.matchdetail.match.time)
        let matchName = (data.teams[data.matchdetail.teamHome]?.nameFull ?? "") + " VS " + (data.teams[data.matchdetail.teamAway]?.nameFull ?? "")
        matchNameLbl.text = matchName
        
    }
}
