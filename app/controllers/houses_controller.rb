# frozen_string_literal: true

class HousesController < ApplicationController
  include HousesHelper

  before_action :authenticate_user!, except: %i[index]
  before_action :set_house, only: %i[show edit update destroy]
  before_action :owner?, only: %i[edit update destroy]

  def index
    args = {}
    args[:rent] = {}
    args[:rent][:gte] = params[:rent_from] if params[:rent_from].present?
    args[:rent][:lte] = params[:rent_to]   if params[:rent_to].present?

    price_ranges = [{ to: 500 }, { from: 500, to: 1000 }, { from: 1000 }]
    @houses = House.search '*', where: args, aggs: { rent: { ranges: price_ranges } }
  end

  def show; end

  def new
    @house = House.new
  end

  def edit; end

  def create
    @house = House.new house_params
    @house.user = current_user

    if @house.save
      flash.now[:success] = 'The house was created successfully'
      redirect_to @house
    else
      flash.now[:error] = @house.errors.full_messages.join("\n")
      render :new
    end
  end

  def update
    if @house.update house_params
      flash.now[:success] = 'The house was updated successfully'
      redirect_to @house
    else
      flash.now[:error] = @house.errors.full_messages.join("\n")
      render :edit
    end
  end

  def destroy
    if @house.destroy
      flash.now[:success] = 'The house was deleted successfully'
      redirect_to houses_path
    else
      flash.now[:error] = @house.errors.full_messages.join("\n")
      redirect_to @house
    end
  end

  private

  helper_method :owner?

  def set_house
    @house = House.find params[:id]
  end

  def house_params
    params.require(:house).permit :rent, :deposit, :preferred_gender,
                                  :available_at,
                                  :description,
                                  :built_in,
                                  :lease_length,
                                  address_attributes: %i[address_1 address_2
                                                         city state
                                                         zip_code],
                                  checkbox_attributes: %i[air_conditioning
                                                          balcony furnished
                                                          include_utility
                                                          pets_allowed
                                                          private_bathroom
                                                          private_bedroom
                                                          refrigerator
                                                          near_bus_line
                                                          smoke_allowed]
  end
end
