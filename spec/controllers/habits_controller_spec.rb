require 'rails_helper'

RSpec.describe HabitsController, type: :controller do

  describe "Create path" do
    describe "A valid post request" do
      let(:habit_params) {FactoryGirl.attributes_for :habit, :valid}
      let!(:post_habit) {post :create, habit: habit_params}
      it "redirects to habits index" do
        expect(response).to redirect_to(habits_path)
      end
    end
    describe "An invalid post request" do
      let(:invalid_habit_params) {FactoryGirl.attributes_for :habit, :invalid}
      let!(:post_invalid_habit) {post :create, habit: invalid_habit_params}
      it "returns HTTP resonse 200" do
        expect(response.status).to eq(200)
      end
      it "sets a flash alert" do
        expect(flash[:alert]).to include('ERROR:')
      end
    end
  end

  describe "Update path" do
    describe "A valid update" do
      let(:habit) {FactoryGirl.create(:habit,:valid)}
      let(:valid_update_attr) do
       {name: "Habitnew", start_date: "05-12-2016"}
      end
      let!(:update_valid_habit) do
        put :update, id: habit.id, habit: valid_update_attr
        habit.reload
      end
      it "redirects to the habits show page" do
        expect(response).to redirect_to(habit_path(habit))
      end
      it "sets a flash notice" do
        expect(flash[:notice]).to include('updated')
      end
    end

    describe "An invalid update" do
      let(:habit) {FactoryGirl.create(:habit,:valid)}
      let(:invalid_update_attr) do
       {name: "A", start_date: "05-12-2014"}
      end
      let!(:update_valid_habit) do
        put :update, id: habit.id, habit: invalid_update_attr
        habit.reload
      end
      it "returns HTTP resonse 200" do
        expect(response.status).to eq(200)
      end
      it 'sets a flash alert' do
        expect(flash[:alert]).to include('ERROR')
      end
    end
  end

  describe "Destroy path" do
    let(:habit) {FactoryGirl.create(:habit,:valid)}
    let!(:destroy_habit) {delete :destroy, id: habit.id}
    it "redirects to habits index" do
      expect(response).to redirect_to(habits_path)
    end
  end

end