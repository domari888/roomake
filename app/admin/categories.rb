ActiveAdmin.register Category do
  permit_params :name
  config.sort_order = 'id_asc'

  filter :name
end
