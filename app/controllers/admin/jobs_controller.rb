class Admin::JobsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

    def index
        @job = Job.all

    def new
        @job = Job.new
    end

    def show
        @job = Job.find(params[:id])
    end

    def edit
        @job = Job.edit(params[:id])
    end

    def create
        @job = Job.new(job_params)
        if @job.save
            redirect_to admin_job_path
        else
            render :new
        end
    end

    def update
        @job = Job.find(params[:id])
        if @job.update(job_params)
            redirect_to admin_job_path, notice: "Update success"
        else
            render :edit
        end
    end

    def destroy
        @job = Job.find(params[:id])
        @job.destroy
        redirect_to admin_job_path, alert: "Job deleted"
    end

    private

    def job_params
        params.require(:job).permit(:title, :description)
    end
end
