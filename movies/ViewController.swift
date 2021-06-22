//
//  ViewController.swift
//  movies
//
//  Created by BS-236 on 21/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    var dataList = [Result]()
    
    
    @IBOutlet weak var tview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tview.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel")!)) {
            
            
            (data, req, error) in
            
            do {
                let movieResult = try JSONDecoder().decode(Movie.self, from: data!)
                
                DispatchQueue.main.async {
                    self.dataList = movieResult.results
                    self.tview.reloadData()
                }
            } catch {
                
            }
        }.resume()
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let label = UILabel(frame: CGRect(x: 30, y: 5, width: header.frame.size.width - 15, height: header.frame.size.height - 10))
        
        header.addSubview(label)
        label.text = "Movie List"
        
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieViewCell
        
        cell.onBind(data: dataList[indexPath.row])
        
        return cell
    }
    
    
}

