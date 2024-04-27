class Employee < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { manager: "manager", employee: "employee" }

  after_commit :create_initial_status

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  validates :company_id, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
  validates :time_zone, presence: true

  belongs_to :company
  belongs_to :manager, class_name: "Employee", foreign_key: :manager_id, optional: true
  has_many :timesheet_entries, class_name: "TimesheetEntry", foreign_key: :employee_id
  has_many :messages, foreign_key: :sender_id
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"
  has_one :status, foreign_key: :employee_id
  has_one :tmail_subscription, foreign_key: :employee_id

  scope :managers, -> { where(role: roles[:manager]) }

  def dashboard
    {
      first_name: full_name,
      company_name: company.name,
      profile_picture_url: profile_picture_url,
      time_zone: time_zone,
      role: role,
      manager: manager.present? ? manager.full_name : nil,
      current_timesheet: current_timesheet.map(&:attributes),
    }
  end

  def current_timesheet
    pp = PayPeriod.current
    pp ? timesheet_entries.where(pay_period_id: pp.id) : []
  end

  def total_hours_worked
    timesheet_entries.current.sum { |entry| entry.hours_worked || 0 }
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def clocked_in?
    timesheet_entries.current.exists?
  end

  def clock_in
    timesheet_entries.create(started_at: Time.now) unless clocked_in?
  end

  def clock_out
    last_entry.update(ended_at: Time.now) if clocked_in?
  end

  def last_entry
    timesheet_entries.last
  end

  def has_tmail?
    tmail_subscription.present?
  end

  private

  def create_initial_status
    Status.create(employee: self, text: "Available")
  end
end
