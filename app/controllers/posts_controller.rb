class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_current_user_owns_post, only: [:destroy, :edit, :update]

  # GET /posts
  # GET /posts.json
  def index
    
    if params[:my_feed]
      @friend_ids = current_user.friends.pluck(:id)
      @posts = Post.where("user_id IN (?) OR user_id = ?", @friend_ids, current_user.id).order(created_at: :desc)
    else
      @posts = Post.order(created_at: :desc)
    end

    @post = Post.new
    @friend_request = FriendRequest.new
    @comment = Comment.new
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body)
    end

    def current_user_owns_post?(post)
      current_user.id == post.user_id ? true : false
    end

    def ensure_current_user_owns_post
      unless current_user_owns_post?(@post)
        redirect_to authenticated_root_path, alert: "You can only manage your own posts!"
      end
    end
end
