//
//  HomeViewController.swift
//  Passions
//
//  Created by Simone Scionti on 04/04/2020.
//  Copyright © 2020 SSCode. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController, UITableCellTargettingObserver {
    
    var targetCell : IndexPath!
    var previousTargetCell : IndexPath!
    var api = APIWrapper()
    var tableItems = [HomeTableSection]()
    
    
    let model: [UIColor] = [UIColor.red, UIColor.blue , UIColor.green , UIColor.yellow]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        let dataRecent = api.getRecentContent()
        let dataForMe = api.getForMeCollections()
        let news = api.getNews()
        tableItems.append(HomeTableSection.init(name: "Novità", items: news))
        tableItems.append(HomeTableSection.init(name: "Per te", items: dataForMe))
        tableItems.append(HomeTableSection.init(name: "Contenuti recenti", items: dataRecent))
        tableView.reloadData()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        enableVideoPlayers()
    }
    
    func tableCell(cell: UITableViewCell, targetChanged toIndex: Int) {
        if let ip = tableView.indexPath(for: cell) {
            //save new target
            tableItems[ip.section].lastTargetIndices[ip.row] = toIndex
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarDesign()
        //enableVideoPlayers()
    }
    
    private func setupNavigationBarDesign(){
         navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func disableVideoPlayerOnCell(atIndexPath ip: IndexPath?){
        guard let index = ip else {return}
        let cell = tableView.cellForRow(at: index)
        if let c = cell as? CollectionContentTableViewCell{
            c.canPlayVideo(setTo: false)
        }
    }
    private func enableVideoPlayerOnCell(atIndexPath ip: IndexPath?){
        guard let index = ip else {return}
        let cell = tableView.cellForRow(at: index)
        if let c = cell as? CollectionContentTableViewCell{
            c.canPlayVideo(setTo: true)
        }
    }
  
    private func targetCellChanged(newTargetCell indexPath: IndexPath?, previousTargetCell prevIndexPath: IndexPath? ){
        disableVideoPlayerOnCell(atIndexPath: prevIndexPath)
        enableVideoPlayerOnCell(atIndexPath: indexPath)
    }
    
    private func updateTargetCell(indexPath: IndexPath?){
        if indexPath != targetCell{
            previousTargetCell = targetCell
            targetCell = indexPath
            targetCellChanged(newTargetCell: targetCell, previousTargetCell: previousTargetCell)
        }
    }
    
    private func getCurrentTargetIndexPath(fromScrollView scrollView: UIScrollView) -> IndexPath?{
        let visualCenterPoint = CGPoint(x:self.view.center.x, y: self.view.center.y + scrollView.contentOffset.y)
        let center = self.view.convert(visualCenterPoint, to: self.tableView)
        let index = tableView.indexPathForRow(at: center)
        return index
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrollView")
        let index = getCurrentTargetIndexPath(fromScrollView: scrollView)
        updateTargetCell(indexPath: index)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{ //NewsCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableViewCell") as! NewsTableViewCell
            cell.setCellContent(items: tableItems[indexPath.section].sectionItems as! [UIImage])
            return cell
        }
        else if indexPath.section == 1 { //CollectionCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "collectionTableViewCell") as! CollectionTableViewCell
             cell.setCellContent(items: tableItems[indexPath.section].sectionItems as! [Collection])
            return cell
        }
        else{ //CollectionContentCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "collectionContentTableViewCell") as! CollectionContentTableViewCell
            let tableItem = self.tableItems[indexPath.section]
            cell.setCellContent(collection: tableItem.sectionItems[indexPath.row] as! Collection, lastTargetCellIndex: tableItem.lastTargetIndices[indexPath.row], targetObserver: self, superViewController: self)
            return cell
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableItems.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return getSectionHeaderView(withText: tableItems[section].sectionName)
        }
        else if section == 1{
            return getSectionHeaderView(withText: tableItems[section].sectionName)
        }
        else{
            return getSectionHeaderView(withText: tableItems[section].sectionName)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1{ //for news and for you we have always one row
            return 1
        }
        return tableItems[section].sectionItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    private func getSectionHeaderView(withText text: String)-> UIView{
        let label = getSectionLabel(withText: text)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 70))
        view.addSubview(label)
        label.center = view.center
        return view
    }
    
    private func getSectionLabel(withText text: String) -> UILabel{
        let sectionTitleLabel = UILabel.init(frame: CGRect(x:0, y: 0, width: self.view.frame.size.width * 0.9, height: 70))
        sectionTitleLabel.text = text
        sectionTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        sectionTitleLabel.textColor = UIColor.white
        return sectionTitleLabel
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disableVideoPlayers()
    }
    private func disableVideoPlayers(){
        guard let target = targetCell else{return}
        if let cell = tableView.cellForRow(at: target) as? CollectionContentTableViewCell{
            cell.canPlayVideo(setTo: false)
        }
    }
    private func enableVideoPlayers(){
        guard let target = targetCell else{return}
        if let cell = tableView.cellForRow(at: target) as? CollectionContentTableViewCell{
            cell.canPlayVideo(setTo: true)
        }
    }
    
    
    

}
