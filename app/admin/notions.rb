ActiveAdmin.register Notion do
  permit_params :title, :content  # 編集可能な属性を指定

  index do
    selectable_column
    id_column
    column :title
    column :content
    actions
  end

  filter :title

  form do |f|
    f.inputs "Notion Details" do
      f.input :title
      f.input :content
    end
    f.actions
  end
end
