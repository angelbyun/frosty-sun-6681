require 'rails_helper'

RSpec.describe 'doctors show page' do
  let!(:hospital_1) { Hospital.create!(name: "Saint Joseph Hospital")}
  
  let!(:doctor_1) { Doctor.create!(name: "Shaun Murphy", specialty: "General Surgeon", university: "University of Colorado Anschutz Medical Campus", hospital: hospital_1) }
  let!(:doctor_2) { Doctor.create!(name: "Meredith Grey", specialty: "Women's Health", university: "Harvard Medical School", hospital: hospital_1) }

  let!(:patient_1) { Patient.create!(name: "Christopher Byun", age: 31) }
  let!(:patient_2) { Patient.create!(name: "Scott Le", age: 32) }
  let!(:patient_3) { Patient.create!(name: "Megan Hinricher", age: 30) }
  let!(:patient_4) { Patient.create!(name: "Marina Chhay", age: 29) }

  before do
    DoctorPatient.create!(doctor: doctor_1, patient: patient_1)
    DoctorPatient.create!(doctor: doctor_1, patient: patient_2)
    DoctorPatient.create!(doctor: doctor_1, patient: patient_3)
    DoctorPatient.create!(doctor: doctor_2, patient: patient_3)
    DoctorPatient.create!(doctor: doctor_2, patient: patient_4)
  end

  describe 'As a visitor when I visit the doctors show page' do
    it 'displays doctors info including name, specialty, and university' do
      visit "/doctors/#{doctor_1.id}"

      expect(page).to have_content(doctor_1.name)
      expect(page).to have_content(doctor_1.specialty)
      expect(page).to have_content(doctor_1.university)
      expect(page).to_not have_content(doctor_2.name)
      expect(page).to_not have_content(doctor_2.specialty)
      expect(page).to_not have_content(doctor_2.university)
    end

    it 'displays the name of the hospital a doctor works at' do
      visit "/doctors/#{doctor_1.id}"
      
      expect(page).to have_content(hospital_1.name)
    end

    it 'displays the names of all the patients a doctor has' do
      visit "/doctors/#{doctor_1.id}"

      expect(page).to have_content(patient_1.name)
      expect(page).to have_content(patient_2.name)
      expect(page).to have_content(patient_3.name)
      expect(page).to_not have_content(patient_4.name)
    end

    it 'displays a remove button next to patient names to remove patients from doctors caseload' do
      visit "/doctors/#{doctor_1.id}"

      within "#patient-#{patient_1.id}" do
        click_button("Remove Patient")
      end
      
      expect(current_path).to eq("/doctors/#{doctor_1.id}")
      expect(page).to_not have_content(patient_1.id)

      within "#patient-#{patient_2.id}" do
        click_button("Remove Patient")
      end
      
      expect(current_path).to eq("/doctors/#{doctor_1.id}")
      expect(page).to_not have_content(patient_2.id)

      within "#patient-#{patient_3.id}" do
        click_button("Remove Patient")
      end
      
      expect(current_path).to eq("/doctors/#{doctor_1.id}")
      expect(page).to_not have_content(patient_3.id)
    end

    it 'should still display deleted patient from doctor_1 on doctor_2 show page' do
      visit "/doctors/#{doctor_2.id}"

      expect(page).to have_content(patient_3.name)
    end
  end
end