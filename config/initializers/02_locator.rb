GlobalID::Locator.use :polls do |gid|
  gid.model_class.find_by(id: gid.model_id)
end
