//
//  ViewController.swift
//  movies
//
//  Created by BS-236 on 21/6/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!

    
    var movies = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
                
            URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel")!)) {
                
                
                (data, req, error) in
                
                do {
                    let movieResult = try JSONDecoder().decode(Movie.self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.movies = movieResult.results
                        self.tableView.reloadData()
                    }
                } catch {
                    
                }
            }.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
                
        cell.onBind(data: movies[indexPath.row])
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let label = UILabel(frame: CGRect(x: 30, y: 5, width: header.frame.size.width - 15, height: header.frame.size.height - 10))
        
        header.addSubview(label)
        label.text = "Movie List"
        
        
        return header
    }
    
    
    
    


}

