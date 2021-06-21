//
//  MovieViewCell.swift
//  movies
//
//  Created by BS-236 on 21/6/21.
//

import UIKit

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func onBind(data: Result) {
        name.text = data.title
        overview.text = data.overview
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w342/\(data.posterPath)")!)) {
            
            
            (data, req, error) in
            
            do {
                var posterView = try data
                
                DispatchQueue.main.async {
                    self.poster.image = UIImage(data: posterView!)
                }
            } catch {
                
            }
        }.resume()
    }
    
}
