class SearchController < ApplicationController
  def results
    @query = params['query']
    @search = Ultrasphinx::Search.new(
      :query => @query
    )
    @search.excerpt
    @search.results
  end
end
