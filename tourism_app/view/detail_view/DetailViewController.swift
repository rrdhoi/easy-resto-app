import Foundation
import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var ivDetail: UIImageView!
    @IBOutlet weak var ivLike: UIImageView!
    
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvRating: UILabel!
    @IBOutlet weak var tvDescription: UILabel!
    
    var restaurant: RestaurantModel? = nil
    var isLiked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let result = restaurant {
             tvTitle.text = result.name
             tvRating.text = String(result.rating)
             tvDescription.text = result.description
                self.title = result.name
        
            let url = URL(string: "\(AppConstants.baseImageMediumUrl)\(String(describing: restaurant!.pictureId))")
            UIImage.loadFrom(url: url!) { image in
                self.ivDetail.image = image
                self.ivDetail.makeRounded()
            }
           }
        
        let ivLikeTap = UITapGestureRecognizer(target: self, action: #selector(onLikeTapped))
        ivLike.isUserInteractionEnabled = true
        ivLike.addGestureRecognizer(ivLikeTap)
    }
    
    @objc func onLikeTapped() {
        self.isLiked = !self.isLiked
        
        ivLike.image = UIImage(named: self.isLiked ? "Heart" : "Heart-1")
     }
}
