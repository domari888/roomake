ActiveAdmin.register Tag do
  permit_params :name
  config.sort_order = 'id_asc'

  filter :name
end
