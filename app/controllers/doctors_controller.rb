class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
    @hospitals = Hospital.all
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    patient = @doctor.patients.find_by_id(params[:id])
    if patient.nil?
      flash[:error] = "Patient not found"
    else
      doctor = Doctor.find(params[:id])
      doctor.patients.delete(patient)
      flash[:success] = "Patient has been removed from caseload"
    end
    redirect_to "/doctors/#{@doctor.id}"
  end
end