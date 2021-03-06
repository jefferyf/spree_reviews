class Spree::FeedbackReviewsController < Spree::BaseController
  helper Spree::BaseHelper

  def create
    params[:feedback_review][:rating].sub!(/\s*stars/,'') unless params[:feedback_review][:rating].blank?

    @review = Spree::Review.find_by_id(params[:review_id])
    if @review && @feedback_review = @review.feedback_reviews.new(params[:feedback_review])
      authorize! :create, @feedback_review
      @feedback_review.save
    end

    respond_to do |format|
      format.html { redirect_to :back  }
      format.js   { render :action => :create }
    end

  end
end

