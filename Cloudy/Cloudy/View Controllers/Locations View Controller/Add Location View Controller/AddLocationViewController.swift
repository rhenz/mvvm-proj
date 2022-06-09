//
//  AddLocationViewController.swift
//  Cloudy
//
//

import UIKit
import Combine

protocol AddLocationViewControllerDelegate: AnyObject {
    func controller(_ controller: AddLocationViewController, didAddLocation location: Location)
}

class AddLocationViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    // MARK: -

    weak var delegate: AddLocationViewControllerDelegate?
    
    // MARK: -
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: -
    
    private var viewModel: AddLocationViewModel!
    
    // MARK: -
    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Title
        title = "Add Location"
        
        // Initialize View Model
        viewModel = AddLocationViewModel()
        
        // Subscribe to Locations Publisher
        viewModel.locationsPublisher
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
        
        // Subscribe to Querying
        viewModel.$querying
            .sink { [weak self] isQuerying in
                if isQuerying {
                    self?.activityIndicatorView.startAnimating()
                } else {
                    self?.activityIndicatorView.stopAnimating()
                }
            }.store(in: &subscriptions)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Show Keyboard
        searchBar.becomeFirstResponder()
    }
}

// MARK: - Table View Data Source

extension AddLocationViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLocations
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell else { fatalError("Unexpected Table View Cell") }


        // Create View Model
        if let viewModel = viewModel.viewModelForLocation(at: indexPath.item) {
            // Configure Table View Cell
            cell.configure(withViewModel: viewModel)
        }

        return cell
    }

}

// MARK: - Table View Delegate

extension AddLocationViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let location = viewModel.location(at: indexPath.row) else {
            return
        }

        // Notify Delegate
        delegate?.controller(self, didAddLocation: location)

        // Pop View Controller From Navigation Stack
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - Search Bar Delegate

extension AddLocationViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()

        // Forward Geocode Address String
        viewModel.query = searchBar.text ?? ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Update Query
        viewModel.query = searchText
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Update QUery
        viewModel.query = searchBar.text ?? ""
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()

        // Clear Locations
        viewModel.query = ""
    }

}
