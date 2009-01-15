class UsersController < ApplicationController

  def show
    @user = params[:id]
    @snippets = Snippet.find_all_by_user(@user, :order => 'created_at DESC')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @snippet }
    end
  end

end
