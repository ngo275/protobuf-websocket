//
//  SocketIOViewController.swift
//  WS-Protobuf-Demo
//
//  Created by ShuichiNagao on 2019/05/23.
//  Copyright © 2019 Shuichi Nagao. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let manager = SocketManager(socketURL: URL(string: "http://localhost:8080/")!, config: [.log(true), .compress])
    var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let socket = manager.defaultSocket
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("from_server") {data, ack in
            guard let date = data[0] as? String else { return }
            print(date)
        }
        socket.connect()
    }
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension SocketIOViewController: UITableViewDelegate {
    
}

extension SocketIOViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
