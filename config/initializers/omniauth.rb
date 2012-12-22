Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "160018370802049", 
  					  "5797c386c50c1bf425057dd1a9506484", 
 				 	  :client_options => { :ssl => { :ca_file => "#{Rails.root}/config/ca-bundle.crt" } },
 				 	  :scope => 'email,user_birthday,read_stream,user_relationships', :display => 'popup'
end

