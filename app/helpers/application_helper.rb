module ApplicationHelper
  def t(word)
    I18n.t word
  end

  include ActionView::Helpers::TagHelper
end
