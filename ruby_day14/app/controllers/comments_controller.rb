class CommentsController < ApplicationController
  def create
    comment = Comment.new
    comment.content = params[:content]
    comment.post_id = params[:id] # 게시글의 id
    comment.save
    
    redirect_to :back
  end

  def destroy
    comment = Comment.find(params[:id]) # 여기서 id는 댓글의 id
    comment.destroy
    
    redirect_to :back
  end
end
