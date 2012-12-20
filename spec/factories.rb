FactoryGirl.define do
	factory :user do
		name 										"Brandon Smith"
		email 									"brandon@yale.edu"
		password              	"foobar"
		password_confirmation 	"foobar"
	end
end