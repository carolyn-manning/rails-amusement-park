class Ride < ActiveRecord::Base
    belongs_to :attraction
    belongs_to :user

    validates :user_id, presence: true
    validates :attraction_id, presence: true

    def take_ride 
        if meets_all_requirements
            user.update(tickets: updated_tickets, happiness:updated_happiness, nausea:updated_nausea)
            "Thanks for riding the #{attraction.name}!"
        elsif !meets_height_requirement && !meets_ticket_requirement
            "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}." 
        elsif !meets_ticket_requirement
            "Sorry. You do not have enough tickets to ride the #{attraction.name}."
        elsif !meets_height_requirement
            "Sorry. You are not tall enough to ride the #{attraction.name}."  
        end    
    end 

    def meets_ticket_requirement
        user.tickets > attraction.tickets
    end 

    def meets_height_requirement
        user.height > attraction.min_height
    end 

    def meets_all_requirements
        meets_height_requirement && meets_ticket_requirement
    end 

    def updated_tickets
       user.tickets - attraction.tickets
    end 

    def updated_happiness
        user.happiness + attraction.happiness_rating
    end 

    def updated_nausea
        user.nausea + attraction.nausea_rating
    end 

end
