
import Foundation
import UIKit

extension UIImageView {
    func makeCircle() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
    func makeRounded() {
        layer.masksToBounds = false
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
}

extension UIImage {
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
