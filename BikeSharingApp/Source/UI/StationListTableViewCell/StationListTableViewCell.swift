//
//  StationListTableViewCell.swift
//  BikeSharingApp
//
//  Created by Filipp Kosenko on 24.10.2023.
//

import UIKit

final class StationListTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: @IBOutlets
    
    @IBOutlet var stationNameLabel: UILabel?
    @IBOutlet var availableBikesTitle: UILabel?
    @IBOutlet var availableBikesValue: UILabel?
    @IBOutlet var emptySlotsTitle: UILabel?
    @IBOutlet var emptySlotsValue: UILabel?
    @IBOutlet var background: UIView?

    // MARK: -
    // MARK: Configure
    
    func configure(with model: Station) {
        self.stationNameLabel?.text = model.name
        self.availableBikesTitle?.text = "Available bikes"
        self.availableBikesValue?.text = model.freeBikes.description
        self.emptySlotsTitle?.text = "Empty slots"
        self.emptySlotsValue?.text = model.emptySlots?.description ?? "-"
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.background?.layer.cornerRadius = 15
    }
}
