
import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tvLinkedin: UILabel!
    @IBOutlet weak var ivProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ivProfile.makeCircle()
       
        let urlTapped = UITapGestureRecognizer(target: self, action: #selector(onUrlTapped))
        tvLinkedin.isUserInteractionEnabled = true
        tvLinkedin.addGestureRecognizer(urlTapped)
    }
    
    @objc func onUrlTapped() {
        let urlLinkedin = "https://www.linkedin.com/in/rrdhoi"
          if let url = URL(string: urlLinkedin), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
          }
    }

}
