class UsersController < ApplicationController

  def index
    @users = Snippet.find(:all).collect { |s| s.user }.sort.uniq  # suboptimal!

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def show
    @user = params[:id]
    @snippets = Snippet.find_all_by_user(@user, :order => 'created_at DESC')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @snippets }
    end
  end

end
