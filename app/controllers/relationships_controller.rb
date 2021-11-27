class RelationshipsController < ApplicationController
  def create
    following = current_user.relationships.build(followed_id: params[:user_id])
    following.save
    redirect_to request.referrer || root_path
  end
  
  def destroy
    following = current_user.relationships.find_by(followed_id: params[:user_id])
    following.destroy
    redirect_to request.referrer || root_path
  end
  
end
