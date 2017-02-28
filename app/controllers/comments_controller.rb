class CommentsController < ApplicationController

	def index
    	@post = Post.find(params[:post_id])
    	@comments = @post.comments
	end

	def show
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
	end

	def new
		@post = Post.find(params[:post_id])
		@comment = Comment.new #Comment.new #@post.comments.new
		#@comment.Post.new

	end


	def create
	    @post = Post.find(params[:post_id])
	    #@comment = Comment.new(comment_params)
	    @comment = @post.comments.new(comment_params)
	    if @comment.save
	      redirect_to post_comments_url(@post, @comment)
	    else
	      render :action => "new"
	    end
	end

  	def edit
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id]) #@post.comments.find(params[:id]) #

		
	end

	def update
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
		  redirect_to post_comment_url(@post, @comment)
		else
		  render :action => "edit"
		end
  	end

  	def destroy
	    @post = Post.find(params[:post_id])
	    @comment = Comment.find(params[:id])
	    @comment.destroy

	    respond_to do |format|
	      format.html { redirect_to post_comments_path(@post) }
	      format.xml  { head :ok }
	    end
	end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
	# Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
