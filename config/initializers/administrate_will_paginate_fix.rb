# Monkey patching for fixing an issue with administrate when we have
# kaminari and willpaginate in the same app
if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        def per(value = nil)
          per_page(value)
        end

        def total_count
          count
        end
      end
    end
    module CollectionMethods
      alias num_pages total_pages
    end
  end
end
