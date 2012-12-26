Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "160018370802049", 
  					  "5797c386c50c1bf425057dd1a9506484", 
 				 	 :client_options => { :ssl => { :ca_file => "#{Rails.root}/config/ca-bundle.crt" } },
 				 	 :scope => 'email,user_birthday,read_stream,user_relationships,user_events', :display => 'popup'

  #provider :foursquare, "GVFAKYTFTKDMWWR5OFB2BPESX5OW04IQVP4VLCSZZND1EIS2", 
  #											"15234CPTI0Q2PA3T1I1XEAQ41XIMJHNWW4AVSC2T2C1VWEFZ",
  #				 :client_options => { :ssl => { :ca_file => "#{Rails.root}/config/ca-bundle.crt" } },
  #				 :display => 'popup'
end

