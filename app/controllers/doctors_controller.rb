class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
    @hospitals = Hospital.all
  end
end