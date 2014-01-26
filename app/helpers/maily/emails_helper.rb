module Maily
  module EmailsHelper
    def part_class(part)
      'format_selected' if (part == params[:part]) || (part == 'html' && !params[:part])
    end
  end
end
