import UIKit

class ViewController: UIViewController {

    let nManager = NetworkManager()
    var ansers = [whatContainsResponce]()
    
    var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setTableView()
        nManager.getNews(count: "3") { ansers in
            self.ansers = ansers
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        //без строки ниже коннстрэинты не работали бы
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //а без этой extension бы не работал
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ansers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let answer = ansers[indexPath.row]  // Access the data model
        
        // Update the cell's textLabel with the appropriate data
        cell.textLabel?.text = answer.first ?? "No Name"  // Safely unwrap the optional
        
        return cell
    }
}

