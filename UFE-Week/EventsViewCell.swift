//
//  EventsViewCell.swift
//  UFE-Week
//
//  Created by Kevin Chow on 1/30/16.
//  Copyright © 2016 Kevin Chow. All rights reserved.
//

import UIKit

class EventsViewCell: UITableViewCell {
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!

    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventDateAndTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
