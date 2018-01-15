module ReviewVotesHelper

  def review_vote(user_review_vote, review)
    if !user_review_vote
      link_1 =  link_to fa_icon('chevron-up 1x'),
          review_review_votes_path(review, { is_up: true }),
          method: :post
       link_2 = link_to fa_icon('chevron-down 1x'),
          review_review_votes_path(review, { is_up: true }),
          method: :post

    elsif user_review_vote.is_up?
       link_1 = link_to fa_icon('chevron-circle-up 1x'),
        review_vote_path(user_review_vote),
        method: :delete
       link_2 = link_to fa_icon('chevron-down 1x'),
        review_vote_path(user_review_vote, { is_up: false}),
        method: :patch
    else
       link_1 = link_to fa_icon('chevron-up 1x'),
        review_vote_path(user_review_vote, { is_up: true }),
        method: :patch
       link_2 = link_to fa_icon('chevron-circle-down 1x'),
        review_vote_path(user_review_vote),
        method: :delete
    end
     "#{link_1} (#{review.review_votes_result}) #{link_2}"
  end
end
