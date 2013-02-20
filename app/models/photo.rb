class Photo < ActiveRecord::Base
  include Authority::Abilities

  attr_accessible :file, :state, :state_changed_at, :is_main

  belongs_to :item
  has_one :admin_comment, as: :bannable
  mount_uploader :file, PhotoUploader

  self.authorizer_name = 'PhotosAuthorizer'

  state_machine :state, :initial => :active do
    after_transition :on => :allow, :do => :set_state_change_date_time
    after_transition :on => :ban, :do => :set_state_change_date_time

    event :archivate do
      transition :active => :archived
    end

    event :ban do
      transition :active => :banned
    end

    event :allow do
      transition :banned => :active
    end
  end

  scope :active, lambda { where("state <> ?", :archived) }

  def set_state_change_date_time
    @state_changed_at = Time.new
  end
end
