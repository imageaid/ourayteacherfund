module TailwindHelper
  # Create a responsive grid. This is necessary in order to make every cell the same size (height & width)
  #
  # @example
  #   <%= responsive_grid(total_cells: 3, gap: 3, cols: { xs: 1, sm: 2, md: 3, lg: 4, xl: 5 }, "pt-4") do %>
  #     <% 3.times do %>
  #       <%= content_tag(:div, "Cell", class: "h-32 w-full bg-gray-200") %> <-- important to ensure the cell is the same size
  #         ...
  #       <% end %>
  #     <% end %>
  #   <% end %>
  #
  # @param total_cells [Integer] the total number of cells in the grid
  # @param gap [Integer] the gap between cells
  # @param cols [Hash] the number of cells in a row for each breakpoint
  # @option cols [Integer] :xs the number of cells in a row for the xs breakpoint
  # @option cols [Integer] :sm the number of cells in a row for the sm breakpoint
  # @option cols [Integer] :md the number of cells in a row for the md breakpoint
  # @option cols [Integer] :lg the number of cells in a row for the lg breakpoint
  # @option cols [Integer] :xl the number of cells in a row for the xl breakpoint
  # @param classes [String] additional classes to add to the grid
  # @return [String] the HTML for the grid
  def responsive_grid(total_cells: 3, gap: 3, cols: {}, classes: nil, &block)
    class_list = "grid gap-#{gap}"

    base_set = false

    %i[xs sm md lg xl].each do |size|
      if cols[size].present?
        if base_set
          class_list << " #{size}:grid-cols-#{cols[size]}"
          class_list << " #{size}:grid-rows-#{calculate_rows(cols[size], total_cells)}"
        else
          base_set = true
          class_list << " grid-cols-#{cols[size]}"
          class_list << " grid-rows-#{calculate_rows(cols[size], total_cells)}"
        end
      end
    end

    class_list << classes if classes

    tag.div(class: class_list) { block.call }
  end

  private

  # Calculate the total number of rows based on the number of cells and the size of the grid
  # @param size [Integer] the number of cells in a row
  # @param total_cells [Integer] the total number of cells
  # @return [Integer] the number of rows
  def calculate_rows(size, total_cells)
    (total_cells.to_f / size).ceil
  end
end
