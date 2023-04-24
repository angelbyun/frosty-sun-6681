require 'rails_helper'

RSpec.describe 'patient index page' do
  let!(:hospital_1) { Hospital.create!(name: "Saint Joseph Hospital")}
  
  let!(:doctor_1) { Doctor.create!(name: "Shaun Murphy", specialty: "General Surgeon", university: "University of Colorado Anschutz Medical Campus", hospital: hospital_1) }
  let!(:doctor_2) { Doctor.create!(name: "Meredith Grey", specialty: "Women's Health", university: "Harvard Medical School", hospital: hospital_1) }

  let!(:patient_1) { Patient.create!(name: "Christopher Byun", age: 31) }
  let!(:patient_2) { Patient.create!(name: "Scott Le", age: 32) }
  let!(:patient_3) { Patient.create!(name: "Megan Hinricher", age: 30) }
  let!(:patient_4) { Patient.create!(name: "Marina Chhay", age: 29) }
  let!(:patient_5) { Patient.create!(name: "Mason Shieh", age: 9) }

  before do
    DoctorPatient.create!(doctor: doctor_1, patient: patient_1)
    DoctorPatient.create!(doctor: doctor_1, patient: patient_2)
    DoctorPatient.create!(doctor: doctor_1, patient: patient_3)
    DoctorPatient.create!(doctor: doctor_1, patient: patient_5)
    DoctorPatient.create!(doctor: doctor_2, patient: patient_3)
    DoctorPatient.create!(doctor: doctor_2, patient: patient_4)
  end

  describe 'As a visitor when I visit the patient index page' do
    it 'displays all patients whos age is greater than 18' do
      visit "/patients"
save_and_open_page
      expect(page).to have_content(patient_1.name)
      expect(page).to have_content(patient_2.name)
      expect(page).to have_content(patient_3.name)
      expect(page).to have_content(patient_4.name)
      expect(page).to_not have_content(patient_5.name)
    end
  end
end