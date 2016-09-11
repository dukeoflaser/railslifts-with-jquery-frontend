module ApplicationHelper

  def creating_new_(x)
    actions = ['new', 'create', 'edit', 'update']

    if params[:controller] == "#{x}s"
      actions.include? params[:action]
    else
      false
    end
    
  end

end
