class PagesController < ApplicationController

	layout 'admin'

	before_filter :confirm_logged_in
	before_filter :find_subject

	def index
		list
		render('list')
	end

	def list
		@pages = Page.sorted.where(:subject_id => @subject.id)
	end

	def show
		@page = Page.find(params[:id])
	end

	def new
		@page = Page.new(:subject_id => @subject.id)
		@page_count = @subject.pages.size + 1 # equal to Page.where(:subject_id => @subject.id).count + 1
		@subjects = Subject.all
	end

	def create
		new_position = params[:page].delete(:position)
		# Instantiate a new object using form parameters
		@page = Page.new(params[:page])
		# Save the object
		if @page.save
			@page.move_to_position(new_position)
			# If save succeeds, redirect to the list action
			flash[:notice] = "Page created."
			redirect_to(:action => 'list', :subject_id => @page.subject_id)
		else
			# If save fails, redisplay the form so user can fix problems
			@page_count = @subject.pages.size + 1
			@subjects = Subject.all
			render('new')
		end
	end

	def edit
		@page = Page.find(params[:id])
		@page_count = @subject.pages.size
		@subjects = Subject.all
	end

	def update
		# Find object using form parameters
		@page = Page.find(params[:id])
		# Update the object
		new_position = params[:page].delete(:position)
		if @page.update_attributes(params[:page])
			@page.move_to_position(new_position)
			# If update succeeds, redirect to the list action
			flash[:notice] = "Page updated."
			redirect_to(:action => 'show', :id => @page.id, :subject_id => @page.subject.id)
		else
			# If update fails, redisplay the form so user can fix problems
			@page_count = @subject.pages.size
			@subjects = Subject.all
			render('edit')
		end
	end

	def delete
		@page = Page.find(params[:id])
	end

	def destroy
		page = Page.find(params[:id])
		page.move_to_position(nil)
		page.destroy
		flash[:notice] = "Page destroyed."
		redirect_to(:action => 'list', :subject_id => @subject.id)
	end

	private

	def find_subject
		if params[:subject_id]
			@subject = Subject.find_by_id(params[:subject_id])
		end
	end

end
