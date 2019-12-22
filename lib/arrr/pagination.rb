require "arrr/pagination/version"

module Arrr
  class Pagination
    Page = Struct.new(
      :page,
      :page_count,
      :previous_page,
      :next_page,
      keyword_init: true
    )
    PER_PAGE ||= 10
    def self.call(relation:, page: 0, per_page: PER_PAGE)
      page = page.to_i
      per_page = per_page.to_i
      offset = page * per_page
      array = relation.offset(offset).limit(per_page + 1).to_a
      row_count = relation.count
      page_count = (row_count / per_page.to_f).ceil
      has_previous_page = page.positive?
      has_next_page = array.size > per_page
      pagination = Page.new(
        page: page,
        page_count: page_count,
        previous_page: has_previous_page ? page - 1 : nil,
        next_page: has_next_page ? page + 1 : nil
      )
      array = array[0..-2] if has_next_page
      [array, pagination]
    end
  end
end
