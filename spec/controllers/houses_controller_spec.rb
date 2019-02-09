# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HousesController do
  context 'when GET #index' do
    before { get :index }

    it { is_expected.to render_template('index') }

    it 'assigns @houses' do
      create(:house)
      expect(assigns(:houses)).to eq(House.all)
    end
  end

  context 'when GET #show' do
    before do
      house = build(:house)
      create(:address, house: house)
      create(:checkbox, house: house)

      get :show, params: { id: House.first.id }
    end

    it { is_expected.to render_template('show') }
  end

  context 'when GET #new' do
    context 'without user' do
      before { get :new }

      it { is_expected.to redirect_to new_user_session_path }
    end

    context 'with user' do
      let(:user) { create :user }

      before do
        sign_in user
        get :new
      end

      it { is_expected.to render_template('new') }
    end
  end

  context 'when POST #create' do
    context 'without user' do
      before do
        house    = build(:house)
        address  = build(:address, house: house)
        checkbox = build(:checkbox, house: house)

        # BUG: It can save without address and checkbox attributes.
        post :create, params: {
          house: {
            rent: house.rent, deposit: house.deposit,
            preferred_gender: house.preferred_gender,
            available_at: house.available_at,
            address_attributes: {
              address_1: address.address_1, address_2: address.address_2,
              city: address.city, state: address.state, zip_code: address.zip_code
            },
            checkbox_attributes: {
              air_conditioning: checkbox.air_conditioning,
              balcony: checkbox.balcony, furnished: checkbox.furnished,
              include_utility: checkbox.include_utility,
              pets_allowed: checkbox.pets_allowed,
              private_bathroom: checkbox.private_bathroom,
              private_bedroom: checkbox.private_bedroom,
              refrigerator: checkbox.refrigerator,
              near_bus_line: checkbox.near_bus_line,
              smoke_allowed: checkbox.smoke_allowed
            }
          }
        }
      end

      it { is_expected.to redirect_to new_user_session_path }
    end

    context 'with user' do
      let(:user) { create :user }

      before do
        sign_in user

        house    = build(:house)
        address  = build(:address, house: house)
        checkbox = build(:checkbox, house: house)

        # BUG: It can save without address and checkbox attributes.
        post :create, params: {
          house: {
            rent: house.rent, deposit: house.deposit,
            preferred_gender: house.preferred_gender,
            available_at: house.available_at,
            address_attributes: {
              address_1: address.address_1, address_2: address.address_2,
              city: address.city, state: address.state,
              zip_code: address.zip_code
            },
            checkbox_attributes: {
              air_conditioning: checkbox.air_conditioning,
              balcony: checkbox.balcony, furnished: checkbox.furnished,
              include_utility: checkbox.include_utility,
              pets_allowed: checkbox.pets_allowed,
              private_bathroom: checkbox.private_bathroom,
              private_bedroom: checkbox.private_bedroom,
              refrigerator: checkbox.refrigerator,
              near_bus_line: checkbox.near_bus_line,
              smoke_allowed: checkbox.smoke_allowed
            }
          }
        }
      end

      it { is_expected.to redirect_to house_path(House.first.id) }
    end
  end

  context 'when GET #edit' do
    context 'without user' do
      before do
        house = create(:house)
        create(:address, house: house)
        create(:checkbox, house: house)

        get :edit, params: {
          id: house.id
        }
      end

      it { is_expected.to redirect_to new_user_session_path }
    end

    context 'with user' do
      let(:user) { create :user }

      before do
        sign_in user

        house = create(:house)
        create(:address, house: house)
        create(:checkbox, house: house)

        get :edit, params: {
          id: house.id
        }
      end

      it { is_expected.to render_template :edit }
    end
  end

  context 'when PATCH/PUT #update'
  context 'when DELETE #destroy'
end
