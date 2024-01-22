import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvDescription: UILabel!
    @IBOutlet weak var imgRestaurant: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
