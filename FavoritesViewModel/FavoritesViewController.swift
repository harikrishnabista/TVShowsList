//
//  FavoritesViewController.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/28/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        self.title = "Favorites"
        self.view.backgroundColor = UIColor.white
        super.viewDidLoad()
    }
    
    func setupTableView(){
        tableView.dataSource = self
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

