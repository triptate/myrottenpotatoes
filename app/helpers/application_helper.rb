module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    alt_direction = direction == "asc" ? "up" : "down"
    title << ( column == sort_column ? " <i class='fa fa-caret-#{alt_direction}'></i>" : "" )
    link_to title.html_safe, {:sort => column, :direction => direction}, :class => css_class
  end
end
