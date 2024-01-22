import UIKit

class ViewController: UIViewController{
   
    var dataRestaurants = [RestaurantModel]()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantsTableView.dataSource = self
        restaurantsTableView.delegate = self
        let uINibRestaurant = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        restaurantsTableView.register(uINibRestaurant, forCellReuseIdentifier: "RestaurantCell")
        
        fetchDataRestaurants { result in
            self.dataRestaurants = result
        
            DispatchQueue.main.sync {
                self.restaurantsTableView.reloadData()
            }
        }
    }
    
    @IBAction func onProfilePressed(_ sender: Any) {
        performSegue(withIdentifier: AppConstants.moveToProfile, sender: nil)
    }
    
    func fetchDataRestaurants(completion: @escaping ([RestaurantModel]) -> Void) {
        startIndicator()
        let url = URL(string: "\(AppConstants.baseUrl)/list")!
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            if data != nil && error == nil {
                do {
                    let decode = try JSONDecoder().decode(RestaurantResponse.self, from: data!)
                    completion(decode.restaurants)
                    self.stopIndicator()
                } catch {
                    print("error: \(error)")
                    self.stopIndicator()
                    self.errorMessage()
                }
            } else {
                self.stopIndicator()
                self.errorMessage()
            }
        }
        
        dataTask.resume()
    }
    
    func errorMessage()
    {
        let container: UIView = UIView()
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor =  UIColor(named: "WhiteColor")

        let loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 118, 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor(named: "RedColor")
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        let label = UILabel(frame: CGRectMake(0, 0, 118, 80))
        label.text = "Error..."
        label.textColor = UIColor.white
        label.bounds = CGRectMake(0, 0, loadingView.frame.size.width / 2, loadingView.frame.size.height / 2)
        label.font = UIFont.systemFont(ofSize: 14)
        loadingView.addSubview(label)
        container.addSubview(loadingView)
        self.view.addSubview(container)

        self.activityIndicator.startAnimating()
    }
    
    func startIndicator()
    {
        let container: UIView = UIView()
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor =  UIColor(named: "WhiteColor")

        let loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 118, 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor(named: "BlueColor")
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.frame = CGRectMake(40, 12, 40, 40)
        self.activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        loadingView.addSubview(activityIndicator)

        let label = UILabel(frame: CGRectMake(5, 55,120,20))
        label.text = "Loading..."
        label.textColor = UIColor.white
        label.bounds = CGRectMake(0, 0, loadingView.frame.size.width / 2, loadingView.frame.size.height / 2)
        label.font = UIFont.systemFont(ofSize: 12)
        loadingView.addSubview(label)
        container.addSubview(loadingView)
        self.view.addSubview(container)

        self.activityIndicator.startAnimating()
    }
    
    func stopIndicator()
    {
        UIApplication.shared.endIgnoringInteractionEvents()
            self.activityIndicator.stopAnimating()
        ((self.activityIndicator.superview as UIView?)?.superview as UIView?)?.removeFromSuperview()
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantTableViewCell {
            let restaurant = dataRestaurants[indexPath.row]
            let url = URL(string: "\(AppConstants.baseImageMediumUrl)\(String(describing: restaurant.pictureId))")
            
            UIImage.loadFrom(url: url!) { image in
                cell.imgRestaurant.image = image
            }
            
            cell.tvTitle.text = restaurant.name
            cell.tvDescription.text = String(describing: restaurant.rating)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate {
 
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
      performSegue(withIdentifier: AppConstants.moveToDetail, sender: self.dataRestaurants[indexPath.row])
  }

    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
      ) {
        if segue.identifier == AppConstants.moveToDetail {
          if let detaiViewController = segue.destination as? DetailViewController {
              detaiViewController.restaurant = sender as? RestaurantModel
          }
        }
      }
}


