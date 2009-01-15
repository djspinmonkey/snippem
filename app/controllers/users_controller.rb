class UsersController < ApplicationController

  def show
    @snippets = Snippet.find_all_by_user(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @snippet }
    end
  end

end
