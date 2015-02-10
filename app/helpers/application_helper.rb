module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def bootstrap_class_for(type)
    mapping = {
      'info' => 'alert-info',
      'success' => 'alert-success',
      'notice' => 'alert-success',
      'error' => 'alert-danger',
      'alert' => 'alert-danger',
      'warning' => 'alert-warning'
    }
    return mapping[type] || mapping[type.to_s] || type.to_s
  end

  def text_truncate(text, limit=100)
    truncate(text, length: limit, separator: ' ')
  end

end
