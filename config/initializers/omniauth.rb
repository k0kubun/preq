Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'e484eb4a84a86e4f8267', '6b096615a2bfc91d9a8e8f0808216073d760f1fb'
end
