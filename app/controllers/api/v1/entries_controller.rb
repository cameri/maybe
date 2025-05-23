class Api::V1::EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :update, :destroy]

  # GET /api/v1/entries
  def index
    if params[:account_id].present?
      @entries = Entry.where(account_id: params[:account_id])
    else
      @entries = Entry.all
    end
    render json: @entries
  end

  # POST /api/v1/entries
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      render json: @entry, status: :created
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/entries/:id
  def update
    if @entry.update(entry_params)
      render json: @entry
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/entries/:id
  def destroy
    @entry.destroy
    head :no_content
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:title, :content, :date)
  end
end
