//
//  TableViewCell.swift
//  movies
//
//  Created by BS-236 on 24/6/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onBind(data: Result) {
        movieName.text = data.title
        movieDesc.text = data.overview
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w342/\(data.posterPath)")!)) {
            
            
            (data, req, error) in
            
            do {
                var posterView = try data
                
                DispatchQueue.main.async {
                    self.moviePoster.image = UIImage(data: posterView!)
                }
            } catch {
                
            }
        }.resume()
    }

}
