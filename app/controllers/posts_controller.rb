class PostsController < ApplicationController
before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      #format.json  { render :json => @post }
      format.xml  { render :xml => @posts }
    end
  end
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created,
                    :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors,
                    :status => :unprocessable_entity }
      end
    end
  end

  def show
    #@post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
  def edit
    #@post = Post.find(params[:id])
  end

  def update
    #@post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(post_params)
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors,
                    :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    if @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.xml { head :no_content }
      end
    else
        format.html {render :action => "index"}
        format.xml {render :xml => @post.errors, :status => :unprocessable_entity}
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :title, :content)
    end
end
