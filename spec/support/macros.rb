def create_admin_user
  user = FactoryGirl.create(:user)
  user.roles = [::Refinery::Role[:refinery]]
  user.save
end
