class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    img = []
    img << 'https://images.unsplash.com/photo-1486890598084-3673ba1808c1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'
    img << 'https://images.unsplash.com/photo-1503293962593-47247718a17a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1049&q=80)'
    img << 'https://images.unsplash.com/photo-1527593625869-8f9b09712351?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80)'
    img << 'https://images.unsplash.com/photo-1484260001192-bfe826505222?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1189&q=80)'
    img << 'https://images.unsplash.com/photo-1470093384771-2d35ffe00073?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1052&q=80)'
    @banner_img = img.sample

    header = []
    header << "We recommend the best surf sessions for you."
    header << "We help surfers catch the best waves nearby."
    header << "Easy surf forecasting for pros and beginners."
    header << "We translate forecasts into simple surf sessions."
    @banner_header = header.sample
  end
end
