class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients

  def self.alpha_patient_list_by_age
    Patient.where("age > 18").order(name: :asc).pluck(:name).to_sentence
  end
end
