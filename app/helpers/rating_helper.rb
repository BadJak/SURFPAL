module RatingHelper

  def big_stars(score)
    i_full = content_tag(:i, "", class: "fas fa-star")
    h2_full = content_tag(:h2, i_full, class: "inline-stars-big")
    i_empty = content_tag(:i, "", class: "far fa-star")
    h2_empty = content_tag(:h2, i_empty, class: "inline-stars-big")
    content = []
    score.round.times do
      content << h2_full
    end
    (5 - score.round).times do
      content << h2_empty
    end
    content_tag(:div, safe_join(content), class: "inline-stars")
  end

  def small_stars(score)
  i_full = content_tag(:i, "", class: "fas fa-star")
  h2_full = content_tag(:h2, i_full, class: "inline-stars-small")
  i_empty = content_tag(:i, "", class: "far fa-star")
  h2_empty = content_tag(:h2, i_empty, class: "inline-stars-small")
  content = []
  score.round.times do
    content << h2_full
  end
  (5 - score.round).times do
    content << h2_empty
  end
  content_tag(:div, safe_join(content), class: "inline-stars")
  end

  def small_dots(score)
  i_full = content_tag(:i, "", class: "fas fa-circle")
  h2_full = content_tag(:h2, i_full, class: "inline-stars-small")
  i_empty = content_tag(:i, "", class: "far fa-circle")
  h2_empty = content_tag(:h2, i_empty, class: "inline-stars-small")
  content = []
  score.round.times do
    content << h2_full
  end
  (5 - score.round).times do
    content << h2_empty
  end
  content_tag(:div, safe_join(content), class: "inline-dots")
  end

  def big_dots(score)
  i_full = content_tag(:i, "", class: "fas fa-circle")
  h2_full = content_tag(:h2, i_full, class: "inline-stars-big")
  i_empty = content_tag(:i, "", class: "far fa-circle")
  h2_empty = content_tag(:h2, i_empty, class: "inline-stars-big")
  content = []
  score.round.times do
    content << h2_full
  end
  (5 - score.round).times do
    content << h2_empty
  end
  content_tag(:div, safe_join(content), class: "inline-dots")
  end
end
