class StoriesController < ApplicationController

  # let's add the index page
  def index
    @username = "rik"

    # get the stories out of the database
    # order by most voted then if same, latest first
    # @stories = Story.order("votes_count desc, created_at desc")

    # if the URL has extra params, mainly sort equals recent
    # then order by created_at desc
    # if the filter = featured then just get the 
    # is_featured true stories
    # else do the usual stuff
    if params[:sort] == "recent"
      # sort by most recent
      @stories = Story.order("created_at desc")

    elsif params[:filter] == "featured"
      # just get the featured ones
      @stories = Story.where(is_featured: true).order("title asc")
    else
      # sort by most voted
      @stories = Story.order("votes_count desc, created_at desc")
    end
  end

  # show me an individual story page
  def show
    # params[#id] is form the URL, e.g if /stories/7
    # then params[:id] is 7
    @story = Story.find(params[:id])
  end

  def new
    @story = Story.new
  end

  #  new and create work together as a pair
  #  the create action actually adds things to the database
  def create
    # make story be a blank story but with fields filled in
    @story = Story.new(story_params)

    # save this story to the database IF validations pass
    if @story.save
      #  let's add a notification to the user to let them know
      # it's been saved to the db
      flash[:success] = "Yay, you've submitted a story"
      # make this go back to the homepage
      redirect_to root_path
    else
      render 'new'
    end
  end

  #  I want to show the edit form for an individual story
  def edit
    #  find the story based on the url
    @story = Story.find(params[:id])
  end

  # I want to update the database with the updated data
  def update
    @story = Story.find(params[:id])

    # update the record with the form data
    if @story.update(story_params)
      flash[:success] = "You've updated a story"
      redirect_to story_path(@story)
    else
      render 'edit'
    end
  end

  # let's destroy this story
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    flash[:success] = "You've deleted the #{@story.title} story"
    redirect_to root_path
  end

  # I want to get the right data from the form
  def story_params
    # only get the title, description and link from the story params
    params.require(:story).permit(:title, :description, :link)
  end
end
