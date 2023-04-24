# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Hospital.destroy_all
Doctor.destroy_all
Patient.destroy_all
DoctorPatient.destroy_all

@hospital_1 = Hospital.create!(name: "Saint Joseph Hospital")

@doctor_1 = Doctor.create!(name: "Shaun Murphy", specialty: "General Surgeon", university: "University of Colorado Anschutz Medical Campus", hospital: @hospital_1)
@doctor_2 = Doctor.create!(name: "Meredith Grey", specialty: "Women's Health", university: "Harvard Medical School", hospital: @hospital_1)

@patient_1 = Patient.create!(name: "Christopher Byun", age: 31)
@patient_2 = Patient.create!(name: "Scott Le", age: 32)
@patient_3 = Patient.create!(name: "Megan Hinricher", age: 30)
@patient_4 = Patient.create!(name: "Marina Chhay", age: 29)

DoctorPatient.create!(doctor: @doctor_1, patient: @patient_1)
DoctorPatient.create!(doctor: @doctor_1, patient: @patient_2)
DoctorPatient.create!(doctor: @doctor_1, patient: @patient_3)
DoctorPatient.create!(doctor: @doctor_2, patient: @patient_3)
DoctorPatient.create!(doctor: @doctor_2, patient: @patient_4)