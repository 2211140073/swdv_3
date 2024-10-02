class TweetsController < ApplicationController
  def index
    @tweets=Tweet.all
  end
  def new
    @tweet=Tweet.new
  end
  def create
    if params[:tweet][:image].present?
      img=image:params[:tweet][:image].read
    else
      img= nil
    end
    @tweet=Tweet.new(message:params[:tweet][:message],tdate:params[:tweet][:tdate],image:img)
    if @tweet.save
      flash[:notice] = "投稿しました。"
      redirect_to '/'
    else
      render 'new',status: :unprocessable_entity
    end
  end
  def destroy
    tweet=Tweet.find(params[:id])
    tweet.destroy
    redirect_to '/'
  end
  def show
    @tweet = Tweet.find(params[:id])
  end
  def edit
    @tweet=Tweet.find(params[:id])
  end
  def update
    @tweet=Tweet.find(params[:id])
    if params[:tweet][:image].present?
      img=image:params[:tweet][:image].read
    else
      img= nil
    end
    if @tweet.update(message:params[:tweet][:message],image:img)
      flash[:notice] = "編集しました。"
      redirect_to '/'
    else
      flash[:notice] = "投稿しました。"
    end
  end
  def get_image
    tweet=Tweet.find(params[:id])
    send_data tweet.image, disposition: :inline, type: 'image/png'
  end
end