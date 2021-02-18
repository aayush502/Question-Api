Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "api/questions" => "question#save_question", defaults: { format: "json" }
  get "api_questions/:token" => "question#get_question", defaults: { format: "json" }
  get "api_questions/:token/ans" => "question#get_answer"
end
