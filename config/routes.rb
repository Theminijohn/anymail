Rails.application.routes.draw do

  root 'pages#home'

  # Testing Pages
  get 'send' => 'send_me_stuff#home'

  # Simple Email
  get 'send/simple_send' => 'send_me_stuff#simple_send'

end
