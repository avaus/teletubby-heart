module ApplicationHelper
  def t(word)
    I18n.t word
  end

  def absolute_asset_path(resource)
    "#{request.protocol}#{request.host_with_port}#{asset_path resource}"
  end

  include ActionView::Helpers::TagHelper
end
