class Course < ApplicationRecord
    has_many :user_courses
    has_many :users, through: :user_courses 

    has_many :attendances

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :capacity, numericality: { only_integer: true, less_than: 9999, greater_than: 0}
    validates :military_start_time, presence: true 
    validates :duration, presence: true 
    validates :location, presence: true 

    validate :validate_user_count

    # scope :filter_by_teacher, -> (user_id) {joins(:users).where(user_id: user_id)}

    def validate_user_count
      errors.add(:users, " - The number of enrolled students is beyond course capacity") if get_users_count('student') > capacity
    end

    def get_users(role) 
        users.select{|user| user.role?(role)}.sort_by{|u| u.name}
    end 

    def get_user_ids(role) 
        get_users(role).map{|user| user.id}
    end 

    def get_users_count(role)
        get_users(role).count
    end 

    def weekly_schedule_attribute=(weekly_schedule_attribute)
        self.weekly_schedule = weekly_schedule_attribute.join('/') unless weekly_schedule_attribute.nil?
        self.save
    end 

    def start_time 
        military_start_time.strftime("%I:%M %p")
    end 

    def end_time 
        (military_start_time + duration * 60).strftime("%I:%M %p")
    end

    def time 
        "#{self.start_time} - #{self.end_time}"
    end 

    def scheduled_on?(day)
        !self.weekly_schedule.scan(day).empty? if self.weekly_schedule
    end 

    def role_list(role)
        self.get_users(role).collect{|user| user.name}.join(', ')
    end

    def self.sort_by_time(courses)
        courses.sort_by{|c| c.military_start_time}
    end

    def self.start_times
        self.distinct.pluck(:military_start_time).sort.collect do |time|
            time.strftime("%I:%M %p")
        end
    end 

    def self.locations 
        self.distinct.pluck(:location).sort
    end 

    def self.filter_by_schedule(courses, schedule)
        courses.select{|course| course.scheduled_on?(schedule)}
    end 

    def self.filter_by_time(courses, time)
        courses.select{|course| course.military_start_time.strftime("%I:%M %p") == time}
    end

    def self.filter_by_location(courses, location)
        courses.select{|course| course.location == location}
    end

    def self.filter_by_teacher(courses, teacher_id)
        courses.select{|course| course.user_ids.include?(teacher_id.to_i)}
    end

end
