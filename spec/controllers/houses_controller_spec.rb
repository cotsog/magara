# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HousesController do
  context 'when GET #index' do
    before { get :index }

    it { is_expected.to respond_with(:success) }

    # TODO: House.search("*") doesn't work because of that commented out that it
    xit 'assigns @houses' do
      create(:house)
      expect(assigns(:houses)).to eq(House.all)
    end
  end

  context 'when GET #show' do
    let(:user) { create :user }

    before do
      sign_in user

      house = build(:house)
      create(:address, house: house)
      create(:checkbox, house: house)

      get :show, params: { id: House.first.id }
    end

    it { is_expected.to respond_with(:success) }
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

      it { is_expected.to respond_with(:success) }
    end
  end

  context 'when POST #create' do
    context 'without user' do
      before do
        house = attributes_for(:house)

        post :create, params: {
          house: house,
          address_attributes: attributes_for(:address, house),
          checkbox_attributes: attributes_for(:checkbox, house)
        }
      end

      it { is_expected.to redirect_to new_user_session_path }
    end

    context 'with user' do
      let(:user) { create :user }

      before do
        sign_in user

        house = attributes_for(:house)

        post :create, params: {
          house: house,
          address_attributes: attributes_for(:address, house),
          checkbox_attributes: attributes_for(:checkbox, house)
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

      it { is_expected.to respond_with(:success) }
    end
  end

  context 'when PATCH/PUT #update'
  context 'when DELETE #destroy'
end
