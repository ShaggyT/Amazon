module VotesHelper

  def product_vote(user_vote, product)
    if !@user_vote
      link_1 = link_to fa_icon('chevron-up 1x'), product_votes_path(@product, { is_up: true }),
                             method: :post
      link_2 = link_to fa_icon('chevron-down 1x'), product_votes_path(@product, { is_up: false }),
                             method: :post
    elsif @user_vote.is_up?
      link_1 = link_to fa_icon('chevron-circle-up 1x'), vote_path(@user_vote), method: :delete
      link_2 = link_to fa_icon('chevron-down x'), vote_path(@user_vote, { is_up: false}), method: :patch
    else
      link_1 = link_to fa_icon('chevron-up x'), vote_path(@user_vote, { is_up: true }), method: :patch
      link_2 = link_to fa_icon('chevron-circle-down 1x'), vote_path(@user_vote), method: :delete
    end
     "#{link_1} (#{product.votes_result}) #{link_2}"
  end
end
