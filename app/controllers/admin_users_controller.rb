class AdminUsersController < ApplicationController

  layout 'admin'

  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end

  def list
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    # Instantiate a new object using form parameters
    @admin_user = AdminUser.new(params[:admin_user])
    # Save the object
    if @admin_user.save
      # If save succeeds, redirect to the list action
      flash[:notice] = "Admin User created."
      redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    # Find object using form parameters
    @admin_user = AdminUser.find(params[:id])
    # Update the object
    if @admin_user.update_attributes(params[:admin_user])
      # If update succeeds, redirect to the list action
      flash[:notice] = "Admin User updated."
      redirect_to(:action => 'list')
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    AdminUser.find(params[:id]).destroy
    flash[:notice] = "Admin User destroyed."
    redirect_to(:action => 'list')
  end

end
